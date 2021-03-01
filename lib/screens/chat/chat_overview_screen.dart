import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/logic/models/chat/chat/chat_response/chat_response.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/chat_service.dart';
import 'package:flexrent/widgets/chat/chat_overview_box.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';
import 'package:flexrent/widgets/styles/error_box.dart';
import 'package:flutter/material.dart';
import 'package:flexrent/logic/blocs/chat/chat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: 'Chats',
      leading: Container(),
      bodyWidget: _ChatOverviewBody(),
    );
  }
}

class _ChatOverviewBody extends StatefulWidget {
  @override
  __ChatOverviewBodyState createState() => __ChatOverviewBodyState();
}

class __ChatOverviewBodyState extends State<_ChatOverviewBody> {
  Future<ChatResponse> chatResponse;

  @override
  void initState() {
    super.initState();
    _getChatResponse();
  }

  void _getChatResponse() {
    setState(() {
      chatResponse = ApiChatService().getAllChatsByLoggedInUser(page: 1);
    });
  }

  List<Widget> _buildChats({ChatResponse chatResponse}) {
    List<Widget> chats = [];
    for (Chat chat in chatResponse.chats) {
      chats.add(
        ChatOverviewBox(
          chat: chat,
        ),
      );
      if (chat != chatResponse.chats.last) {
        chats.add(
          Padding(
            padding: EdgeInsets.only(left: 23, right: 23, bottom: 5),
            child: Divider(
              height: 20.0,
              color: Theme.of(context).accentColor,
            ),
          ),
        );
      }
    }
    return chats;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state.chatResponse != null) {
          Stream<ChatResponse> _chatResponse = state.chatResponse;
          return StreamBuilder(
            stream: _chatResponse,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ChatResponse __chatResponse = snapshot.data;
                return Column(
                  children: _buildChats(chatResponse: __chatResponse),
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
    );
  }
}
