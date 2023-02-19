import 'dart:convert';

MessageModule messageModuleFromJson(String str) =>
    MessageModule.fromJson(json.decode(str));

String messageModuleToJson(MessageModule data) => json.encode(data.toJson());

List<MessageModule> messagesModuleFromJson(String str) =>
    List<MessageModule>.from(
        json.decode(str).map((x) => MessageModule.fromJson(x)));

String messagesModuleToJson(List<MessageModule> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageModule {
  MessageModule({
    this.id,
    required this.question,
    this.answer,
    required this.user,
  });

  int? id;
  String question;
  String? answer;
  int user;

  factory MessageModule.fromJson(Map<String, dynamic> json) => MessageModule(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
        "user": user,
      };
}
