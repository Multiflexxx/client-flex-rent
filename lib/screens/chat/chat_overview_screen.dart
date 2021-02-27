import 'package:flexrent/logic/services/helper_service.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';
import 'package:flutter/material.dart';

class ChatOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: 'Chats',
      leading: Container(),
      bodyWidget: Container(
        child: Text('Test'),
      ),
    );
  }
}
