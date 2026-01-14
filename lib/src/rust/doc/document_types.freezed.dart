// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BlockActionDoc {

 BlockActionTypeDoc get action; BlockDoc get block; Uint32List get path; Uint32List? get oldPath;
/// Create a copy of BlockActionDoc
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockActionDocCopyWith<BlockActionDoc> get copyWith => _$BlockActionDocCopyWithImpl<BlockActionDoc>(this as BlockActionDoc, _$identity);

  /// Serializes this BlockActionDoc to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockActionDoc&&(identical(other.action, action) || other.action == action)&&(identical(other.block, block) || other.block == block)&&const DeepCollectionEquality().equals(other.path, path)&&const DeepCollectionEquality().equals(other.oldPath, oldPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,block,const DeepCollectionEquality().hash(path),const DeepCollectionEquality().hash(oldPath));

@override
String toString() {
  return 'BlockActionDoc(action: $action, block: $block, path: $path, oldPath: $oldPath)';
}


}

/// @nodoc
abstract mixin class $BlockActionDocCopyWith<$Res>  {
  factory $BlockActionDocCopyWith(BlockActionDoc value, $Res Function(BlockActionDoc) _then) = _$BlockActionDocCopyWithImpl;
@useResult
$Res call({
 BlockActionTypeDoc action, BlockDoc block, Uint32List path, Uint32List? oldPath
});


$BlockDocCopyWith<$Res> get block;

}
/// @nodoc
class _$BlockActionDocCopyWithImpl<$Res>
    implements $BlockActionDocCopyWith<$Res> {
  _$BlockActionDocCopyWithImpl(this._self, this._then);

  final BlockActionDoc _self;
  final $Res Function(BlockActionDoc) _then;

/// Create a copy of BlockActionDoc
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? block = null,Object? path = null,Object? oldPath = freezed,}) {
  return _then(_self.copyWith(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as BlockActionTypeDoc,block: null == block ? _self.block : block // ignore: cast_nullable_to_non_nullable
as BlockDoc,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as Uint32List,oldPath: freezed == oldPath ? _self.oldPath : oldPath // ignore: cast_nullable_to_non_nullable
as Uint32List?,
  ));
}
/// Create a copy of BlockActionDoc
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlockDocCopyWith<$Res> get block {
  
  return $BlockDocCopyWith<$Res>(_self.block, (value) {
    return _then(_self.copyWith(block: value));
  });
}
}


/// Adds pattern-matching-related methods to [BlockActionDoc].
extension BlockActionDocPatterns on BlockActionDoc {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlockActionDoc value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlockActionDoc() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlockActionDoc value)  $default,){
final _that = this;
switch (_that) {
case _BlockActionDoc():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlockActionDoc value)?  $default,){
final _that = this;
switch (_that) {
case _BlockActionDoc() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlockActionTypeDoc action,  BlockDoc block,  Uint32List path,  Uint32List? oldPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlockActionDoc() when $default != null:
return $default(_that.action,_that.block,_that.path,_that.oldPath);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlockActionTypeDoc action,  BlockDoc block,  Uint32List path,  Uint32List? oldPath)  $default,) {final _that = this;
switch (_that) {
case _BlockActionDoc():
return $default(_that.action,_that.block,_that.path,_that.oldPath);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlockActionTypeDoc action,  BlockDoc block,  Uint32List path,  Uint32List? oldPath)?  $default,) {final _that = this;
switch (_that) {
case _BlockActionDoc() when $default != null:
return $default(_that.action,_that.block,_that.path,_that.oldPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlockActionDoc implements BlockActionDoc {
  const _BlockActionDoc({required this.action, required this.block, required this.path, this.oldPath});
  factory _BlockActionDoc.fromJson(Map<String, dynamic> json) => _$BlockActionDocFromJson(json);

@override final  BlockActionTypeDoc action;
@override final  BlockDoc block;
@override final  Uint32List path;
@override final  Uint32List? oldPath;

/// Create a copy of BlockActionDoc
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockActionDocCopyWith<_BlockActionDoc> get copyWith => __$BlockActionDocCopyWithImpl<_BlockActionDoc>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlockActionDocToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlockActionDoc&&(identical(other.action, action) || other.action == action)&&(identical(other.block, block) || other.block == block)&&const DeepCollectionEquality().equals(other.path, path)&&const DeepCollectionEquality().equals(other.oldPath, oldPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,block,const DeepCollectionEquality().hash(path),const DeepCollectionEquality().hash(oldPath));

@override
String toString() {
  return 'BlockActionDoc(action: $action, block: $block, path: $path, oldPath: $oldPath)';
}


}

/// @nodoc
abstract mixin class _$BlockActionDocCopyWith<$Res> implements $BlockActionDocCopyWith<$Res> {
  factory _$BlockActionDocCopyWith(_BlockActionDoc value, $Res Function(_BlockActionDoc) _then) = __$BlockActionDocCopyWithImpl;
@override @useResult
$Res call({
 BlockActionTypeDoc action, BlockDoc block, Uint32List path, Uint32List? oldPath
});


@override $BlockDocCopyWith<$Res> get block;

}
/// @nodoc
class __$BlockActionDocCopyWithImpl<$Res>
    implements _$BlockActionDocCopyWith<$Res> {
  __$BlockActionDocCopyWithImpl(this._self, this._then);

  final _BlockActionDoc _self;
  final $Res Function(_BlockActionDoc) _then;

/// Create a copy of BlockActionDoc
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? action = null,Object? block = null,Object? path = null,Object? oldPath = freezed,}) {
  return _then(_BlockActionDoc(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as BlockActionTypeDoc,block: null == block ? _self.block : block // ignore: cast_nullable_to_non_nullable
as BlockDoc,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as Uint32List,oldPath: freezed == oldPath ? _self.oldPath : oldPath // ignore: cast_nullable_to_non_nullable
as Uint32List?,
  ));
}

/// Create a copy of BlockActionDoc
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BlockDocCopyWith<$Res> get block {
  
  return $BlockDocCopyWith<$Res>(_self.block, (value) {
    return _then(_self.copyWith(block: value));
  });
}
}


/// @nodoc
mixin _$BlockDoc {

 String get id; String get ty; Map<String, String> get attributes; String? get delta; String? get parentId; String? get prevId; String? get nextId; String? get oldParentId;
/// Create a copy of BlockDoc
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockDocCopyWith<BlockDoc> get copyWith => _$BlockDocCopyWithImpl<BlockDoc>(this as BlockDoc, _$identity);

  /// Serializes this BlockDoc to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockDoc&&(identical(other.id, id) || other.id == id)&&(identical(other.ty, ty) || other.ty == ty)&&const DeepCollectionEquality().equals(other.attributes, attributes)&&(identical(other.delta, delta) || other.delta == delta)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.prevId, prevId) || other.prevId == prevId)&&(identical(other.nextId, nextId) || other.nextId == nextId)&&(identical(other.oldParentId, oldParentId) || other.oldParentId == oldParentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ty,const DeepCollectionEquality().hash(attributes),delta,parentId,prevId,nextId,oldParentId);

@override
String toString() {
  return 'BlockDoc(id: $id, ty: $ty, attributes: $attributes, delta: $delta, parentId: $parentId, prevId: $prevId, nextId: $nextId, oldParentId: $oldParentId)';
}


}

/// @nodoc
abstract mixin class $BlockDocCopyWith<$Res>  {
  factory $BlockDocCopyWith(BlockDoc value, $Res Function(BlockDoc) _then) = _$BlockDocCopyWithImpl;
@useResult
$Res call({
 String id, String ty, Map<String, String> attributes, String? delta, String? parentId, String? prevId, String? nextId, String? oldParentId
});




}
/// @nodoc
class _$BlockDocCopyWithImpl<$Res>
    implements $BlockDocCopyWith<$Res> {
  _$BlockDocCopyWithImpl(this._self, this._then);

  final BlockDoc _self;
  final $Res Function(BlockDoc) _then;

/// Create a copy of BlockDoc
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ty = null,Object? attributes = null,Object? delta = freezed,Object? parentId = freezed,Object? prevId = freezed,Object? nextId = freezed,Object? oldParentId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ty: null == ty ? _self.ty : ty // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, String>,delta: freezed == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,prevId: freezed == prevId ? _self.prevId : prevId // ignore: cast_nullable_to_non_nullable
as String?,nextId: freezed == nextId ? _self.nextId : nextId // ignore: cast_nullable_to_non_nullable
as String?,oldParentId: freezed == oldParentId ? _self.oldParentId : oldParentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BlockDoc].
extension BlockDocPatterns on BlockDoc {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlockDoc value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlockDoc() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlockDoc value)  $default,){
final _that = this;
switch (_that) {
case _BlockDoc():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlockDoc value)?  $default,){
final _that = this;
switch (_that) {
case _BlockDoc() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ty,  Map<String, String> attributes,  String? delta,  String? parentId,  String? prevId,  String? nextId,  String? oldParentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlockDoc() when $default != null:
return $default(_that.id,_that.ty,_that.attributes,_that.delta,_that.parentId,_that.prevId,_that.nextId,_that.oldParentId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ty,  Map<String, String> attributes,  String? delta,  String? parentId,  String? prevId,  String? nextId,  String? oldParentId)  $default,) {final _that = this;
switch (_that) {
case _BlockDoc():
return $default(_that.id,_that.ty,_that.attributes,_that.delta,_that.parentId,_that.prevId,_that.nextId,_that.oldParentId);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ty,  Map<String, String> attributes,  String? delta,  String? parentId,  String? prevId,  String? nextId,  String? oldParentId)?  $default,) {final _that = this;
switch (_that) {
case _BlockDoc() when $default != null:
return $default(_that.id,_that.ty,_that.attributes,_that.delta,_that.parentId,_that.prevId,_that.nextId,_that.oldParentId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlockDoc implements BlockDoc {
  const _BlockDoc({required this.id, required this.ty, required final  Map<String, String> attributes, this.delta, this.parentId, this.prevId, this.nextId, this.oldParentId}): _attributes = attributes;
  factory _BlockDoc.fromJson(Map<String, dynamic> json) => _$BlockDocFromJson(json);

@override final  String id;
@override final  String ty;
 final  Map<String, String> _attributes;
@override Map<String, String> get attributes {
  if (_attributes is EqualUnmodifiableMapView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_attributes);
}

@override final  String? delta;
@override final  String? parentId;
@override final  String? prevId;
@override final  String? nextId;
@override final  String? oldParentId;

/// Create a copy of BlockDoc
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockDocCopyWith<_BlockDoc> get copyWith => __$BlockDocCopyWithImpl<_BlockDoc>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlockDocToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlockDoc&&(identical(other.id, id) || other.id == id)&&(identical(other.ty, ty) || other.ty == ty)&&const DeepCollectionEquality().equals(other._attributes, _attributes)&&(identical(other.delta, delta) || other.delta == delta)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.prevId, prevId) || other.prevId == prevId)&&(identical(other.nextId, nextId) || other.nextId == nextId)&&(identical(other.oldParentId, oldParentId) || other.oldParentId == oldParentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ty,const DeepCollectionEquality().hash(_attributes),delta,parentId,prevId,nextId,oldParentId);

@override
String toString() {
  return 'BlockDoc(id: $id, ty: $ty, attributes: $attributes, delta: $delta, parentId: $parentId, prevId: $prevId, nextId: $nextId, oldParentId: $oldParentId)';
}


}

/// @nodoc
abstract mixin class _$BlockDocCopyWith<$Res> implements $BlockDocCopyWith<$Res> {
  factory _$BlockDocCopyWith(_BlockDoc value, $Res Function(_BlockDoc) _then) = __$BlockDocCopyWithImpl;
@override @useResult
$Res call({
 String id, String ty, Map<String, String> attributes, String? delta, String? parentId, String? prevId, String? nextId, String? oldParentId
});




}
/// @nodoc
class __$BlockDocCopyWithImpl<$Res>
    implements _$BlockDocCopyWith<$Res> {
  __$BlockDocCopyWithImpl(this._self, this._then);

  final _BlockDoc _self;
  final $Res Function(_BlockDoc) _then;

/// Create a copy of BlockDoc
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ty = null,Object? attributes = null,Object? delta = freezed,Object? parentId = freezed,Object? prevId = freezed,Object? nextId = freezed,Object? oldParentId = freezed,}) {
  return _then(_BlockDoc(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ty: null == ty ? _self.ty : ty // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, String>,delta: freezed == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,prevId: freezed == prevId ? _self.prevId : prevId // ignore: cast_nullable_to_non_nullable
as String?,nextId: freezed == nextId ? _self.nextId : nextId // ignore: cast_nullable_to_non_nullable
as String?,oldParentId: freezed == oldParentId ? _self.oldParentId : oldParentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DocumentState {

 String get docId; Map<String, BlockDoc> get blocks; Map<String, List<String>> get childrenMap; String get rootId;
/// Create a copy of DocumentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentStateCopyWith<DocumentState> get copyWith => _$DocumentStateCopyWithImpl<DocumentState>(this as DocumentState, _$identity);

  /// Serializes this DocumentState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentState&&(identical(other.docId, docId) || other.docId == docId)&&const DeepCollectionEquality().equals(other.blocks, blocks)&&const DeepCollectionEquality().equals(other.childrenMap, childrenMap)&&(identical(other.rootId, rootId) || other.rootId == rootId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,docId,const DeepCollectionEquality().hash(blocks),const DeepCollectionEquality().hash(childrenMap),rootId);

@override
String toString() {
  return 'DocumentState(docId: $docId, blocks: $blocks, childrenMap: $childrenMap, rootId: $rootId)';
}


}

/// @nodoc
abstract mixin class $DocumentStateCopyWith<$Res>  {
  factory $DocumentStateCopyWith(DocumentState value, $Res Function(DocumentState) _then) = _$DocumentStateCopyWithImpl;
@useResult
$Res call({
 String docId, Map<String, BlockDoc> blocks, Map<String, List<String>> childrenMap, String rootId
});




}
/// @nodoc
class _$DocumentStateCopyWithImpl<$Res>
    implements $DocumentStateCopyWith<$Res> {
  _$DocumentStateCopyWithImpl(this._self, this._then);

  final DocumentState _self;
  final $Res Function(DocumentState) _then;

/// Create a copy of DocumentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? docId = null,Object? blocks = null,Object? childrenMap = null,Object? rootId = null,}) {
  return _then(_self.copyWith(
docId: null == docId ? _self.docId : docId // ignore: cast_nullable_to_non_nullable
as String,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as Map<String, BlockDoc>,childrenMap: null == childrenMap ? _self.childrenMap : childrenMap // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,rootId: null == rootId ? _self.rootId : rootId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentState].
extension DocumentStatePatterns on DocumentState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentState value)  $default,){
final _that = this;
switch (_that) {
case _DocumentState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentState value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String docId,  Map<String, BlockDoc> blocks,  Map<String, List<String>> childrenMap,  String rootId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentState() when $default != null:
return $default(_that.docId,_that.blocks,_that.childrenMap,_that.rootId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String docId,  Map<String, BlockDoc> blocks,  Map<String, List<String>> childrenMap,  String rootId)  $default,) {final _that = this;
switch (_that) {
case _DocumentState():
return $default(_that.docId,_that.blocks,_that.childrenMap,_that.rootId);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String docId,  Map<String, BlockDoc> blocks,  Map<String, List<String>> childrenMap,  String rootId)?  $default,) {final _that = this;
switch (_that) {
case _DocumentState() when $default != null:
return $default(_that.docId,_that.blocks,_that.childrenMap,_that.rootId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentState implements DocumentState {
  const _DocumentState({required this.docId, required final  Map<String, BlockDoc> blocks, required final  Map<String, List<String>> childrenMap, required this.rootId}): _blocks = blocks,_childrenMap = childrenMap;
  factory _DocumentState.fromJson(Map<String, dynamic> json) => _$DocumentStateFromJson(json);

@override final  String docId;
 final  Map<String, BlockDoc> _blocks;
@override Map<String, BlockDoc> get blocks {
  if (_blocks is EqualUnmodifiableMapView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_blocks);
}

 final  Map<String, List<String>> _childrenMap;
@override Map<String, List<String>> get childrenMap {
  if (_childrenMap is EqualUnmodifiableMapView) return _childrenMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_childrenMap);
}

@override final  String rootId;

/// Create a copy of DocumentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentStateCopyWith<_DocumentState> get copyWith => __$DocumentStateCopyWithImpl<_DocumentState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentState&&(identical(other.docId, docId) || other.docId == docId)&&const DeepCollectionEquality().equals(other._blocks, _blocks)&&const DeepCollectionEquality().equals(other._childrenMap, _childrenMap)&&(identical(other.rootId, rootId) || other.rootId == rootId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,docId,const DeepCollectionEquality().hash(_blocks),const DeepCollectionEquality().hash(_childrenMap),rootId);

@override
String toString() {
  return 'DocumentState(docId: $docId, blocks: $blocks, childrenMap: $childrenMap, rootId: $rootId)';
}


}

/// @nodoc
abstract mixin class _$DocumentStateCopyWith<$Res> implements $DocumentStateCopyWith<$Res> {
  factory _$DocumentStateCopyWith(_DocumentState value, $Res Function(_DocumentState) _then) = __$DocumentStateCopyWithImpl;
@override @useResult
$Res call({
 String docId, Map<String, BlockDoc> blocks, Map<String, List<String>> childrenMap, String rootId
});




}
/// @nodoc
class __$DocumentStateCopyWithImpl<$Res>
    implements _$DocumentStateCopyWith<$Res> {
  __$DocumentStateCopyWithImpl(this._self, this._then);

  final _DocumentState _self;
  final $Res Function(_DocumentState) _then;

/// Create a copy of DocumentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? docId = null,Object? blocks = null,Object? childrenMap = null,Object? rootId = null,}) {
  return _then(_DocumentState(
docId: null == docId ? _self.docId : docId // ignore: cast_nullable_to_non_nullable
as String,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as Map<String, BlockDoc>,childrenMap: null == childrenMap ? _self._childrenMap : childrenMap // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,rootId: null == rootId ? _self.rootId : rootId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FailedToDecodeUpdates {

 List<String> get failedUpdatesIds;
/// Create a copy of FailedToDecodeUpdates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailedToDecodeUpdatesCopyWith<FailedToDecodeUpdates> get copyWith => _$FailedToDecodeUpdatesCopyWithImpl<FailedToDecodeUpdates>(this as FailedToDecodeUpdates, _$identity);

  /// Serializes this FailedToDecodeUpdates to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailedToDecodeUpdates&&const DeepCollectionEquality().equals(other.failedUpdatesIds, failedUpdatesIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(failedUpdatesIds));

@override
String toString() {
  return 'FailedToDecodeUpdates(failedUpdatesIds: $failedUpdatesIds)';
}


}

/// @nodoc
abstract mixin class $FailedToDecodeUpdatesCopyWith<$Res>  {
  factory $FailedToDecodeUpdatesCopyWith(FailedToDecodeUpdates value, $Res Function(FailedToDecodeUpdates) _then) = _$FailedToDecodeUpdatesCopyWithImpl;
@useResult
$Res call({
 List<String> failedUpdatesIds
});




}
/// @nodoc
class _$FailedToDecodeUpdatesCopyWithImpl<$Res>
    implements $FailedToDecodeUpdatesCopyWith<$Res> {
  _$FailedToDecodeUpdatesCopyWithImpl(this._self, this._then);

  final FailedToDecodeUpdates _self;
  final $Res Function(FailedToDecodeUpdates) _then;

/// Create a copy of FailedToDecodeUpdates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? failedUpdatesIds = null,}) {
  return _then(_self.copyWith(
failedUpdatesIds: null == failedUpdatesIds ? _self.failedUpdatesIds : failedUpdatesIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [FailedToDecodeUpdates].
extension FailedToDecodeUpdatesPatterns on FailedToDecodeUpdates {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FailedToDecodeUpdates value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FailedToDecodeUpdates() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FailedToDecodeUpdates value)  $default,){
final _that = this;
switch (_that) {
case _FailedToDecodeUpdates():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FailedToDecodeUpdates value)?  $default,){
final _that = this;
switch (_that) {
case _FailedToDecodeUpdates() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> failedUpdatesIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FailedToDecodeUpdates() when $default != null:
return $default(_that.failedUpdatesIds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> failedUpdatesIds)  $default,) {final _that = this;
switch (_that) {
case _FailedToDecodeUpdates():
return $default(_that.failedUpdatesIds);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> failedUpdatesIds)?  $default,) {final _that = this;
switch (_that) {
case _FailedToDecodeUpdates() when $default != null:
return $default(_that.failedUpdatesIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FailedToDecodeUpdates implements FailedToDecodeUpdates {
  const _FailedToDecodeUpdates({required final  List<String> failedUpdatesIds}): _failedUpdatesIds = failedUpdatesIds;
  factory _FailedToDecodeUpdates.fromJson(Map<String, dynamic> json) => _$FailedToDecodeUpdatesFromJson(json);

 final  List<String> _failedUpdatesIds;
@override List<String> get failedUpdatesIds {
  if (_failedUpdatesIds is EqualUnmodifiableListView) return _failedUpdatesIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_failedUpdatesIds);
}


/// Create a copy of FailedToDecodeUpdates
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailedToDecodeUpdatesCopyWith<_FailedToDecodeUpdates> get copyWith => __$FailedToDecodeUpdatesCopyWithImpl<_FailedToDecodeUpdates>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FailedToDecodeUpdatesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FailedToDecodeUpdates&&const DeepCollectionEquality().equals(other._failedUpdatesIds, _failedUpdatesIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_failedUpdatesIds));

@override
String toString() {
  return 'FailedToDecodeUpdates(failedUpdatesIds: $failedUpdatesIds)';
}


}

/// @nodoc
abstract mixin class _$FailedToDecodeUpdatesCopyWith<$Res> implements $FailedToDecodeUpdatesCopyWith<$Res> {
  factory _$FailedToDecodeUpdatesCopyWith(_FailedToDecodeUpdates value, $Res Function(_FailedToDecodeUpdates) _then) = __$FailedToDecodeUpdatesCopyWithImpl;
@override @useResult
$Res call({
 List<String> failedUpdatesIds
});




}
/// @nodoc
class __$FailedToDecodeUpdatesCopyWithImpl<$Res>
    implements _$FailedToDecodeUpdatesCopyWith<$Res> {
  __$FailedToDecodeUpdatesCopyWithImpl(this._self, this._then);

  final _FailedToDecodeUpdates _self;
  final $Res Function(_FailedToDecodeUpdates) _then;

/// Create a copy of FailedToDecodeUpdates
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? failedUpdatesIds = null,}) {
  return _then(_FailedToDecodeUpdates(
failedUpdatesIds: null == failedUpdatesIds ? _self._failedUpdatesIds : failedUpdatesIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
