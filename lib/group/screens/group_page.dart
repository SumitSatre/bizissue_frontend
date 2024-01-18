import 'package:bizissue/group/controller/group_controller.dart';
import 'package:bizissue/group/widgets/group_tile.dart';
import 'package:bizissue/business_home_page/models/group_short_model.dart'; // Import your GroupShortModel class
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizissue/utils/utils.dart';
class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {

  void callInit(BuildContext context , String businessId) async {
    try {
      await Provider.of<GroupProvider>(context, listen: false)
          .getGroupsList(businessId)
          .then((_) {
        setState(() {});
      });
    } catch (error) {
      print('Error in callInit: $error');
      // here we can set userGroupsList as [] so screen stops circular widget
      showSnackBar(context, "Unable to fetch groups data!!", failureColor);
    }
  }


  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeProvider>(context, listen: false);
    final groupController = Provider.of<GroupProvider>(context, listen: false);

    if(groupController.userGroupslist == null){
      callInit(context, homeController.selectedBusiness);
    }

    return Scaffold(
      body: groupController.userGroupslist == null ?
      Center(child: CircularProgressIndicator(),)
          :
      RefreshIndicator(
        onRefresh: ()async{
          groupController.clearGroupPageData();
          setState(() {
          });
        },
        child: ListView.builder(
          // physics: BouncingScrollPhysics(),
          itemCount: groupController.userGroupslist?.length ?? 0,
          itemBuilder: (context, index) {
            GroupShortModel group = groupController.userGroupslist![index];
            return GroupTile(group: group);
          },
        ),
      ),
    );
  }
}
