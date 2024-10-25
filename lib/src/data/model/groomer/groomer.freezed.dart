// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'groomer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Groomer _$GroomerFromJson(Map<String, dynamic> json) {
  return _Groomer.fromJson(json);
}

/// @nodoc
mixin _$Groomer {
  String? get id => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get rating => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get durationTime => throw _privateConstructorUsedError;

  /// Serializes this Groomer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Groomer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroomerCopyWith<Groomer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroomerCopyWith<$Res> {
  factory $GroomerCopyWith(Groomer value, $Res Function(Groomer) then) =
      _$GroomerCopyWithImpl<$Res, Groomer>;
  @useResult
  $Res call(
      {String? id,
      String? firstName,
      String? lastName,
      String? rating,
      String? email,
      String? phone,
      String? durationTime});
}

/// @nodoc
class _$GroomerCopyWithImpl<$Res, $Val extends Groomer>
    implements $GroomerCopyWith<$Res> {
  _$GroomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Groomer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? rating = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? durationTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      durationTime: freezed == durationTime
          ? _value.durationTime
          : durationTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroomerImplCopyWith<$Res> implements $GroomerCopyWith<$Res> {
  factory _$$GroomerImplCopyWith(
          _$GroomerImpl value, $Res Function(_$GroomerImpl) then) =
      __$$GroomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? firstName,
      String? lastName,
      String? rating,
      String? email,
      String? phone,
      String? durationTime});
}

/// @nodoc
class __$$GroomerImplCopyWithImpl<$Res>
    extends _$GroomerCopyWithImpl<$Res, _$GroomerImpl>
    implements _$$GroomerImplCopyWith<$Res> {
  __$$GroomerImplCopyWithImpl(
      _$GroomerImpl _value, $Res Function(_$GroomerImpl) _then)
      : super(_value, _then);

  /// Create a copy of Groomer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? rating = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? durationTime = freezed,
  }) {
    return _then(_$GroomerImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      durationTime: freezed == durationTime
          ? _value.durationTime
          : durationTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroomerImpl implements _Groomer {
  const _$GroomerImpl(
      {this.id,
      this.firstName,
      this.lastName,
      this.rating,
      this.email,
      this.phone,
      this.durationTime});

  factory _$GroomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroomerImplFromJson(json);

  @override
  final String? id;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? rating;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? durationTime;

  @override
  String toString() {
    return 'Groomer(id: $id, firstName: $firstName, lastName: $lastName, rating: $rating, email: $email, phone: $phone, durationTime: $durationTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroomerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.durationTime, durationTime) ||
                other.durationTime == durationTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, firstName, lastName, rating, email, phone, durationTime);

  /// Create a copy of Groomer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroomerImplCopyWith<_$GroomerImpl> get copyWith =>
      __$$GroomerImplCopyWithImpl<_$GroomerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroomerImplToJson(
      this,
    );
  }
}

abstract class _Groomer implements Groomer {
  const factory _Groomer(
      {final String? id,
      final String? firstName,
      final String? lastName,
      final String? rating,
      final String? email,
      final String? phone,
      final String? durationTime}) = _$GroomerImpl;

  factory _Groomer.fromJson(Map<String, dynamic> json) = _$GroomerImpl.fromJson;

  @override
  String? get id;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get rating;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get durationTime;

  /// Create a copy of Groomer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroomerImplCopyWith<_$GroomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
