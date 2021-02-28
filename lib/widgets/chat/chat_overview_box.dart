import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/screens/chat/chat_overview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ChatOverviewBox extends StatefulWidget {
  final Chat chat;

  ChatOverviewBox({
    this.chat,
  });

  @override
  _ChatOverviewBoxState createState() => _ChatOverviewBoxState();
}

class _ChatOverviewBoxState extends State<ChatOverviewBox> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('de_DE', null);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushNewScreen(
        context,
        screen: ChatOverviewScreen(),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.red,
          border: Border(
            bottom: BorderSide(
              width: 0.25,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: widget.chat.chatPartner.profilePicture != ''
                      ? CachedNetworkImage(
                          imageUrl: widget.chat.chatPartner.profilePicture,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image(
                            width: 100,
                            height: 100,
                            image: AssetImage('assets/images/jett.jpg'),
                          ),
                          errorWidget: (context, url, error) => Image(
                            width: 100,
                            height: 100,
                            image: AssetImage('assets/images/jett.jpg'),
                          ),
                        )
                      : Image(
                          width: 100,
                          height: 100,
                          image: AssetImage('assets/images/jett.jpg'),
                        ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.chat.chatPartner.firstName} ${widget.chat.chatPartner.lastName}",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                        height: 1.35,
                      ),
                    ),
                    Container(
                      width: 0.45 * MediaQuery.of(context).size.width,
                      child: Text(
                        widget.chat.lastMessage.messageContent,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14.0,
                          height: 1.35,
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  _getFormattedDate(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14.0,
                    height: 1.35,
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('Test'),
                Badge(
                  showBadge:
                      (widget.chat.unreadMessages == true) ? true : false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedDate() {
    DateTime date = widget.chat.lastMessage.createdAt;
    DateTime today = DateTime.now();

    int dateDiff = DateTime(date.year, date.month, date.day)
        .difference(DateTime(today.year, today.month, today.day))
        .inDays;

    if (dateDiff == 0) {
      return '${DateFormat('Hm', 'de').format(widget.chat.lastMessage.createdAt)}';
    } else if (dateDiff == -1) {
      return 'Gestern';
    } else {
      return '${DateFormat('yMd', 'de').format(widget.chat.lastMessage.createdAt)}';
    }
  }
}
