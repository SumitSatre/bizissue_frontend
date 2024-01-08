import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/widgets/buttons/custom_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Consumer<BusinessController>(builder: (context, ref, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjusted to space items evenly
              children: [
                Row(
                  children: [
                    Center(child: const CustomMenuButton()),
                    SizedBox(width: width * 0.04),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ref.businessModel?.business?.name ?? "Business",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ref.businessModel?.user?.role ?? "role",
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
                CupertinoButton(
                  child: Icon(CupertinoIcons.ellipsis_vertical, color: Colors.black ,size: 25,),
                  onPressed: () {
                    // Handle button press
                  },
                ),
              ],
            ),

          ],
        ),
      );
    });
  }
}
