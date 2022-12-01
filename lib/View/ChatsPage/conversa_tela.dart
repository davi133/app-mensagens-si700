import 'package:UnitalkV0_2/Blocs/Chats/chat_list_bloc.dart';
import 'package:UnitalkV0_2/Blocs/Chats/chat_list_event.dart';
import 'package:UnitalkV0_2/Blocs/Chats/chat_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../View/ChatsPage/Chat.dart';
import '../../Dados/chatList.dart';
import '../../model/Conversa.dart';

class TelaConversas extends StatelessWidget {
  const TelaConversas({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<ChatListBloc, ChatListState>(
      bloc: BlocProvider.of<ChatListBloc>(context),
      builder: (context, state) {
        if (state is ChatListFetchingState) {
          BlocProvider.of<ChatListBloc>(context).add(ChatListFetchEvent());
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChatListLoadedState) {
          List<Conversa> chats = state.conversas;
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) {
              return ConversaTile(chats.elementAt(index));
            },
          );
        }
        else if (state is ChatListErrorState)
        {
          return  Center(child: Text("Erro ao carregar lista de mensagens: ${state.errorMessage}"),);
        }
        else
        {
          return const Center(child: Text("erro inesperado"),);
        }
      },
    );
  }
}

class ConversaTile extends StatefulWidget {
  //TILE

  const ConversaTile(this.chat, {super.key});
  final Conversa chat;
  //final Function onPressed;

  @override
  State<ConversaTile> createState() => _ConversaTileState();
}

class _ConversaTileState extends State<ConversaTile> {
  void reloadChatTile() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String previewText = "";
    if (widget.chat.mensagens.isNotEmpty) {
      previewText = widget.chat.mensagens.last.texto;
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext ctx) {
          return ChatScreen(
            widget.chat.User2,
            onNewMessage: reloadChatTile,
          );
        }));
      },
      child: ListTile(
        title: Text(widget.chat.User2.nome),
        subtitle: Text(previewText),
      ),
    );
  }
}

void pressedDefault() {
  return;
}
