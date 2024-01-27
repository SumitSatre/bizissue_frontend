class MessageModel {
  final Sender sender;
  final bool isAttachment;
  final Attachments? attachments;
  final String? content;
  final DateTime createdAt;

  MessageModel({
    required this.sender,
    required this.isAttachment,
    this.attachments,
    this.content,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      sender: Sender.fromJson(json['sender']),
      isAttachment: json['isAttachment'],
      attachments: json['attachments'] != null ? Attachments.fromJson(json['attachments']) : null,
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender.toJson(),
      'isAttachment': isAttachment,
      'attachments': attachments?.toJson(),
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class Sender {
  final String id;
  final String name;

  Sender({
    required this.id,
    required this.name,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Attachments {
  final String url;
  final String type;
  final String name;

  Attachments({
    required this.url,
    required this.type,
    required this.name,
  });

  factory Attachments.fromJson(Map<String, dynamic> json) {
    return Attachments(
      url: json['url'],
      type: json['type'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'type': type,
      'name': name,
    };
  }
}
