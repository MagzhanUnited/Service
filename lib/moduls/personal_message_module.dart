import 'dart:convert';

PersonalMessageModule personalMessageModuleFromJson(String str) =>
    PersonalMessageModule.fromJson(json.decode(str));

String personalMessageModuleToJson(PersonalMessageModule data) =>
    json.encode(data.toJson());

class PersonalMessageModule {
  PersonalMessageModule({
    this.id,
    this.message,
    this.person1,
    this.person2,
  });

  int? id;
  String? message;
  int? person1;
  int? person2;

  factory PersonalMessageModule.fromJson(Map<String, dynamic> json) =>
      PersonalMessageModule(
        id: json["id"],
        message: json["message"],
        person1: json["person1"],
        person2: json["person2"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "person1": person1,
        "person2": person2,
      };
}
