// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_slot_appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeSlotAppointment _$TimeSlotAppointmentFromJson(Map<String, dynamic> json) {
  return _TimeSlotAppointment.fromJson(json);
}

/// @nodoc
mixin _$TimeSlotAppointment {
  List<String>? get allTimeSlot => throw _privateConstructorUsedError;
  List<String>? get availableTimeSlot => throw _privateConstructorUsedError;

  /// Serializes this TimeSlotAppointment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeSlotAppointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeSlotAppointmentCopyWith<TimeSlotAppointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeSlotAppointmentCopyWith<$Res> {
  factory $TimeSlotAppointmentCopyWith(
          TimeSlotAppointment value, $Res Function(TimeSlotAppointment) then) =
      _$TimeSlotAppointmentCopyWithImpl<$Res, TimeSlotAppointment>;
  @useResult
  $Res call({List<String>? allTimeSlot, List<String>? availableTimeSlot});
}

/// @nodoc
class _$TimeSlotAppointmentCopyWithImpl<$Res, $Val extends TimeSlotAppointment>
    implements $TimeSlotAppointmentCopyWith<$Res> {
  _$TimeSlotAppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeSlotAppointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allTimeSlot = freezed,
    Object? availableTimeSlot = freezed,
  }) {
    return _then(_value.copyWith(
      allTimeSlot: freezed == allTimeSlot
          ? _value.allTimeSlot
          : allTimeSlot // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      availableTimeSlot: freezed == availableTimeSlot
          ? _value.availableTimeSlot
          : availableTimeSlot // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeSlotAppointmentImplCopyWith<$Res>
    implements $TimeSlotAppointmentCopyWith<$Res> {
  factory _$$TimeSlotAppointmentImplCopyWith(_$TimeSlotAppointmentImpl value,
          $Res Function(_$TimeSlotAppointmentImpl) then) =
      __$$TimeSlotAppointmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String>? allTimeSlot, List<String>? availableTimeSlot});
}

/// @nodoc
class __$$TimeSlotAppointmentImplCopyWithImpl<$Res>
    extends _$TimeSlotAppointmentCopyWithImpl<$Res, _$TimeSlotAppointmentImpl>
    implements _$$TimeSlotAppointmentImplCopyWith<$Res> {
  __$$TimeSlotAppointmentImplCopyWithImpl(_$TimeSlotAppointmentImpl _value,
      $Res Function(_$TimeSlotAppointmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimeSlotAppointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allTimeSlot = freezed,
    Object? availableTimeSlot = freezed,
  }) {
    return _then(_$TimeSlotAppointmentImpl(
      allTimeSlot: freezed == allTimeSlot
          ? _value._allTimeSlot
          : allTimeSlot // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      availableTimeSlot: freezed == availableTimeSlot
          ? _value._availableTimeSlot
          : availableTimeSlot // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeSlotAppointmentImpl implements _TimeSlotAppointment {
  const _$TimeSlotAppointmentImpl(
      {final List<String>? allTimeSlot, final List<String>? availableTimeSlot})
      : _allTimeSlot = allTimeSlot,
        _availableTimeSlot = availableTimeSlot;

  factory _$TimeSlotAppointmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeSlotAppointmentImplFromJson(json);

  final List<String>? _allTimeSlot;
  @override
  List<String>? get allTimeSlot {
    final value = _allTimeSlot;
    if (value == null) return null;
    if (_allTimeSlot is EqualUnmodifiableListView) return _allTimeSlot;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _availableTimeSlot;
  @override
  List<String>? get availableTimeSlot {
    final value = _availableTimeSlot;
    if (value == null) return null;
    if (_availableTimeSlot is EqualUnmodifiableListView)
      return _availableTimeSlot;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TimeSlotAppointment(allTimeSlot: $allTimeSlot, availableTimeSlot: $availableTimeSlot)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeSlotAppointmentImpl &&
            const DeepCollectionEquality()
                .equals(other._allTimeSlot, _allTimeSlot) &&
            const DeepCollectionEquality()
                .equals(other._availableTimeSlot, _availableTimeSlot));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allTimeSlot),
      const DeepCollectionEquality().hash(_availableTimeSlot));

  /// Create a copy of TimeSlotAppointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeSlotAppointmentImplCopyWith<_$TimeSlotAppointmentImpl> get copyWith =>
      __$$TimeSlotAppointmentImplCopyWithImpl<_$TimeSlotAppointmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeSlotAppointmentImplToJson(
      this,
    );
  }
}

abstract class _TimeSlotAppointment implements TimeSlotAppointment {
  const factory _TimeSlotAppointment(
      {final List<String>? allTimeSlot,
      final List<String>? availableTimeSlot}) = _$TimeSlotAppointmentImpl;

  factory _TimeSlotAppointment.fromJson(Map<String, dynamic> json) =
      _$TimeSlotAppointmentImpl.fromJson;

  @override
  List<String>? get allTimeSlot;
  @override
  List<String>? get availableTimeSlot;

  /// Create a copy of TimeSlotAppointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeSlotAppointmentImplCopyWith<_$TimeSlotAppointmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
