import 'package:flexrent/logic/exceptions/chat_exception.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/chat_service.dart';
import 'package:flexrent/widgets/styles/error_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../widgets/chat/message_box.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({Key key, this.chat}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<ChatMessageResponse> chatMessageResponse;

  @override
  void initState() {
    super.initState();
    _getAllChatMessages();
  }

  void _getAllChatMessages() async {
    setState(() {
      chatMessageResponse = ApiChatService()
          .getAllMessagesByChatId(chatId: widget.chat.chatId, page: 1);
    });
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
              onPressed: () => print('send'),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: TextField(
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
              onPressed: () => print('send'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.chat.chatPartner.firstName} ${widget.chat.chatPartner.lastName}',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: chatMessageResponse,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ChatMessageResponse chatMessageResponse = snapshot.data;
                    return ListView.builder(
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
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }
}
