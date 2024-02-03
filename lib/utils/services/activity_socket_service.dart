import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';

class ActivitySocketService {
  late IO.Socket socket;

  void initSocket(BuildContext context) {
    socket = IO.io(
      'https://bizissue-backend.onrender.com/business/activity',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.connect();

    socket.onConnect((_) {
      print('connected in home');
    });

    socket.on('business-new-activity', (data) {
      print("This data is received : ${data}");
      final newActivity = ActivityModel(
        activityCategory: data['activityCategory'],
        content: data['content'],
        issueId: data['issueId'] ?? "",
        issueTitle: data['issueTitle'] ?? "",
        createdDate: DateTime.fromMillisecondsSinceEpoch(data['createdDate']),
        groupId: data['groupId'] ?? "",
        groupName: data['groupName'] ?? "",
      );

      final businessController =
      Provider.of<BusinessController>(context, listen: false);

      if (businessController.businessModel != null) {
        businessController.businessModel!.user.activities.insert(0, newActivity);
        businessController.notifyListeners();
      }
    });
  }

  void connectToBusiness(String username){
    socket.emit("user-joined", username);
  }

  void closeSocket() {
    socket.disconnect();
  }
}
