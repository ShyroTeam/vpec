// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'full_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FullScheduleTearOff {
  const _$FullScheduleTearOff();

  _FullSchedule call(
      {required String jsonData,
      required String groups,
      required Map<String, dynamic> schedule,
      required Map<String, dynamic> timetable,
      required Map<String, dynamic> groupDefinition}) {
    return _FullSchedule(
      jsonData: jsonData,
      groups: groups,
      schedule: schedule,
      timetable: timetable,
      groupDefinition: groupDefinition,
    );
  }
}

/// @nodoc
const $FullSchedule = _$FullScheduleTearOff();

/// @nodoc
mixin _$FullSchedule {
  String get jsonData => throw _privateConstructorUsedError;
  String get groups => throw _privateConstructorUsedError;
  Map<String, dynamic> get schedule => throw _privateConstructorUsedError;
  Map<String, dynamic> get timetable => throw _privateConstructorUsedError;
  Map<String, dynamic> get groupDefinition =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FullScheduleCopyWith<FullSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FullScheduleCopyWith<$Res> {
  factory $FullScheduleCopyWith(
          FullSchedule value, $Res Function(FullSchedule) then) =
      _$FullScheduleCopyWithImpl<$Res>;
  $Res call(
      {String jsonData,
      String groups,
      Map<String, dynamic> schedule,
      Map<String, dynamic> timetable,
      Map<String, dynamic> groupDefinition});
}

/// @nodoc
class _$FullScheduleCopyWithImpl<$Res> implements $FullScheduleCopyWith<$Res> {
  _$FullScheduleCopyWithImpl(this._value, this._then);

  final FullSchedule _value;
  // ignore: unused_field
  final $Res Function(FullSchedule) _then;

  @override
  $Res call({
    Object? jsonData = freezed,
    Object? groups = freezed,
    Object? schedule = freezed,
    Object? timetable = freezed,
    Object? groupDefinition = freezed,
  }) {
    return _then(_value.copyWith(
      jsonData: jsonData == freezed
          ? _value.jsonData
          : jsonData // ignore: cast_nullable_to_non_nullable
              as String,
      groups: groups == freezed
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as String,
      schedule: schedule == freezed
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timetable: timetable == freezed
          ? _value.timetable
          : timetable // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      groupDefinition: groupDefinition == freezed
          ? _value.groupDefinition
          : groupDefinition // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$FullScheduleCopyWith<$Res>
    implements $FullScheduleCopyWith<$Res> {
  factory _$FullScheduleCopyWith(
          _FullSchedule value, $Res Function(_FullSchedule) then) =
      __$FullScheduleCopyWithImpl<$Res>;
  @override
  $Res call(
      {String jsonData,
      String groups,
      Map<String, dynamic> schedule,
      Map<String, dynamic> timetable,
      Map<String, dynamic> groupDefinition});
}

/// @nodoc
class __$FullScheduleCopyWithImpl<$Res> extends _$FullScheduleCopyWithImpl<$Res>
    implements _$FullScheduleCopyWith<$Res> {
  __$FullScheduleCopyWithImpl(
      _FullSchedule _value, $Res Function(_FullSchedule) _then)
      : super(_value, (v) => _then(v as _FullSchedule));

  @override
  _FullSchedule get _value => super._value as _FullSchedule;

  @override
  $Res call({
    Object? jsonData = freezed,
    Object? groups = freezed,
    Object? schedule = freezed,
    Object? timetable = freezed,
    Object? groupDefinition = freezed,
  }) {
    return _then(_FullSchedule(
      jsonData: jsonData == freezed
          ? _value.jsonData
          : jsonData // ignore: cast_nullable_to_non_nullable
              as String,
      groups: groups == freezed
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as String,
      schedule: schedule == freezed
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timetable: timetable == freezed
          ? _value.timetable
          : timetable // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      groupDefinition: groupDefinition == freezed
          ? _value.groupDefinition
          : groupDefinition // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$_FullSchedule implements _FullSchedule {
  const _$_FullSchedule(
      {required this.jsonData,
      required this.groups,
      required this.schedule,
      required this.timetable,
      required this.groupDefinition});

  @override
  final String jsonData;
  @override
  final String groups;
  @override
  final Map<String, dynamic> schedule;
  @override
  final Map<String, dynamic> timetable;
  @override
  final Map<String, dynamic> groupDefinition;

  @override
  String toString() {
    return 'FullSchedule(jsonData: $jsonData, groups: $groups, schedule: $schedule, timetable: $timetable, groupDefinition: $groupDefinition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FullSchedule &&
            const DeepCollectionEquality().equals(other.jsonData, jsonData) &&
            const DeepCollectionEquality().equals(other.groups, groups) &&
            const DeepCollectionEquality().equals(other.schedule, schedule) &&
            const DeepCollectionEquality().equals(other.timetable, timetable) &&
            const DeepCollectionEquality()
                .equals(other.groupDefinition, groupDefinition));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(jsonData),
      const DeepCollectionEquality().hash(groups),
      const DeepCollectionEquality().hash(schedule),
      const DeepCollectionEquality().hash(timetable),
      const DeepCollectionEquality().hash(groupDefinition));

  @JsonKey(ignore: true)
  @override
  _$FullScheduleCopyWith<_FullSchedule> get copyWith =>
      __$FullScheduleCopyWithImpl<_FullSchedule>(this, _$identity);
}

abstract class _FullSchedule implements FullSchedule {
  const factory _FullSchedule(
      {required String jsonData,
      required String groups,
      required Map<String, dynamic> schedule,
      required Map<String, dynamic> timetable,
      required Map<String, dynamic> groupDefinition}) = _$_FullSchedule;

  @override
  String get jsonData;
  @override
  String get groups;
  @override
  Map<String, dynamic> get schedule;
  @override
  Map<String, dynamic> get timetable;
  @override
  Map<String, dynamic> get groupDefinition;
  @override
  @JsonKey(ignore: true)
  _$FullScheduleCopyWith<_FullSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}