import 'dart:convert';
import 'dart:io';
import 'package:bizissue/Issue/models/message_model.dart';
import 'package:bizissue/Issue/screens/controllers/issue_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IssuePage extends StatefulWidget {
  final String issueId;
  final String businessId;

  const IssuePage({Key? key, required this.issueId, required this.businessId})
      : super(key: key);

  @override
  State<IssuePage> createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  late IO.Socket socket;

  TextEditingController messageContentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    callInit();

    socket = IO.io(
        'https://bizissue-backend.onrender.com/issue/chat', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('connected');
      socket.emit("join-issue-chat-room", widget.issueId);
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
      setState(() {});
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
      setState(() {});
    });
  }

  void callInit() {
    Provider.of<IssueProvider>(context, listen: false)
        .sendIssueGetRequest(widget.businessId, widget.issueId);
    Provider.of<IssueProvider>(context, listen: false)
        .sendIssueChatsGetRequest(widget.businessId, widget.issueId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final homeController = Provider.of<HomeProvider>(context, listen: false);

    return SafeArea(
      child:
          Consumer<IssueProvider>(builder: (context, issueController, child) {
        return issueController.issueModel == null
            ? Center(child: CircularProgressIndicator())
            : Stack(children: [
                Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(
                        MediaQuery.of(context).size.height * 0.19),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02,
                          horizontal: MediaQuery.of(context).size.width * 0.04),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x1E000000),
                                  blurRadius: 4,
                                  offset: Offset(-3, 3),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                issueController.clearData();
                                GoRouter.of(context).pop();
                              },
                              child: const Icon(
                                Icons.arrow_back_sharp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            issueController.issueModel?.title ?? "Error",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Blocked :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              SizedBox(width: width * 0.03),
                              Switch(
                                value: issueController
                                        ?.issueModel?.blocked?.isBlocked ??
                                    true,
                                onChanged: (bool isSwitched) {
                                  issueController.setFetching(true);
                                  if (issueController
                                          .issueModel!.blocked.isBlocked ==
                                      false) {
                                    issueController.bockIssueRequest(
                                        context, widget.businessId);
                                  } else {
                                    issueController.unbockIssueRequest(
                                        context, widget.businessId);
                                  }
                                },
                              ),
                              SizedBox(width: width * 0.08),
                              Text(
                                "Critical :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              SizedBox(width: width * 0.03),
                              Switch(
                                value: issueController
                                        ?.issueModel?.critical?.isCritical ??
                                    true,
                                onChanged: (bool isSwitched) {
                                  issueController.setFetching(true);
                                  if (issueController
                                          .issueModel!.critical.isCritical ==
                                      false) {
                                    issueController.markCriticalIssueRequest(
                                        context, widget.businessId);
                                  } else {
                                    issueController.unmarkCriticalIssueRequest(
                                        context, widget.businessId);
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Next follow up date :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              Text(
                                issueController.issueModel?.nextFollowUpDate ??
                                    "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );

                                    if (selectedDate != null) {
                                      setState(() {
                                        // Extract day, month, and year from the selected date
                                        int day = selectedDate.day;
                                        int month = selectedDate.month;
                                        int year = selectedDate.year;

                                        // Now you can use day, month, and year as needed
                                        print("$year-$month-$day");
                                        String deliveryDate =
                                            "$year-$month-$day";
                                        String validDeliveryDate =
                                            convertDateFormat(deliveryDate);
                                        issueController.setFetching(true);
                                        issueController
                                            .updateNextFollowUpDateRequest(
                                                context,
                                                widget.businessId,
                                                validDeliveryDate);
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.edit))
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery date :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              Text(
                                issueController.issueModel?.deliveryDate ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );

                                    if (selectedDate != null) {
                                      setState(() {
                                        // Extract day, month, and year from the selected date
                                        int day = selectedDate.day;
                                        int month = selectedDate.month;
                                        int year = selectedDate.year;

                                        // Now you can use day, month, and year as needed
                                        print("$year-$month-$day");
                                        String deliveryDate =
                                            "$year-$month-$day";
                                        String validDeliveryDate =
                                            convertDateFormat(deliveryDate);
                                        issueController.setFetching(true);
                                        issueController
                                            .updateDeliveryDateRequest(
                                                context,
                                                widget.businessId,
                                                validDeliveryDate);
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.edit))
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Delayed:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              SizedBox(
                                width: width * 0.05,
                              ),
                              Text(
                                issueController.issueModel?.delayed
                                        .toString() ??
                                    "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text(
                            "Chats:",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Column(
                            children: issueController.messages?.map((message) {
                                  bool isMe = message.sender.id ==
                                      (homeController.userModel?.id ??
                                          ""); // Example condition
                                  if(message.isAttachment){
                                    return DocumentBubble(message: message , isMe: isMe );
                                  }
                                  return ChatBubble(
                                      message: message, isMe: isMe);
                                }).toList() ??
                                [],
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: Offset(0, -1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // Assuming this is inside an async function
                            /*
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              PlatformFile platformFile = result.files.first;

                              // Get the file object
                              File file = File(platformFile.path!);

                              // Now you can use 'file' instead of 'platformFile'
                              issueController.uploadDocument(file);

                              String fileName = platformFile.name!;

                              print(fileName);
                              */
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              PlatformFile platformFile = result.files.first;
                              File file = File(platformFile.path!);
                              String docUrl =
                                  await issueController.uploadDocument(file);

                              if (docUrl == "failure") {
                                showSnackBar(
                                    context,
                                    "Unable to upload document!!",
                                    failureColor);
                                return;
                              } else {
                                // Get filename and file type
                                String fileName = platformFile.name;
                                String fileType = platformFile.extension ?? "unknown";

                                socket.emit('issue-message-doc', {
                                  'issueId': widget.issueId,
                                  'businessId': widget.businessId,
                                  'message': {
                                    'sender': {
                                      'id': homeController.userModel?.id ?? "",
                                      'name':
                                          homeController.userModel?.name ?? ""
                                    },
                                    'isAttachment': true,
                                    "attachments": {
                                      "url": docUrl,
                                      "type": fileType,
                                      "name": fileName
                                    }
                                  },
                                });

                              }
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 24.0,
                            child: Icon(
                              Icons.folder,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: TextField(
                              controller: messageContentController,
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: () {
                            socket.emit('issue-message', {
                              'issueId': widget.issueId,
                              'businessId': widget.businessId,
                              'message': {
                                'sender': {
                                  'id': homeController.userModel?.id ?? "",
                                  'name': homeController.userModel?.name ?? ""
                                },
                                'content': messageContentController.text,
                              },
                            });

                            final newMessage = MessageModel(
                                sender: Sender(
                                  id: homeController.userModel?.id ?? "",
                                  name: homeController.userModel?.name ?? "",
                                ),
                                content: messageContentController.text,
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
                            setState(() {});

                            messageContentController.text = "";
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 24.0,
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (issueController
                    .isFetching) // Show circular progress indicator conditionally
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ]);
      }),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;

  const ChatBubble({
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

    final Color color = isMe ? Colors.lightBlue : Colors.grey[300]!;

    final maxWidth =
        MediaQuery.of(context).size.width * 0.8; // 80% of total mobile width

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.sender.name,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              message?.content ?? "",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DocumentBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;

  const DocumentBubble({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlignmentGeometry alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isMe ? Colors.lightBlue : Colors.grey[300],
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
                  message.sender.name,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  ((message.attachments?.name?.toString()?.length ?? 0) > 20)
                      ? '${message.attachments?.name?.toString()?.substring(0, 20)}...'
                      : message.attachments?.name?.toString() ?? "",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                  ),
                ),

              ],
            ),
            SizedBox(width: 8.0),
            if (isMe) RoundDownloadButton(),
          ],
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
