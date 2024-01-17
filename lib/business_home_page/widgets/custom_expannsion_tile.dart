import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/business_home_page/widgets/issue_tile.dart';
import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final List<IssueModel>? issues;

  CustomExpansionTile({required this.title, this.issues});

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: _isExpanded ? 1.0 : 0.0),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Column(
          children: [
            ListTile(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              title: Text(widget.title , style: TextStyle(fontWeight: FontWeight.bold),),
              trailing: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
            ),
            ClipRect(
              child: Align(
                heightFactor: value,
                child: child,
              ),
            ),
          ],
        );
      },
      child: _isExpanded
          ? Column(
        children: [
          for (IssueModel issue in widget.issues ?? [])
            CustomIssueTile(issue: issue),
        ],
      )
          : SizedBox.shrink(),
    );
  }

}


