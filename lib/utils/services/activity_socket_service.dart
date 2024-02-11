import 'package:bizissue/Issue/models/message_model.dart';
import 'package:bizissue/Issue/screens/controllers/issue_controller.dart';
import 'package:flutter/material.dart'; // Import Flutter material library
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ActivitySocketService {
  late IO.Socket socket;

  void initSocket(String issueId, BuildContext context) { // Accept BuildContext as parameter
    socket = IO.io(
      'https://bizissue-backend.onrender.com/issue/chat',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.connect();

    socket.onConnect((_) {
      print('connected');
      socket.emit("join-issue-chat-room", issueId);
    });

    socket.on('receive-message', (data) {
      print("This data is received : ${data}");
      final newMessage = MessageModel(
          sender:
          Sender(id: data['sender']['id'], name: data['sender']['name']),
          content: data['content'],
          createdAt: DateTime.fromMillisecondsSinceEpoch(data['createdAt']),
          isAttachment: false);

      final issueController =
      Provider.of<IssueProvider>(context, listen: false);

      if (issueController.messages == null) {
        issueController.messages = [newMessage];
      } else {
        issueController.messages!.add(newMessage);
      }
      issueController.notifyListeners();
    });

    socket.on('receive-message-doc', (data) {
      print("This data is received : ${data}");
      final newMessage = MessageModel(
          sender:
          Sender(id: data['sender']['id'], name: data['sender']['name']),
          createdAt: DateTime.fromMillisecondsSinceEpoch(data['createdAt']),
          isAttachment: true,
          attachments: Attachments(
              url: data['attachments']['url'],
              type: data['attachments']['type'],
              name: data['attachments']['name']));

      final issueController =
      Provider.of<IssueProvider>(context, listen: false);

      if (issueController.messages == null) {
        issueController.messages = [newMessage];
      } else {
        issueController.messages!.add(newMessage);
      }
      issueController.notifyListeners();
    });

  }

  void sendMessage(BuildContext context, String issueId, String businessId, String content, String userId, String userName) {
    socket.emit('issue-message', {
      'issueId': issueId,
      'businessId': businessId,
      'message': {
        'sender': {'id': userId, 'name': userName},
        'content': content,
      },
    });

    final newMessage = MessageModel(
        sender: Sender(
          id: userId,
          name: userName,
        ),
        content: content,
        createdAt: DateTime.now(),
        isAttachment: false);

    final issueController = Provider.of<IssueProvider>(
        context,
        listen: false);

    if (issueController.messages == null) {
      issueController.messages = [newMessage];
    } else {
      issueController.messages!.add(newMessage);
    }
    issueController.notifyListeners();
  }

  void sendDocumentMessage(BuildContext context,String issueId, String businessId, String docUrl, String fileType, String fileName, String userId, String userName) {
    socket.emit('issue-message-doc', {
      'issueId': issueId,
      'businessId': businessId,
      'message': {
        'sender': {'id': userId, 'name': userName},
        'isAttachment': true,
        "attachments": {
          "url": docUrl,
          "type": fileType,
          "name": fileName,
        },
      },
    });
  }

  void disconnect() {
    if (socket.connected) {
      socket.disconnect();
      print('Socket disconnected');
    }
  }

}
