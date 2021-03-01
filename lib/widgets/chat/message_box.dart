import 'package:flexrent/logic/models/chat/chat_message/chat_message.dart';
import 'package:flexrent/logic/services/helper_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

      // child: Flexible(
      //   child: Padding(
      //     padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      //     child: Container(
      //       padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      //       decoration: BoxDecoration(
      //         color: _isMyMessage(context: context)
      //             ? Theme.of(context).accentColor
      //             : Theme.of(context).cardColor,
      //         borderRadius: BorderRadius.circular(10.0),
      //       ),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.end,
      //         children: [
      //           Text(message.messageContent),
      //               Text('${DateFormat('Hm', 'de').format(message.createdAt)}',),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),

      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        constraints:
            BoxConstraints(maxWidth: 0.7 * MediaQuery.of(context).size.width),
        decoration: BoxDecoration(
          color: _isMyMessage(context: context)
              ? Colors.deepPurple
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.only(right: 20.0),
              child: Text(
                message.messageContent,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16.0,
                  height: 1.35,
                ),
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              '${DateFormat('Hm', 'de').format(message.createdAt)}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13.0,
                height: 1,
                // fontWeight: FontWeight.w300,
              
              ),
            ),
          ],
        ),
        //     Text.rich(
        //   TextSpan(
        //       text: message.messageContent,
        //       style: TextStyle(
        //         color: Theme.of(context).primaryColor,
        //         fontSize: 15.0,
        //         height: 1.35,
        //         fontWeight: FontWeight.w300,
        //       ),
        //       children: <InlineSpan>[
        //         WidgetSpan(
        //             alignment: PlaceholderAlignment.middle ,
        //             // baseline: TextBaseline.alphabetic,
        //             Sizedbo
        //           ),
        //         TextSpan(
        //           text: 'heute',
        //         ),
        //       ]),
      ),
      //         Column(

      //       children: [
      //         Text(
      //           message.messageContent,
      //           style: TextStyle(
      //             color: Theme.of(context).primaryColor,
      //             fontSize: 15.0,
      //             height: 1.35,

      //           ),
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.end,
      //           children: [
      //             Text(
      //               '${DateFormat('Hm', 'de').format(message.createdAt)}',
      //               style: TextStyle(
      //                 color: Theme.of(context).primaryColor,
      //                 fontSize: 15.0,
      //                 height: 1.35,
      //                 fontWeight: FontWeight.w300,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ],
      //     )),
    );
  }
}
