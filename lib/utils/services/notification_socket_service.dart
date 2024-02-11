import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/home/models/user_model.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';

class NotificationSocketService {
  late IO.Socket socket;

  void initSocket(BuildContext context, String userId) {
    socket = IO.io(
      'https://ophize-backend.onrender.com/home/notifications',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.connect();

    socket.onConnect((_) {
      print('connected in home page');
      socket.emit("user-joined", userId);
    });

    socket.on('new-notification', (data) {
      print("This data is received : ${data}");
      final newNotification = NotificationModel(
        notificationCategory: data['notificationCategory'],
        content: data['content'],
        createdDate: DateTime.fromMillisecondsSinceEpoch(data['createdDate']),
        businessId: data['businessId'] ?? "",
        businessName: data['businessName'] ?? "",
      );

      final homeController = Provider.of<HomeProvider>(context, listen: false);

      if (homeController.userModel != null) {
        homeController.userModel!.notifications!.insert(0, newNotification);
        showSnackBar(context, data['content'], successColor);
        homeController.notifyListeners();
      }
    });

    socket.on('new-notification-add-business', (data) {
      print("This data is received : ${data}");
      final newNotification = NotificationModel(
        notificationCategory: data["eventData"]['notificationCategory'],
        content: data["eventData"]['content'],
        createdDate: DateTime.fromMillisecondsSinceEpoch(data["eventData"]['createdDate']),
        businessId: data["eventData"]['businessId'] ?? "",
        businessName: data["eventData"]['businessName'] ?? "",
      );

      final homeController = Provider.of<HomeProvider>(context, listen: false);

      if (homeController.userModel != null) {
        homeController.userModel!.notifications!.insert(0, newNotification);
      }

      Business newBusiness = Business(
        businessId: data["newBusiness"]['businessId'],
        name:  data["newBusiness"]['name'],
        userType: data["newBusiness"]['userType']
      );

      if (homeController.userModel != null) {
        homeController.userModel!.businesses!.add(newBusiness);
        showSnackBar(context, "You are added to new business ${data["newBusiness"]['name']}", successColor);
        homeController.notifyListeners();
      }
    });

  }

  void closeSocket() {
    socket.disconnect();
  }
}
