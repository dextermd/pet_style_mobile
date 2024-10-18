// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hw_day_of_week_appointmen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HwDayOfWeekAppointmen _$HwDayOfWeekAppointmenFromJson(
    Map<String, dynamic> json) {
  return _HwDayOfWeekAppointmen.fromJson(json);
}

/// @nodoc
mixin _$HwDayOfWeekAppointmen {
  List<int>? get homeWorkDayOfWeek => throw _privateConstructorUsedError;

  /// Serializes this HwDayOfWeekAppointmen to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HwDayOfWeekAppointmen
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HwDayOfWeekAppointmenCopyWith<HwDayOfWeekAppointmen> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HwDayOfWeekAppointmenCopyWith<$Res> {
  factory $HwDayOfWeekAppointmenCopyWith(HwDayOfWeekAppointmen value,
          $Res Function(HwDayOfWeekAppointmen) then) =
      _$HwDayOfWeekAppointmenCopyWithImpl<$Res, HwDayOfWeekAppointmen>;
  @useResult
  $Res call({List<int>? homeWorkDayOfWeek});
}

/// @nodoc
class _$HwDayOfWeekAppointmenCopyWithImpl<$Res,
        $Val extends HwDayOfWeekAppointmen>
    implements $HwDayOfWeekAppointmenCopyWith<$Res> {
  _$HwDayOfWeekAppointmenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HwDayOfWeekAppointmen
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeWorkDayOfWeek = freezed,
  }) {
    return _then(_value.copyWith(
      homeWorkDayOfWeek: freezed == homeWorkDayOfWeek
          ? _value.homeWorkDayOfWeek
          : homeWorkDayOfWeek // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HwDayOfWeekAppointmenImplCopyWith<$Res>
    implements $HwDayOfWeekAppointmenCopyWith<$Res> {
  factory _$$HwDayOfWeekAppointmenImplCopyWith(
          _$HwDayOfWeekAppointmenImpl value,
          $Res Function(_$HwDayOfWeekAppointmenImpl) then) =
      __$$HwDayOfWeekAppointmenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int>? homeWorkDayOfWeek});
}

/// @nodoc
class __$$HwDayOfWeekAppointmenImplCopyWithImpl<$Res>
    extends _$HwDayOfWeekAppointmenCopyWithImpl<$Res,
        _$HwDayOfWeekAppointmenImpl>
    implements _$$HwDayOfWeekAppointmenImplCopyWith<$Res> {
  __$$HwDayOfWeekAppointmenImplCopyWithImpl(_$HwDayOfWeekAppointmenImpl _value,
      $Res Function(_$HwDayOfWeekAppointmenImpl) _then)
      : super(_value, _then);

  /// Create a copy of HwDayOfWeekAppointmen
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeWorkDayOfWeek = freezed,
  }) {
    return _then(_$HwDayOfWeekAppointmenImpl(
      homeWorkDayOfWeek: freezed == homeWorkDayOfWeek
          ? _value._homeWorkDayOfWeek
          : homeWorkDayOfWeek // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HwDayOfWeekAppointmenImpl implements _HwDayOfWeekAppointmen {
  const _$HwDayOfWeekAppointmenImpl({final List<int>? homeWorkDayOfWeek})
      : _homeWorkDayOfWeek = homeWorkDayOfWeek;

  factory _$HwDayOfWeekAppointmenImpl.fromJson(Map<String, dynamic> json) =>
      _$$HwDayOfWeekAppointmenImplFromJson(json);

  final List<int>? _homeWorkDayOfWeek;
  @override
  List<int>? get homeWorkDayOfWeek {
    final value = _homeWorkDayOfWeek;
    if (value == null) return null;
    if (_homeWorkDayOfWeek is EqualUnmodifiableListView)
      return _homeWorkDayOfWeek;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'HwDayOfWeekAppointmen(homeWorkDayOfWeek: $homeWorkDayOfWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HwDayOfWeekAppointmenImpl &&
            const DeepCollectionEquality()
                .equals(other._homeWorkDayOfWeek, _homeWorkDayOfWeek));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_homeWorkDayOfWeek));

  /// Create a copy of HwDayOfWeekAppointmen
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HwDayOfWeekAppointmenImplCopyWith<_$HwDayOfWeekAppointmenImpl>
      get copyWith => __$$HwDayOfWeekAppointmenImplCopyWithImpl<
          _$HwDayOfWeekAppointmenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HwDayOfWeekAppointmenImplToJson(
      this,
    );
  }
}

abstract class _HwDayOfWeekAppointmen implements HwDayOfWeekAppointmen {
  const factory _HwDayOfWeekAppointmen({final List<int>? homeWorkDayOfWeek}) =
      _$HwDayOfWeekAppointmenImpl;

  factory _HwDayOfWeekAppointmen.fromJson(Map<String, dynamic> json) =
      _$HwDayOfWeekAppointmenImpl.fromJson;

  @override
  List<int>? get homeWorkDayOfWeek;

  /// Create a copy of HwDayOfWeekAppointmen
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HwDayOfWeekAppointmenImplCopyWith<_$HwDayOfWeekAppointmenImpl>
      get copyWith => throw _privateConstructorUsedError;
}
