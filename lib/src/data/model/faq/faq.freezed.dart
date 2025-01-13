// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faq.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Faq _$FaqFromJson(Map<String, dynamic> json) {
  return _Faq.fromJson(json);
}

/// @nodoc
mixin _$Faq {
  String? get id => throw _privateConstructorUsedError;
  String? get questionRu => throw _privateConstructorUsedError;
  String? get questionRo => throw _privateConstructorUsedError;
  String? get answerRu => throw _privateConstructorUsedError;
  String? get answerRo => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;

  /// Serializes this Faq to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Faq
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FaqCopyWith<Faq> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaqCopyWith<$Res> {
  factory $FaqCopyWith(Faq value, $Res Function(Faq) then) =
      _$FaqCopyWithImpl<$Res, Faq>;
  @useResult
  $Res call(
      {String? id,
      String? questionRu,
      String? questionRo,
      String? answerRu,
      String? answerRo,
      bool? isActive});
}

/// @nodoc
class _$FaqCopyWithImpl<$Res, $Val extends Faq> implements $FaqCopyWith<$Res> {
  _$FaqCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Faq
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? questionRu = freezed,
    Object? questionRo = freezed,
    Object? answerRu = freezed,
    Object? answerRo = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      questionRu: freezed == questionRu
          ? _value.questionRu
          : questionRu // ignore: cast_nullable_to_non_nullable
              as String?,
      questionRo: freezed == questionRo
          ? _value.questionRo
          : questionRo // ignore: cast_nullable_to_non_nullable
              as String?,
      answerRu: freezed == answerRu
          ? _value.answerRu
          : answerRu // ignore: cast_nullable_to_non_nullable
              as String?,
      answerRo: freezed == answerRo
          ? _value.answerRo
          : answerRo // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FaqImplCopyWith<$Res> implements $FaqCopyWith<$Res> {
  factory _$$FaqImplCopyWith(_$FaqImpl value, $Res Function(_$FaqImpl) then) =
      __$$FaqImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? questionRu,
      String? questionRo,
      String? answerRu,
      String? answerRo,
      bool? isActive});
}

/// @nodoc
class __$$FaqImplCopyWithImpl<$Res> extends _$FaqCopyWithImpl<$Res, _$FaqImpl>
    implements _$$FaqImplCopyWith<$Res> {
  __$$FaqImplCopyWithImpl(_$FaqImpl _value, $Res Function(_$FaqImpl) _then)
      : super(_value, _then);

  /// Create a copy of Faq
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? questionRu = freezed,
    Object? questionRo = freezed,
    Object? answerRu = freezed,
    Object? answerRo = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_$FaqImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      questionRu: freezed == questionRu
          ? _value.questionRu
          : questionRu // ignore: cast_nullable_to_non_nullable
              as String?,
      questionRo: freezed == questionRo
          ? _value.questionRo
          : questionRo // ignore: cast_nullable_to_non_nullable
              as String?,
      answerRu: freezed == answerRu
          ? _value.answerRu
          : answerRu // ignore: cast_nullable_to_non_nullable
              as String?,
      answerRo: freezed == answerRo
          ? _value.answerRo
          : answerRo // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FaqImpl implements _Faq {
  const _$FaqImpl(
      {this.id,
      this.questionRu,
      this.questionRo,
      this.answerRu,
      this.answerRo,
      this.isActive});

  factory _$FaqImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaqImplFromJson(json);

  @override
  final String? id;
  @override
  final String? questionRu;
  @override
  final String? questionRo;
  @override
  final String? answerRu;
  @override
  final String? answerRo;
  @override
  final bool? isActive;

  @override
  String toString() {
    return 'Faq(id: $id, questionRu: $questionRu, questionRo: $questionRo, answerRu: $answerRu, answerRo: $answerRo, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaqImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.questionRu, questionRu) ||
                other.questionRu == questionRu) &&
            (identical(other.questionRo, questionRo) ||
                other.questionRo == questionRo) &&
            (identical(other.answerRu, answerRu) ||
                other.answerRu == answerRu) &&
            (identical(other.answerRo, answerRo) ||
                other.answerRo == answerRo) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, questionRu, questionRo, answerRu, answerRo, isActive);

  /// Create a copy of Faq
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FaqImplCopyWith<_$FaqImpl> get copyWith =>
      __$$FaqImplCopyWithImpl<_$FaqImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FaqImplToJson(
      this,
    );
  }
}

abstract class _Faq implements Faq {
  const factory _Faq(
      {final String? id,
      final String? questionRu,
      final String? questionRo,
      final String? answerRu,
      final String? answerRo,
      final bool? isActive}) = _$FaqImpl;

  factory _Faq.fromJson(Map<String, dynamic> json) = _$FaqImpl.fromJson;

  @override
  String? get id;
  @override
  String? get questionRu;
  @override
  String? get questionRo;
  @override
  String? get answerRu;
  @override
  String? get answerRo;
  @override
  bool? get isActive;

  /// Create a copy of Faq
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaqImplCopyWith<_$FaqImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
