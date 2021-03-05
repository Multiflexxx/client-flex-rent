import 'package:flexrent/logic/models/chat/chat/chat_response/chat_response.dart';
import 'package:flexrent/logic/models/models.dart';
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
  ChatResponse chatResponse;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildChats({ChatResponse chatResponse}) {
    List<Widget> chats = [];

    if (chatResponse != null) {
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
    }
    return chats;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatOverviewSuccess) {
          setState(() {
            chatResponse = state.chatResponse;
          });
        }
      },
      child: Column(
        children: [
          if (chatResponse != null)
            Column(
              children: _buildChats(chatResponse: chatResponse),
            )
          else
            ErrorBox(
              errorText: 'Du hast noch keine Chats mit anderen Flexren.',
            )
        ],
      ),
    );
  }
}
