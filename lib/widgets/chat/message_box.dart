import 'package:flexrent/logic/models/chat/chat_message/chat_message.dart';
import 'package:flexrent/logic/services/helper_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final ChatMessage message;

  MessageBox({this.message});

  bool _isMyMessage({BuildContext context}) {
    return ((HelperService.getUser(context: context)).userId ==
        message.fromUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _isMyMessage(context: context)
          ? Alignment.topRight
          : Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
        constraints:
            BoxConstraints(maxWidth: 0.7 * MediaQuery.of(context).size.width),
        decoration: BoxDecoration(
          color: _isMyMessage(context: context)
              ? Theme.of(context).accentColor
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          message.messageContent,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 15.0,
            height: 1.35,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
