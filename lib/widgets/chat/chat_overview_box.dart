import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexrent/logic/models/chat/chat_message/chat_message.dart';
import 'package:flexrent/logic/models/user/user.dart';
import 'package:flexrent/screens/chat/chat_overview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ChatOverviewBox extends StatefulWidget {
  final User chatPartner;
  final ChatMessage lastMessage;
  final bool unreadMessages;

  ChatOverviewBox({
    this.chatPartner,
    this.lastMessage,
    this.unreadMessages,
  });

  @override
  _ChatOverviewBoxState createState() => _ChatOverviewBoxState();
}

class _ChatOverviewBoxState extends State<ChatOverviewBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushNewScreen(
        context,
        screen: ChatOverviewScreen(),
      ),
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.25,
                color: Theme.of(context).accentColor,
              ),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: widget.chatPartner.profilePicture != ''
                    ? CachedNetworkImage(
                        imageUrl: widget.chatPartner.profilePicture,
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
              Column(
                children: [
                  Text(
                    "$widget.chatPartner.firstName $widget.chatPartner.lastName",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.0,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    widget.lastMessage.messageContent,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14.0,
                      height: 1.35,
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    widget.lastMessage.createdAt.toString(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14.0,
                      height: 1.35,
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Badge(
                    showBadge: (widget.unreadMessages == true) ? true : false,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
