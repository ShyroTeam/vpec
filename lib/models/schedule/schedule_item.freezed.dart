// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'schedule_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ScheduleItemModelTearOff {
  const _$ScheduleItemModelTearOff();

  _ScheduleItemModel call(
      {required int lessonNumber,
      required String lessonBeginning,
      required String lessonEnding,
      required String lessonName,
      required String pauseAfterLesson}) {
    return _ScheduleItemModel(
      lessonNumber: lessonNumber,
      lessonBeginning: lessonBeginning,
      lessonEnding: lessonEnding,
      lessonName: lessonName,
      pauseAfterLesson: pauseAfterLesson,
    );
  }
}

/// @nodoc
const $ScheduleItemModel = _$ScheduleItemModelTearOff();

/// @nodoc
mixin _$ScheduleItemModel {
  int get lessonNumber => throw _privateConstructorUsedError;
  String get lessonBeginning => throw _privateConstructorUsedError;
  String get lessonEnding => throw _privateConstructorUsedError;
  String get lessonName => throw _privateConstructorUsedError;
  String get pauseAfterLesson => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScheduleItemModelCopyWith<ScheduleItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleItemModelCopyWith<$Res> {
  factory $ScheduleItemModelCopyWith(
          ScheduleItemModel value, $Res Function(ScheduleItemModel) then) =
      _$ScheduleItemModelCopyWithImpl<$Res>;
  $Res call(
      {int lessonNumber,
      String lessonBeginning,
      String lessonEnding,
      String lessonName,
      String pauseAfterLesson});
}

/// @nodoc
class _$ScheduleItemModelCopyWithImpl<$Res>
    implements $ScheduleItemModelCopyWith<$Res> {
  _$ScheduleItemModelCopyWithImpl(this._value, this._then);

  final ScheduleItemModel _value;
  // ignore: unused_field
  final $Res Function(ScheduleItemModel) _then;

  @override
  $Res call({
    Object? lessonNumber = freezed,
    Object? lessonBeginning = freezed,
    Object? lessonEnding = freezed,
    Object? lessonName = freezed,
    Object? pauseAfterLesson = freezed,
  }) {
    return _then(_value.copyWith(
      lessonNumber: lessonNumber == freezed
          ? _value.lessonNumber
          : lessonNumber // ignore: cast_nullable_to_non_nullable
              as int,
      lessonBeginning: lessonBeginning == freezed
          ? _value.lessonBeginning
          : lessonBeginning // ignore: cast_nullable_to_non_nullable
              as String,
      lessonEnding: lessonEnding == freezed
          ? _value.lessonEnding
          : lessonEnding // ignore: cast_nullable_to_non_nullable
              as String,
      lessonName: lessonName == freezed
          ? _value.lessonName
          : lessonName // ignore: cast_nullable_to_non_nullable
              as String,
      pauseAfterLesson: pauseAfterLesson == freezed
          ? _value.pauseAfterLesson
          : pauseAfterLesson // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ScheduleItemModelCopyWith<$Res>
    implements $ScheduleItemModelCopyWith<$Res> {
  factory _$ScheduleItemModelCopyWith(
          _ScheduleItemModel value, $Res Function(_ScheduleItemModel) then) =
      __$ScheduleItemModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int lessonNumber,
      String lessonBeginning,
      String lessonEnding,
      String lessonName,
      String pauseAfterLesson});
}

/// @nodoc
class __$ScheduleItemModelCopyWithImpl<$Res>
    extends _$ScheduleItemModelCopyWithImpl<$Res>
    implements _$ScheduleItemModelCopyWith<$Res> {
  __$ScheduleItemModelCopyWithImpl(
      _ScheduleItemModel _value, $Res Function(_ScheduleItemModel) _then)
      : super(_value, (v) => _then(v as _ScheduleItemModel));

  @override
  _ScheduleItemModel get _value => super._value as _ScheduleItemModel;

  @override
  $Res call({
    Object? lessonNumber = freezed,
    Object? lessonBeginning = freezed,
    Object? lessonEnding = freezed,
    Object? lessonName = freezed,
    Object? pauseAfterLesson = freezed,
  }) {
    return _then(_ScheduleItemModel(
      lessonNumber: lessonNumber == freezed
          ? _value.lessonNumber
          : lessonNumber // ignore: cast_nullable_to_non_nullable
              as int,
      lessonBeginning: lessonBeginning == freezed
          ? _value.lessonBeginning
          : lessonBeginning // ignore: cast_nullable_to_non_nullable
              as String,
      lessonEnding: lessonEnding == freezed
          ? _value.lessonEnding
          : lessonEnding // ignore: cast_nullable_to_non_nullable
              as String,
      lessonName: lessonName == freezed
          ? _value.lessonName
          : lessonName // ignore: cast_nullable_to_non_nullable
              as String,
      pauseAfterLesson: pauseAfterLesson == freezed
          ? _value.pauseAfterLesson
          : pauseAfterLesson // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ScheduleItemModel implements _ScheduleItemModel {
  const _$_ScheduleItemModel(
      {required this.lessonNumber,
      required this.lessonBeginning,
      required this.lessonEnding,
      required this.lessonName,
      required this.pauseAfterLesson});

  @override
  final int lessonNumber;
  @override
  final String lessonBeginning;
  @override
  final String lessonEnding;
  @override
  final String lessonName;
  @override
  final String pauseAfterLesson;

  @override
  String toString() {
    return 'ScheduleItemModel(lessonNumber: $lessonNumber, lessonBeginning: $lessonBeginning, lessonEnding: $lessonEnding, lessonName: $lessonName, pauseAfterLesson: $pauseAfterLesson)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScheduleItemModel &&
            const DeepCollectionEquality()
                .equals(other.lessonNumber, lessonNumber) &&
            const DeepCollectionEquality()
                .equals(other.lessonBeginning, lessonBeginning) &&
            const DeepCollectionEquality()
                .equals(other.lessonEnding, lessonEnding) &&
            const DeepCollectionEquality()
                .equals(other.lessonName, lessonName) &&
            const DeepCollectionEquality()
                .equals(other.pauseAfterLesson, pauseAfterLesson));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(lessonNumber),
      const DeepCollectionEquality().hash(lessonBeginning),
      const DeepCollectionEquality().hash(lessonEnding),
      const DeepCollectionEquality().hash(lessonName),
      const DeepCollectionEquality().hash(pauseAfterLesson));

  @JsonKey(ignore: true)
  @override
  _$ScheduleItemModelCopyWith<_ScheduleItemModel> get copyWith =>
      __$ScheduleItemModelCopyWithImpl<_ScheduleItemModel>(this, _$identity);
}

abstract class _ScheduleItemModel implements ScheduleItemModel {
  const factory _ScheduleItemModel(
      {required int lessonNumber,
      required String lessonBeginning,
      required String lessonEnding,
      required String lessonName,
      required String pauseAfterLesson}) = _$_ScheduleItemModel;

  @override
  int get lessonNumber;
  @override
  String get lessonBeginning;
  @override
  String get lessonEnding;
  @override
  String get lessonName;
  @override
  String get pauseAfterLesson;
  @override
  @JsonKey(ignore: true)
  _$ScheduleItemModelCopyWith<_ScheduleItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}