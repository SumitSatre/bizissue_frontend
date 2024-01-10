// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          GoRouter.of(context).goNamed(MyAppRouteConstants.businessRouteName);
        },
        child: const Icon(
          Icons.arrow_back_sharp,
          color: Colors.black,
        ),
      ),
    );
  }
}
