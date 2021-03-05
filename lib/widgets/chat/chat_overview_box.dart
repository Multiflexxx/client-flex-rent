import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexrent/logic/config/static_consts.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/screens/chat/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
      onTap: () {
        pushNewScreen(context,
            screen: ChatScreen(
              chat: widget.chat,
            ),
            withNavBar: false);
      },
      child: Container(
        margin: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 0, top: 0),
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        color: Colors.transparent,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: widget.chat.chatPartner.profilePicture != null
                  ? CachedNetworkImage(
                      imageUrl: widget.chat.chatPartner.profilePicture,
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image(
                        width: 75,
                        height: 75,
                        image: AssetImage('assets/images/jett.jpg'),
                      ),
                      errorWidget: (context, url, error) => Image(
                        width: 75,
                        height: 75,
                        image: AssetImage('assets/images/jett.jpg'),
                      ),
                    )
                  : Image(
                      width: 75,
                      height: 75,
                      image: AssetImage('assets/images/jett.jpg'),
                    ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.chat.chatPartner.firstName} ${widget.chat.chatPartner.lastName}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                          height: 1.35,
                        ),
                      ),
                      Text(
                        _getFormattedDate(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14.0,
                          height: 1.35,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 0.45 * MediaQuery.of(context).size.width,
                        child: Text(
                          _getMessageContent(),
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
                      Badge(
                        toAnimate: false,
                        shape: BadgeShape.square,
                        badgeColor: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10),
                        showBadge: widget.chat.unreadMessages,
                        badgeContent: Text(
                          'Neu',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Badge(
                        toAnimate: false,
                        shape: BadgeShape.square,
                        badgeColor: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10),
                        showBadge: !widget.chat.isAllowedToChat,
                        badgeContent: Icon(Feather.archive),
                      ),
                    ],
                  ),
                ],
              ),
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

  String _getMessageContent() {
    if (widget.chat.lastMessage.messageType == MessageType.OFFER_REQUEST) {
      return 'Anfrage';
    }

    if (widget.chat.lastMessage.messageType == MessageType.TEXT) {
      return widget.chat.lastMessage.messageContent;
    }

    if (widget.chat.lastMessage.messageType == MessageType.IMAGE) {
      return 'Bild';
    }

    return 'Hier ist etwas schief gelaufen.';
  }
}
