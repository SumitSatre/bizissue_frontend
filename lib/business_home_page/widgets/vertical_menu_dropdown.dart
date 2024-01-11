import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VeriticalMenuDropDown extends StatefulWidget {
  @override
  _VeriticalMenuDropDownState createState() => _VeriticalMenuDropDownState();
}

class _VeriticalMenuDropDownState extends State<VeriticalMenuDropDown> {
  late String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return CupertinoButton(
      child: Icon(
        CupertinoIcons.ellipsis_vertical,
        color: Colors.black,
        size: 25,
      ),
      onPressed: () {
        showDropdown(context);
      },
    );
  }
}

void showDropdown(BuildContext context) async {
  final RenderBox button = context.findRenderObject() as RenderBox;
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(Offset(0-15, button.size.height-15), ancestor: overlay),
      button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
    ),
    Offset.zero & overlay.size,
  );

  final result = await showMenu(
    context: context,
    position: position,
    items: countryCodesList.map((String s) {
      return PopupMenuItem<String>(
        value: s,
        child: Text("  $s"),
      );
    }).toList(),
  );

  if (result != null) {
  }
}
List<String> countryCodesList = [
  "Requests",
  "Business profile"
];
