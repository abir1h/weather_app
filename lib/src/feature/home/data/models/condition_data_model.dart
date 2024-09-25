import 'package:flutter/cupertino.dart';

@immutable
class ConditionDataModel {
  final String text;
  final String icon;
  final int code;

  const ConditionDataModel({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory ConditionDataModel.fromJson(Map<String, dynamic> json) =>
      ConditionDataModel(
        text: json["text"],
        icon: json["icon"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "icon": icon,
        "code": code,
      };
}
