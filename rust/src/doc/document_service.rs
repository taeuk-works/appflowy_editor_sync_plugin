use flutter_rust_bridge::{frb, DartFnFuture};
use log::{error, info};
use serde_json::{json, Value as JsonValue};
use yrs::{merge_updates_v2, Array, Doc, Map, ReadTxn, Transact};

use super::error::DocError;
use super::operations::{block_ops::BlockOperations, delta_ops::DeltaOperations, update_ops::UpdateOperations};

use crate::doc::constants::{BLOCKS, DEFAULT_PARENT, META, ROOT_ID};
use crate::doc::document_types::{BlockActionDoc, BlockActionTypeDoc, CustomRustError, DocumentState, FailedToDecodeUpdates};
use crate::doc::utils::util::MapExt;
use crate::{log_info, log_error};


#[frb]
pub struct DocumentService {
    doc: Doc,
    doc_id: String,
}

impl DocumentService {

    #[frb]
    pub fn new() -> Self {
        log_info!("Creating new document service");
        let doc_id = "xxxx".to_string();
        Self { doc_id, doc: Doc::new() }
    }

    #[no_mangle]
    #[inline(never)]
    #[frb]
    pub fn init_empty_doc(&mut self) -> Result<Vec<u8>, CustomRustError> {
        log_info!("init_empty_doc: Starting for doc_id: {}", self.doc_id);
        
        // Get a reference to the document
        let doc = &self.doc;
        let root = doc.get_or_insert_map(ROOT_ID);
        let mut txn = doc.transact_mut();

        // Initialize the document structure
        log_info!("init_empty_doc: Initializing blocks for doc_id: {}", self.doc_id);
        root.get_or_init_map(&mut txn, BLOCKS);
        
        
        // Create the empty state update
        log_info!("init_empty_doc: Encoding state for doc_id: {}", self.doc_id);
        let empty_state = yrs::StateVector::default();
        let update = txn.encode_state_as_update_v2(&empty_state);
        
        log_info!("init_empty_doc: Finished for doc_id: {}", self.doc_id);
        Ok(update)
    }

    /// 현재 문서의 전체 상태를 인코딩하여 반환
    #[no_mangle]
    #[inline(never)]
    #[frb]
    pub fn encode_full_state(&self) -> Result<Vec<u8>, CustomRustError> {
        let doc = &self.doc;
        let txn = doc.transact();
        let empty_state = yrs::StateVector::default();
        let update = txn.encode_state_as_update_v2(&empty_state);
        Ok(update)
    }

    #[no_mangle]
#[inline(never)]
#[frb]
pub fn apply_action(
    &mut self,
    actions: Vec<BlockActionDoc>,
) -> Result<Vec<u8>, CustomRustError> {
    log_info!("apply_action: Starting with {} actions for doc_id: {}", 
             actions.len(), self.doc_id);
    
    // Get document handle and start transaction
    let doc = &self.doc;
    let root = doc.get_or_insert_map(ROOT_ID);
    let mut txn = doc.transact_mut();
    
    // Process each action
    for action in actions {
        let blocks_map = root.get_or_init_map(&mut txn, BLOCKS);
        
        // Delegate to specialized operation handlers
        match action.action {
            BlockActionTypeDoc::Insert => {
                BlockOperations::insert_node(&mut txn, blocks_map, action)?;
            },
            BlockActionTypeDoc::Update => {
                BlockOperations::update_node(&mut txn, blocks_map, action)?;
            },
            BlockActionTypeDoc::Delete => {
                let parent_id = action.block.parent_id
                    .unwrap_or_else(|| DEFAULT_PARENT.to_owned());
                
                BlockOperations::delete_node(&mut txn, blocks_map, &action.block.id, &parent_id)?;
            },
            BlockActionTypeDoc::Move => {
                if let (Some(old_path), Some(parent_id), Some(old_parent_id)) = 
                    (action.old_path.as_ref(), action.block.parent_id.as_ref(), action.block.old_parent_id.as_ref()) {
                    BlockOperations::move_block(
                        &mut txn, blocks_map,
                        old_path, &action.path, parent_id, old_parent_id,
                        &action.block.id, action.block.prev_id, action.block.next_id
                    )?;
                } else {
                    return Err(DocError::InvalidOperation("Missing required fields for move operation".into()).into());
                }
            }
        }
    }
    
    // Generate update from the transaction
    log_info!("apply_action: Encoding state for doc_id: {}", self.doc_id);
    let before_state = txn.before_state();
    let update = txn.encode_diff_v2(before_state);
    
    Ok(update)
}

    #[no_mangle]
    #[inline(never)]
    #[frb]
    pub fn apply_updates(&mut self, updates: Vec<Vec<u8>>) -> Result<(), CustomRustError> {
        log_info!("apply_updates: Starting with {} updates for doc_id: {}", updates.len(), self.doc_id);

        // Create a new document to apply updates to
        let new_doc = Doc::new();

        // Apply updates to the new document
        let result = UpdateOperations::apply_updates_inner(new_doc.clone(), &self.doc_id, updates)?;

        // Replace the current document with the new one
        self.doc = new_doc;

        // Debug: Check root map structure after update
        {
            let txn = self.doc.transact();
            if let Some(root) = txn.get_map(ROOT_ID) {
                let keys: Vec<String> = root.keys(&txn).map(|k| k.to_string()).collect();
                log_info!("apply_updates: root keys after update = {:?}", keys);

                if let Some(yrs::Value::YMap(meta)) = root.get(&txn, META) {
                    let meta_keys: Vec<String> = meta.keys(&txn).map(|k| k.to_string()).collect();
                    log_info!("apply_updates: meta keys = {:?}", meta_keys);
                } else {
                    log_info!("apply_updates: META map not found in root!");
                }
            } else {
                log_info!("apply_updates: ROOT map not found!");
            }
        }

        log_info!("apply_updates: Successfully applied updates for doc_id: {}", self.doc_id);
        Ok(result)
    }

    #[no_mangle]
    #[inline(never)]
    #[frb]
    pub fn get_document_state(&self) -> Result<DocumentState, CustomRustError> {
        log_info!("get_document_state: Starting for doc_id: {}", self.doc_id);
        
        let doc = &self.doc;
        let root = doc.get_or_insert_map(ROOT_ID);
        let txn = doc.transact();
        
        // Extract document state through specialized function
        let state = UpdateOperations::extract_document_state(&txn, root, &self.doc_id)?;
        
        log_info!("get_document_state: Finished for doc_id: {}", self.doc_id);
        Ok(state)
    }

    #[frb]
    pub fn merge_updates(&self, updates: Vec<Vec<u8>>) -> Result<Vec<u8>, CustomRustError> {
        log_info!("merge_updates: Merging {} updates", updates.len());
        
        match merge_updates_v2(updates) {
            Ok(update) => {
                log_info!("merge_updates: Successfully merged updates");
                Ok(update)
            },
            Err(e) => {
                log_error!("merge_updates: Failed to merge updates: {}", e);
                Err(DocError::EncodingError(format!("Failed to merge updates: {}", e)).into())
            }
        }
    }

    #[no_mangle]
    #[inline(never)]
    #[frb]
    /// Setting a root node id in the root map
    pub fn set_root_node_id(&mut self, id: String) -> Result<Vec<u8>, CustomRustError> {
        log_info!("set_root_node_id: Setting root node id to {}", id);

        let doc = &self.doc;
        let root = doc.get_or_insert_map(ROOT_ID);
        let mut txn = doc.transact_mut();
        root.insert(&mut txn, ROOT_ID, id.clone());
        log_info!("set_root_node_id: Successfully set root node id to {}", id);

        // Encode the state as an update
        let before_state = txn.before_state();
        let update = txn.encode_diff_v2(before_state);
        log_info!("set_root_node_id: Finished for doc_id: {}", self.doc_id);
        Ok(update)
    }

    // ============================================
    // Meta API - YDoc 메타데이터 조작
    // ============================================

    #[no_mangle]
    #[inline(never)]
    #[frb]
    /// 메타데이터에 문자열 값 설정
    ///
    /// [key] 메타데이터 키
    /// [value] 설정할 문자열 값
    pub fn set_meta_string(&mut self, key: String, value: String) -> Result<Vec<u8>, CustomRustError> {
        log_info!("set_meta_string: key={}, value={}", key, value);

        let doc = &self.doc;
        let root = doc.get_or_insert_map(ROOT_ID);
        let mut txn = doc.transact_mut();
        let meta = root.get_or_init_map(&mut txn, META);

        meta.insert(&mut txn, key.clone(), value);

        let before_state = txn.before_state();
        let update = txn.encode_diff_v2(before_state);
        log_info!("set_meta_string: Finished for key={}", key);
        Ok(update)
    }

    #[no_mangle]
    #[inline(never)]
    #[frb]
    /// 메타데이터 키 제거
    ///
    /// [key] 제거할 메타데이터 키
    pub fn remove_meta_key(&mut self, key: String) -> Result<Vec<u8>, CustomRustError> {
        log_info!("remove_meta_key: key={}", key);

        let doc = &self.doc;
        let root = doc.get_or_insert_map(ROOT_ID);
        let mut txn = doc.transact_mut();
        let meta = root.get_or_init_map(&mut txn, META);

        meta.remove(&mut txn, &key);

        let before_state = txn.before_state();
        let update = txn.encode_diff_v2(before_state);
        log_info!("remove_meta_key: Finished for key={}", key);
        Ok(update)
    }

    #[no_mangle]
    #[inline(never)]
    #[frb]
    /// 메타데이터에 정수 값 설정
    ///
    /// [key] 메타데이터 키
    /// [value] 설정할 정수 값
    pub fn set_meta_int(&mut self, key: String, value: i64) -> Result<Vec<u8>, CustomRustError> {
        log_info!("set_meta_int: key={}, value={}", key, value);

        let doc = &self.doc;
        let root = doc.get_or_insert_map(ROOT_ID);
        let mut txn = doc.transact_mut();
        let meta = root.get_or_init_map(&mut txn, META);

        meta.insert(&mut txn, key.clone(), value);

        let before_state = txn.before_state();
        let update = txn.encode_diff_v2(before_state);
        log_info!("set_meta_int: Finished for key={}", key);
        Ok(update)
    }

    #[no_mangle]
    #[inline(never)]
    #[frb]
    /// 메타데이터에 불리언 값 설정
    ///
    /// [key] 메타데이터 키
    /// [value] 설정할 불리언 값
    pub fn set_meta_bool(&mut self, key: String, value: bool) -> Result<Vec<u8>, CustomRustError> {
        log_info!("set_meta_bool: key={}, value={}", key, value);

        let doc = &self.doc;
        let root = doc.get_or_insert_map(ROOT_ID);
        let mut txn = doc.transact_mut();
        let meta = root.get_or_init_map(&mut txn, META);

        meta.insert(&mut txn, key.clone(), value);

        let before_state = txn.before_state();
        let update = txn.encode_diff_v2(before_state);
        log_info!("set_meta_bool: Finished for key={}", key);
        Ok(update)
    }

    #[no_mangle]
    #[inline(never)]
    #[frb]
    /// 메타데이터에 문자열 배열 설정 (기존 배열 전체 교체)
    ///
    /// [key] 메타데이터 키
    /// [values] 설정할 문자열 배열
    pub fn set_meta_string_array(&mut self, key: String, values: Vec<String>) -> Result<Vec<u8>, CustomRustError> {
        log_info!("set_meta_string_array: key={}, count={}", key, values.len());

        let doc = &self.doc;
        let root = doc.get_or_insert_map(ROOT_ID);
        let mut txn = doc.transact_mut();
        let meta = root.get_or_init_map(&mut txn, META);

        // 기존 배열이 있으면 제거하고 새로 생성
        meta.remove(&mut txn, &key);
        let array = meta.get_or_init_array(&mut txn, key.clone());

        for value in values {
            array.push_back(&mut txn, value);
        }

        let before_state = txn.before_state();
        let update = txn.encode_diff_v2(before_state);
        log_info!("set_meta_string_array: Finished for key={}", key);
        Ok(update)
    }

    #[no_mangle]
    #[inline(never)]
    #[frb]
    /// 메타데이터 배열에 문자열 항목 추가 (중복 체크)
    ///
    /// [key] 메타데이터 키
    /// [value] 추가할 문자열 값
    pub fn push_meta_array_item(&mut self, key: String, value: String) -> Result<Vec<u8>, CustomRustError> {
        log_info!("push_meta_array_item: key={}, value={}", key, value);

        let doc = &self.doc;
        let root = doc.get_or_insert_map(ROOT_ID);
        let mut txn = doc.transact_mut();
        let meta = root.get_or_init_map(&mut txn, META);
        let array = meta.get_or_init_array(&mut txn, key.clone());

        // 중복 체크
        let exists = array.iter(&txn).any(|v| {
            if let yrs::Value::Any(yrs::Any::String(s)) = v {
                s.as_ref() == value.as_str()
            } else {
                false
            }
        });

        if !exists {
            array.push_back(&mut txn, value.clone());
        }

        let before_state = txn.before_state();
        let update = txn.encode_diff_v2(before_state);
        log_info!("push_meta_array_item: Finished for key={}", key);
        Ok(update)
    }

    #[no_mangle]
    #[inline(never)]
    #[frb]
    /// 메타데이터 배열에서 문자열 항목 제거
    ///
    /// [key] 메타데이터 키
    /// [value] 제거할 문자열 값
    pub fn remove_meta_array_item(&mut self, key: String, value: String) -> Result<Vec<u8>, CustomRustError> {
        log_info!("remove_meta_array_item: key={}, value={}", key, value);

        let doc = &self.doc;
        let root = doc.get_or_insert_map(ROOT_ID);
        let mut txn = doc.transact_mut();
        let meta = root.get_or_init_map(&mut txn, META);

        if let Some(yrs::Value::YArray(array)) = meta.get(&txn, &key) {
            // 제거할 인덱스 찾기
            let mut index_to_remove: Option<u32> = None;
            for (i, v) in array.iter(&txn).enumerate() {
                if let yrs::Value::Any(yrs::Any::String(s)) = v {
                    if s.as_ref() == value.as_str() {
                        index_to_remove = Some(i as u32);
                        break;
                    }
                }
            }

            if let Some(index) = index_to_remove {
                array.remove(&mut txn, index);
            }
        }

        let before_state = txn.before_state();
        let update = txn.encode_diff_v2(before_state);
        log_info!("remove_meta_array_item: Finished for key={}", key);
        Ok(update)
    }

    #[no_mangle]
    #[inline(never)]
    #[frb]
    /// 모든 메타데이터를 JSON 문자열로 반환
    ///
    /// 반환: JSON 형식의 메타데이터 (예: {"title": "노트", "color": 123, "status": "active"})
    pub fn get_all_meta(&self) -> Result<String, CustomRustError> {
        log_info!("get_all_meta: Starting");

        let doc = &self.doc;
        let root = doc.get_or_insert_map(ROOT_ID);
        let txn = doc.transact();

        let mut result = serde_json::Map::new();

        if let Some(yrs::Value::YMap(meta)) = root.get(&txn, META) {
            for (key, value) in meta.iter(&txn) {
                let json_value = Self::yrs_value_to_json(&txn, value);
                result.insert(key.to_string(), json_value);
            }
        }

        let json_str = serde_json::to_string(&JsonValue::Object(result))
            .map_err(|e| DocError::EncodingError(format!("JSON serialization failed: {}", e)))?;

        log_info!("get_all_meta: Finished");
        Ok(json_str)
    }

    /// yrs::Value를 serde_json::Value로 변환
    fn yrs_value_to_json<T: ReadTxn>(txn: &T, value: yrs::Value) -> JsonValue {
        match value {
            yrs::Value::Any(any) => Self::yrs_any_to_json(any),
            yrs::Value::YArray(array) => {
                let items: Vec<JsonValue> = array.iter(txn)
                    .map(|v| Self::yrs_value_to_json(txn, v))
                    .collect();
                JsonValue::Array(items)
            }
            yrs::Value::YMap(map) => {
                let mut obj = serde_json::Map::new();
                for (k, v) in map.iter(txn) {
                    obj.insert(k.to_string(), Self::yrs_value_to_json(txn, v));
                }
                JsonValue::Object(obj)
            }
            _ => JsonValue::Null,
        }
    }

    /// yrs::Any를 serde_json::Value로 변환
    fn yrs_any_to_json(any: yrs::Any) -> JsonValue {
        match any {
            yrs::Any::Null => JsonValue::Null,
            yrs::Any::Undefined => JsonValue::Null,
            yrs::Any::Bool(b) => JsonValue::Bool(b),
            yrs::Any::Number(n) => json!(n),
            yrs::Any::BigInt(n) => json!(n),
            yrs::Any::String(s) => JsonValue::String(s.to_string()),
            yrs::Any::Array(arr) => {
                let items: Vec<JsonValue> = arr.iter()
                    .map(|v| Self::yrs_any_to_json(v.clone()))
                    .collect();
                JsonValue::Array(items)
            }
            yrs::Any::Map(map) => {
                let mut obj = serde_json::Map::new();
                for (k, v) in map.iter() {
                    obj.insert(k.clone(), Self::yrs_any_to_json(v.clone()));
                }
                JsonValue::Object(obj)
            }
            yrs::Any::Buffer(buf) => {
                // Base64 인코딩 또는 배열로 변환
                JsonValue::Array(buf.iter().map(|b| json!(*b)).collect())
            }
        }
    }

    #[no_mangle]
    #[inline(never)]
    #[frb]
    /// 여러 메타데이터 필드를 한 번에 설정 (JSON 입력)
    ///
    /// [json_str] 설정할 메타데이터 JSON (예: {"title": "노트", "status": "active"})
    ///
    /// 지원 타입: string, number (int/double), boolean, string array
    pub fn set_meta_from_json(&mut self, json_str: String) -> Result<Vec<u8>, CustomRustError> {
        log_info!("set_meta_from_json: {}", json_str);

        let json: JsonValue = serde_json::from_str(&json_str)
            .map_err(|e| DocError::EncodingError(format!("JSON parse failed: {}", e)))?;

        let obj = json.as_object()
            .ok_or_else(|| DocError::InvalidOperation("Expected JSON object".into()))?;

        let doc = &self.doc;
        let root = doc.get_or_insert_map(ROOT_ID);
        let mut txn = doc.transact_mut();
        let meta = root.get_or_init_map(&mut txn, META);

        for (key, value) in obj {
            match value {
                JsonValue::Null => { meta.remove(&mut txn, key); }
                JsonValue::Bool(b) => { meta.insert(&mut txn, key.clone(), *b); }
                JsonValue::Number(n) => {
                    if let Some(i) = n.as_i64() {
                        meta.insert(&mut txn, key.clone(), i);
                    } else if let Some(f) = n.as_f64() {
                        meta.insert(&mut txn, key.clone(), f);
                    }
                }
                JsonValue::String(s) => { meta.insert(&mut txn, key.clone(), s.clone()); }
                JsonValue::Array(arr) => {
                    // 문자열 배열로 가정
                    meta.remove(&mut txn, key);
                    let array = meta.get_or_init_array(&mut txn, key.clone());
                    for item in arr {
                        if let JsonValue::String(s) = item {
                            array.push_back(&mut txn, s.clone());
                        }
                    }
                }
                JsonValue::Object(_) => {
                    // 중첩 객체는 JSON 문자열로 저장
                    let nested_json = serde_json::to_string(value)
                        .map_err(|e| DocError::EncodingError(format!("JSON serialize failed: {}", e)))?;
                    meta.insert(&mut txn, key.clone(), nested_json);
                }
            }
        }

        let before_state = txn.before_state();
        let update = txn.encode_diff_v2(before_state);
        log_info!("set_meta_from_json: Finished");
        Ok(update)
    }
}
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_meta_save_and_load() {
        // 첫 번째 DocumentService에서 메타 저장
        let mut doc_service1 = DocumentService::new();
        doc_service1.init_empty_doc().unwrap();

        let meta_json = r#"{"title":"테스트 노트","color":4294924083,"status":"pinned","labelIds":["label1","label2"]}"#;
        let update = doc_service1.set_meta_from_json(meta_json.to_string()).unwrap();

        println!("Update size: {} bytes", update.len());

        // 메타데이터 로드
        let loaded_meta = doc_service1.get_all_meta().unwrap();
        println!("Loaded meta: {}", loaded_meta);

        assert!(loaded_meta.contains("테스트 노트"));
        assert!(loaded_meta.contains("pinned"));
    }

    #[test]
    fn test_meta_persistence_via_update() {
        // 첫 번째 DocumentService에서 메타 저장
        let mut doc_service1 = DocumentService::new();
        let init_update = doc_service1.init_empty_doc().unwrap();
        println!("Init update size: {} bytes", init_update.len());

        let meta_json = r#"{"title":"지속성 테스트","color":4289449455,"status":"pinned","labelIds":["persist-label"]}"#;
        let meta_update = doc_service1.set_meta_from_json(meta_json.to_string()).unwrap();
        println!("Meta update size: {} bytes", meta_update.len());

        // 전체 상태를 가져오기 (encode_state_as_update_v2)
        let full_state = doc_service1.encode_full_state().unwrap();
        println!("Full state size: {} bytes", full_state.len());

        // 두 번째 DocumentService에서 전체 상태 적용 후 로드
        let mut doc_service2 = DocumentService::new();
        // init_empty_doc을 호출하지 않고 바로 update 적용
        doc_service2.apply_updates(vec![full_state]).unwrap();

        let loaded_meta = doc_service2.get_all_meta().unwrap();
        println!("Loaded meta from doc2: {}", loaded_meta);

        assert!(loaded_meta.contains("지속성 테스트"), "title should be present");
        assert!(loaded_meta.contains("pinned"), "status should be present");
        assert!(loaded_meta.contains("persist-label"), "labelIds should be present");
    }
}
