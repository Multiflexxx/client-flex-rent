import 'package:flexrent/logic/exceptions/chat_exception.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/chat_service.dart';
import 'package:flexrent/widgets/styles/error_box.dart';
import 'package:flutter/material.dart';

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
      color: Colors.purple,
      child: Text('Hello'),
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
      body: Column(
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
                      ChatMessage message = chatMessageResponse.messages[index];
                      return Text(
                        message.messageContent,
                        style: TextStyle(color: Colors.white),
                      );
                      // return MessageBox(message);
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
    );
  }
}
