
import 'package:flutter/material.dart';
import '../../View/ChatsPage/Chat.dart';
import '../../Dados/chatList.dart';
import '../../model/Conversa.dart';


class TelaConversas extends StatelessWidget {
  const TelaConversas({super.key});

  @override
  Widget build(BuildContext context) {
    List<Conversa> chats = chatList;


    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (BuildContext context, int index) {
        return ConversaTile(chats.elementAt(index));
      },
    );
  }
}

class ConversaTile extends StatefulWidget {

  const ConversaTile(this.chat,{super.key});
  final Conversa chat;
  //final Function onPressed;

  @override
  State<ConversaTile> createState() => _ConversaTileState();
}

class _ConversaTileState extends State<ConversaTile> {

  void reloadChatTile()
  {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    String previewText = "";
    if (widget.chat.mensagens.isNotEmpty)
    {
      previewText =widget.chat.mensagens.last.texto;
    }


    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext ctx){return ChatScreen(widget.chat.User2, onNewMessage: reloadChatTile,);})
        );

      },
      child: ListTile(
        title: Text(widget.chat.User2.nome),
        subtitle:Text(previewText),

      ),
    );
  }
}

void pressedDefault ()
{
  return;
}