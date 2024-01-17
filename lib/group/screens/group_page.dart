import 'package:bizissue/group/controller/group_controller.dart';
import 'package:bizissue/group/widgets/group_tile.dart';
import 'package:bizissue/business_home_page/models/group_short_model.dart'; // Import your GroupShortModel class
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeProvider>(context, listen: false);
    final groupController = Provider.of<GroupProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<List<GroupShortModel>>(
              future: groupController.getGroupsList(homeController.selectedBusiness),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data == null) {
                  return Center(child: Text('Error loading data'));
                } else {
                  List<GroupShortModel> groupList = snapshot.data!;
                  return ListView.builder(
                    itemCount: groupList.length,
                    itemBuilder: (context, index) {
                      GroupShortModel group = groupList[index];
                      return GroupTile(group: group);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
