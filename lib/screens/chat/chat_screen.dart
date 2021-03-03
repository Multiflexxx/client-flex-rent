import 'dart:developer';

import 'package:flexrent/logic/blocs/chat/chat.dart';
import 'package:flexrent/logic/config/static_consts.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/chat_service.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/widgets/chat/message_box.dart';
import 'package:flexrent/widgets/offer/offer_request_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({Key key, this.chat}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  User user;

  ChatMessageResponse chatMessageResponse;
  List<ChatMessage> chatMessages;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context).add(
      ChatMessageFirstMessages(
        chatId: widget.chat.chatId,
      ),
    );
    user = HelperService.getUser(context: context);
  }

  void _sendMessage() async {
    if (_messageController.text != null || _messageController.text != '') {
      ChatMessage chatMessage = ChatMessage(
          chatId: widget.chat.chatId,
          fromUserId: user.userId,
          toUserId: widget.chat.chatPartner.userId,
          messageContent: _messageController.text,
          messageType: 2);
      _messageController.clear();
      ApiChatService().sendMessage(chatMessage: chatMessage);
    }
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 60.0,
      child: Row(
        children: <Widget>[
          Ink(
            width: 45.0,
            decoration: ShapeDecoration(
              color: Theme.of(context).accentColor,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(
                Feather.image,
                color: Theme.of(context).primaryColor,
                size: 22.5,
              ),
              onPressed: () => print('bild'),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              onSubmitted: (value) => _sendMessage(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              decoration: InputDecoration(
                hintText: 'Nachricht',
                hintStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                fillColor: Theme.of(context).cardColor,
                filled: true,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: null,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Ink(
            width: 45.0,
            decoration: ShapeDecoration(
                color: Theme.of(context).accentColor, shape: CircleBorder()),
            child: IconButton(
              icon: Icon(
                Icons.send_rounded,
                color: Theme.of(context).primaryColor,
                size: 22.5,
              ),
              onPressed: () => _sendMessage(),
            ),
          ),
        ],
      ),
    );
  }

  void _popScreen() {
    BlocProvider.of<ChatBloc>(context).add(ChatMessageTickerStopped());
    BlocProvider.of<ChatBloc>(context).add(ChatOverviewTickerStopped());
    BlocProvider.of<ChatBloc>(context).add(ChatOverviewTickerStarted(page: 1));
    Navigator.of(context).pop();
  }

  Future<List<Widget>> _getMessageWidgets(
      {List<ChatMessage> chatMessages}) async {
    List<Widget> messageWidgetsList = [];
    for (ChatMessage chatMessage in chatMessages) {
      messageWidgetsList.add(
        await _getMessageContentBox(message: chatMessage),
      );
    }
    return messageWidgetsList;
  }

  Future<Widget> _getMessageContentBox({ChatMessage message}) async {
    if (message.messageType == MessageType.OFFER_REQUEST) {
      OfferRequest offerRequest = await ApiOfferService()
          .getOfferRequestbyRequest(
              offerRequest: OfferRequest(requestId: message.messageContent));
      return Container(
        child: OfferRequestCard(
          offerRequest: offerRequest,
          lessor: false,
        ),
      );
    }

    if (message.messageType == MessageType.IMAGE) {
      // TODO: Image Box!
      return MessageBox(message: message);
    }

    return MessageBox(message: message);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _popScreen();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.chat.chatPartner.firstName} ${widget.chat.chatPartner.lastName}',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Feather.arrow_left,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              _popScreen();
            },
          ),
          elevation: 0.0,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Expanded(
                child: BlocListener<ChatBloc, ChatState>(
                  listener: (context, state) {
                    if (state is ChatMessageFirstSuccess) {
                      setState(() {
                        chatMessageResponse = state.chatMessageResponse;
                        chatMessages = chatMessageResponse.messages;
                      });

                      BlocProvider.of<ChatBloc>(context).add(
                        ChatMessageTickerStarted(
                          chatId: widget.chat.chatId,
                          lastMessageCount: chatMessages.first.messageCount,
                        ),
                      );
                    }

                    if (state is ChatMessageSuccess) {
                      setState(() {
                        chatMessageResponse = state.chatMessageResponse;
                        chatMessages.insertAll(
                            0, state.chatMessageResponse.messages);
                      });

                      BlocProvider.of<ChatBloc>(context).add(
                        ChatMessageTickerStarted(
                          chatId: widget.chat.chatId,
                          lastMessageCount: chatMessages.first.messageCount,
                        ),
                      );
                    }

                    if (state is ChatMessageOldSuccess) {
                      setState(() {
                        chatMessages.addAll(state.chatMessageResponse.messages);
                      });
                    }
                  },
                  child: FutureBuilder(
                    future: _getMessageWidgets(chatMessages: chatMessages),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return NotificationListener<ScrollEndNotification>(
                          onNotification: (notification) {
                            var metrics = notification.metrics;
                            if (metrics.atEdge) {
                              if (metrics.pixels != 0) {
                                BlocProvider.of<ChatBloc>(context).add(
                                  ChatMessageOldMessages(
                                    chatId: widget.chat.chatId,
                                    firstMessageCount:
                                        chatMessages.last.messageCount,
                                  ),
                                );
                              }
                            }

                            return true;
                          },
                          child: ListView(
                            reverse: true,
                            children: snapshot.data,
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }
}
