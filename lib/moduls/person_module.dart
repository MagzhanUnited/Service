import 'dart:convert';

PersonModule personModuleFromJson(String str) =>
    PersonModule.fromJson(json.decode(str));

String personModuleToJson(PersonModule data) => json.encode(data.toJson());

class PersonModule {
  PersonModule({
    this.id,
    this.fullname,
    this.password,
    this.email,
    this.number,
    this.liked,
  });

  int? id;
  String? fullname;
  String? password;
  String? email;
  String? number;
  List<int>? liked;

  factory PersonModule.fromJson(Map<String, dynamic> json) => PersonModule(
        id: json["id"],
        fullname: json["fullname"],
        password: json["password"],
        email: json["email"],
        number: json["number"],
        liked: json["liked"] != null
            ? List<int>.from(json["liked"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "password": password,
        "email": email,
        "number": number,
        "liked": liked != null ? List<int?>.from(liked!.map((x) => x)) : null,
      };
}
