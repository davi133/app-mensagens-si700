import 'package:UnitalkV0_2/Blocs/Chats/chat_list_bloc.dart';
import 'package:UnitalkV0_2/Blocs/Chats/chat_list_event.dart';
import 'package:UnitalkV0_2/Blocs/Chats/chat_list_state.dart';
import 'package:UnitalkV0_2/Dados/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../View/ChatsPage/Chat.dart';
import '../../model/user.dart';
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
          if (chats.isEmpty)
          {
            return const Center(child:Text("Você ainda não começou nenhuma conversa"));
          }
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) {
              return ConversaTile(chats.elementAt(index));
            },
          );
        } else if (state is ChatListErrorState) {
          return Center(
            child: Text(
                "Erro ao carregar lista de mensagens: ${state.errorMessage}"),
          );
        } else {
          return const Center(
            child: Text("erro inesperado"),
          );
        }
      },
    );
  }
}

class ConversaTile extends StatelessWidget {
  //TILE

  const ConversaTile(this.chat, {super.key});
  final Conversa chat;

  @override
  Widget build(BuildContext context) {
    String previewText = "";
    if (chat.mensagens.isNotEmpty) {
      previewText = chat.mensagens.last.texto;
      print("setting preview text");
    }
    User other = chat.User1.numero == AuthenticationProvider.helper.user.numero
        ? chat.User2
        : chat.User1;

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext ctx) {
          return ChatWith(chat);
        }));
      },
      child: ListTile(
        title: Text(other.nome),
        subtitle: Text(previewText),
      ),
    );
  }
}
