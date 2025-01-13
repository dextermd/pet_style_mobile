import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq.freezed.dart';
part 'faq.g.dart';

@freezed
class Faq with _$Faq {
  const factory Faq({
    String? id,
    String? questionRu,
    String? questionRo,
    String? answerRu,
    String? answerRo,
    bool? isActive,
  }) = _Faq;

  factory Faq.fromJson(Map<String, dynamic> json) => _$FaqFromJson(json);
}
