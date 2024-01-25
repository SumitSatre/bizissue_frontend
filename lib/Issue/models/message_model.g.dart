// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sender _$SenderFromJson(Map<String, dynamic> json) => Sender(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SenderToJson(Sender instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      sender: Sender.fromJson(json['sender'] as Map<String, dynamic>),
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'content': instance.content,
      'timestamp': instance.timestamp.toIso8601String(),
    };
