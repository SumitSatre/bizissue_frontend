import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class Sender {
  String id;
  String name;

  Sender({
    required this.id,
    required this.name,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => _$SenderFromJson(json);

  Map<String, dynamic> toJson() => _$SenderToJson(this);
}

@JsonSerializable()
class MessageModel{
  Sender sender;
  String content;
  DateTime timestamp;

  MessageModel({
    required this.sender,
    required this.content,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}

