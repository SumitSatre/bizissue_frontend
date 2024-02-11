import 'package:flutter/material.dart';
import 'package:bizissue/Issue/models/message_model.dart';

class ImageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;

  const ImageBubble({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = isMe
        ? BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
      bottomLeft: Radius.circular(24.0),
    )
        : BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
      bottomRight: Radius.circular(24.0),
    );

    final double maxWidth =
        MediaQuery.of(context).size.width * 0.8; // 80% of total mobile width

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Image.network(
            message.attachments?.url ?? '', // Assuming the image URL is stored in 'attachments.url'
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
