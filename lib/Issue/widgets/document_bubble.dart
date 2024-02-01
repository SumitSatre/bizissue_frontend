import 'package:bizissue/Issue/models/message_model.dart';
import 'package:bizissue/Issue/widgets/view_pdf.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class DocumentBubble extends StatefulWidget {
  final MessageModel message;
  final bool isMe;

  const DocumentBubble({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  State<DocumentBubble> createState() => _DocumentBubbleState();
}

class _DocumentBubbleState extends State<DocumentBubble> {
  late String? pdfPath;
  late String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: InkWell(
        onTap: () async {
          // GoRoute.of(context).push();
          print("url : ${widget.message.attachments!.url}");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  MyPdfViewer(pdfUrl: widget.message.attachments!.url)));
          print("Working");
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: widget.isMe ? Colors.lightBlue : Colors.grey[300],
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.insert_drive_file, color: Colors.black87),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.message.sender.name,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    ((widget.message.attachments?.name?.toString()?.length ??
                                0) >
                            20)
                        ? '${widget.message.attachments?.name?.toString()?.substring(0, 20)}...'
                        : widget.message.attachments?.name?.toString() ?? "",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8.0),
              if (widget.isMe) RoundDownloadButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundDownloadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.lightBlue,
      ),
      child: IconButton(
        icon: Icon(Icons.download_rounded, color: Colors.white),
        onPressed: () {
          // Handle download action
        },
      ),
    );
  }
}
