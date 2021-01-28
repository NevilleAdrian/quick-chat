import 'dart:convert';
import 'package:hive/hive.dart';

part 'remember_me.g.dart';


RememberMe rememberMeFromJson(String str) => RememberMe.fromJson(json.decode(str));

String rememberMeToJson(RememberMe data) => json.encode(data.toJson());

@HiveType(typeId: 1)

class RememberMe {
  RememberMe({
    this.rememberMeBool,
  });

  @HiveField(0)
  bool rememberMeBool;

  factory RememberMe.fromJson(Map<String, dynamic> json) => RememberMe(
    rememberMeBool: json["bool"],
  );

  Map<String, dynamic> toJson() => {
    "bool": rememberMeBool,
  };
}
