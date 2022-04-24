// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'group_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupDefinition _$GroupDefinitionFromJson(Map<String, dynamic> json) {
  return _GroupDefinition.fromJson(json);
}

/// @nodoc
mixin _$GroupDefinition {
  @JsonKey(name: 'definition', required: true, disallowNullValue: true)
  Map<String, dynamic> get groupDefinitionMap =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupDefinitionCopyWith<GroupDefinition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupDefinitionCopyWith<$Res> {
  factory $GroupDefinitionCopyWith(
          GroupDefinition value, $Res Function(GroupDefinition) then) =
      _$GroupDefinitionCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'definition', required: true, disallowNullValue: true)
          Map<String, dynamic> groupDefinitionMap});
}

/// @nodoc
class _$GroupDefinitionCopyWithImpl<$Res>
    implements $GroupDefinitionCopyWith<$Res> {
  _$GroupDefinitionCopyWithImpl(this._value, this._then);

  final GroupDefinition _value;
  // ignore: unused_field
  final $Res Function(GroupDefinition) _then;

  @override
  $Res call({
    Object? groupDefinitionMap = freezed,
  }) {
    return _then(_value.copyWith(
      groupDefinitionMap: groupDefinitionMap == freezed
          ? _value.groupDefinitionMap
          : groupDefinitionMap // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$GroupDefinitionCopyWith<$Res>
    implements $GroupDefinitionCopyWith<$Res> {
  factory _$GroupDefinitionCopyWith(
          _GroupDefinition value, $Res Function(_GroupDefinition) then) =
      __$GroupDefinitionCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'definition', required: true, disallowNullValue: true)
          Map<String, dynamic> groupDefinitionMap});
}

/// @nodoc
class __$GroupDefinitionCopyWithImpl<$Res>
    extends _$GroupDefinitionCopyWithImpl<$Res>
    implements _$GroupDefinitionCopyWith<$Res> {
  __$GroupDefinitionCopyWithImpl(
      _GroupDefinition _value, $Res Function(_GroupDefinition) _then)
      : super(_value, (v) => _then(v as _GroupDefinition));

  @override
  _GroupDefinition get _value => super._value as _GroupDefinition;

  @override
  $Res call({
    Object? groupDefinitionMap = freezed,
  }) {
    return _then(_GroupDefinition(
      groupDefinitionMap: groupDefinitionMap == freezed
          ? _value.groupDefinitionMap
          : groupDefinitionMap // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GroupDefinition implements _GroupDefinition {
  const _$_GroupDefinition(
      {@JsonKey(name: 'definition', required: true, disallowNullValue: true)
          required final Map<String, dynamic> groupDefinitionMap})
      : _groupDefinitionMap = groupDefinitionMap;

  factory _$_GroupDefinition.fromJson(Map<String, dynamic> json) =>
      _$$_GroupDefinitionFromJson(json);

  @JsonKey(name: 'definition', required: true, disallowNullValue: true)
  final Map<String, dynamic> _groupDefinitionMap;
  @override
  @JsonKey(name: 'definition', required: true, disallowNullValue: true)
  Map<String, dynamic> get groupDefinitionMap {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_groupDefinitionMap);
  }

  @override
  String toString() {
    return 'GroupDefinition(groupDefinitionMap: $groupDefinitionMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GroupDefinition &&
            const DeepCollectionEquality()
                .equals(other.groupDefinitionMap, groupDefinitionMap));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(groupDefinitionMap));

  @JsonKey(ignore: true)
  @override
  _$GroupDefinitionCopyWith<_GroupDefinition> get copyWith =>
      __$GroupDefinitionCopyWithImpl<_GroupDefinition>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupDefinitionToJson(this);
  }
}

abstract class _GroupDefinition implements GroupDefinition {
  const factory _GroupDefinition(
          {@JsonKey(name: 'definition', required: true, disallowNullValue: true)
              required final Map<String, dynamic> groupDefinitionMap}) =
      _$_GroupDefinition;

  factory _GroupDefinition.fromJson(Map<String, dynamic> json) =
      _$_GroupDefinition.fromJson;

  @override
  @JsonKey(name: 'definition', required: true, disallowNullValue: true)
  Map<String, dynamic> get groupDefinitionMap =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GroupDefinitionCopyWith<_GroupDefinition> get copyWith =>
      throw _privateConstructorUsedError;
}
