// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return _Appointment.fromJson(json);
}

/// @nodoc
mixin _$Appointment {
  @JsonKey(name: 'appointment_date')
  DateTime? get appointmentDate => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'userId', toJson: _userToJson)
  User? get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'petId', toJson: _petToJson)
  Pet? get pet => throw _privateConstructorUsedError;
  @JsonKey(name: 'groomerId', toJson: _groomerToJson)
  Groomer? get groomer => throw _privateConstructorUsedError;

  /// Serializes this Appointment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentCopyWith<Appointment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentCopyWith<$Res> {
  factory $AppointmentCopyWith(
          Appointment value, $Res Function(Appointment) then) =
      _$AppointmentCopyWithImpl<$Res, Appointment>;
  @useResult
  $Res call(
      {@JsonKey(name: 'appointment_date') DateTime? appointmentDate,
      String? location,
      int? status,
      @JsonKey(name: 'userId', toJson: _userToJson) User? user,
      @JsonKey(name: 'petId', toJson: _petToJson) Pet? pet,
      @JsonKey(name: 'groomerId', toJson: _groomerToJson) Groomer? groomer});

  $UserCopyWith<$Res>? get user;
  $PetCopyWith<$Res>? get pet;
  $GroomerCopyWith<$Res>? get groomer;
}

/// @nodoc
class _$AppointmentCopyWithImpl<$Res, $Val extends Appointment>
    implements $AppointmentCopyWith<$Res> {
  _$AppointmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentDate = freezed,
    Object? location = freezed,
    Object? status = freezed,
    Object? user = freezed,
    Object? pet = freezed,
    Object? groomer = freezed,
  }) {
    return _then(_value.copyWith(
      appointmentDate: freezed == appointmentDate
          ? _value.appointmentDate
          : appointmentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      pet: freezed == pet
          ? _value.pet
          : pet // ignore: cast_nullable_to_non_nullable
              as Pet?,
      groomer: freezed == groomer
          ? _value.groomer
          : groomer // ignore: cast_nullable_to_non_nullable
              as Groomer?,
    ) as $Val);
  }

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PetCopyWith<$Res>? get pet {
    if (_value.pet == null) {
      return null;
    }

    return $PetCopyWith<$Res>(_value.pet!, (value) {
      return _then(_value.copyWith(pet: value) as $Val);
    });
  }

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroomerCopyWith<$Res>? get groomer {
    if (_value.groomer == null) {
      return null;
    }

    return $GroomerCopyWith<$Res>(_value.groomer!, (value) {
      return _then(_value.copyWith(groomer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppointmentImplCopyWith<$Res>
    implements $AppointmentCopyWith<$Res> {
  factory _$$AppointmentImplCopyWith(
          _$AppointmentImpl value, $Res Function(_$AppointmentImpl) then) =
      __$$AppointmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'appointment_date') DateTime? appointmentDate,
      String? location,
      int? status,
      @JsonKey(name: 'userId', toJson: _userToJson) User? user,
      @JsonKey(name: 'petId', toJson: _petToJson) Pet? pet,
      @JsonKey(name: 'groomerId', toJson: _groomerToJson) Groomer? groomer});

  @override
  $UserCopyWith<$Res>? get user;
  @override
  $PetCopyWith<$Res>? get pet;
  @override
  $GroomerCopyWith<$Res>? get groomer;
}

/// @nodoc
class __$$AppointmentImplCopyWithImpl<$Res>
    extends _$AppointmentCopyWithImpl<$Res, _$AppointmentImpl>
    implements _$$AppointmentImplCopyWith<$Res> {
  __$$AppointmentImplCopyWithImpl(
      _$AppointmentImpl _value, $Res Function(_$AppointmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentDate = freezed,
    Object? location = freezed,
    Object? status = freezed,
    Object? user = freezed,
    Object? pet = freezed,
    Object? groomer = freezed,
  }) {
    return _then(_$AppointmentImpl(
      appointmentDate: freezed == appointmentDate
          ? _value.appointmentDate
          : appointmentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      pet: freezed == pet
          ? _value.pet
          : pet // ignore: cast_nullable_to_non_nullable
              as Pet?,
      groomer: freezed == groomer
          ? _value.groomer
          : groomer // ignore: cast_nullable_to_non_nullable
              as Groomer?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentImpl implements _Appointment {
  const _$AppointmentImpl(
      {@JsonKey(name: 'appointment_date') this.appointmentDate,
      this.location,
      this.status,
      @JsonKey(name: 'userId', toJson: _userToJson) this.user,
      @JsonKey(name: 'petId', toJson: _petToJson) this.pet,
      @JsonKey(name: 'groomerId', toJson: _groomerToJson) this.groomer});

  factory _$AppointmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentImplFromJson(json);

  @override
  @JsonKey(name: 'appointment_date')
  final DateTime? appointmentDate;
  @override
  final String? location;
  @override
  final int? status;
  @override
  @JsonKey(name: 'userId', toJson: _userToJson)
  final User? user;
  @override
  @JsonKey(name: 'petId', toJson: _petToJson)
  final Pet? pet;
  @override
  @JsonKey(name: 'groomerId', toJson: _groomerToJson)
  final Groomer? groomer;

  @override
  String toString() {
    return 'Appointment(appointmentDate: $appointmentDate, location: $location, status: $status, user: $user, pet: $pet, groomer: $groomer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentImpl &&
            (identical(other.appointmentDate, appointmentDate) ||
                other.appointmentDate == appointmentDate) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.pet, pet) || other.pet == pet) &&
            (identical(other.groomer, groomer) || other.groomer == groomer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, appointmentDate, location, status, user, pet, groomer);

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentImplCopyWith<_$AppointmentImpl> get copyWith =>
      __$$AppointmentImplCopyWithImpl<_$AppointmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentImplToJson(
      this,
    );
  }
}

abstract class _Appointment implements Appointment {
  const factory _Appointment(
      {@JsonKey(name: 'appointment_date') final DateTime? appointmentDate,
      final String? location,
      final int? status,
      @JsonKey(name: 'userId', toJson: _userToJson) final User? user,
      @JsonKey(name: 'petId', toJson: _petToJson) final Pet? pet,
      @JsonKey(name: 'groomerId', toJson: _groomerToJson)
      final Groomer? groomer}) = _$AppointmentImpl;

  factory _Appointment.fromJson(Map<String, dynamic> json) =
      _$AppointmentImpl.fromJson;

  @override
  @JsonKey(name: 'appointment_date')
  DateTime? get appointmentDate;
  @override
  String? get location;
  @override
  int? get status;
  @override
  @JsonKey(name: 'userId', toJson: _userToJson)
  User? get user;
  @override
  @JsonKey(name: 'petId', toJson: _petToJson)
  Pet? get pet;
  @override
  @JsonKey(name: 'groomerId', toJson: _groomerToJson)
  Groomer? get groomer;

  /// Create a copy of Appointment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentImplCopyWith<_$AppointmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
