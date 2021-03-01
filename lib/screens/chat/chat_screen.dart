import 'dart:developer';

import 'package:flexrent/logic/blocs/chat/chat.dart';
import 'package:flexrent/logic/exceptions/chat_exception.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/chat_service.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/widgets/chat/message_box.dart';
import 'package:flexrent/widgets/styles/error_box.dart';
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
  Future<ChatMessageResponse> chatMessageResponse;
  final _messageController = TextEditingController();
  User user;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context).add(
      ChatMessageTickerStarted(chatId: widget.chat.chatId, page: 1),
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
    BlocProvider.of<ChatBloc>(context).add(ChatOverviewTickerStarted(page: 1));
    Navigator.of(context).pop();
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
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state.chatMessageResponse != null) {
                      Stream<ChatMessageResponse> chatMessageResponse =
                          state.chatMessageResponse;
                      return StreamBuilder(
                        stream: chatMessageResponse,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            ChatMessageResponse chatMessageResponse =
                                snapshot.data;
                            return ListView.builder(
                              reverse: true,
                              itemCount: chatMessageResponse.messages.length,
                              itemBuilder: (context, index) {
                                ChatMessage message =
                                    chatMessageResponse.messages[index];
                                return MessageBox(message: message);
                              },
                            );
                          } else if (snapshot.hasError) {
                            ChatException e = snapshot.error;
                            return ErrorBox(errorText: e.message);
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
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
