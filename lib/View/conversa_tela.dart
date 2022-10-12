
import 'package:flutter/material.dart';
import '../model/user.dart';
import 'package:flutter_atividade2/View/Chat.dart';
import '../Dados/chatList.dart';
import '../model/Conversa.dart';


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
     
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext ctx){return ChatScreen(widget.chat.outro, onNewMessage: reloadChatTile,);})
        );

      },
      child: ListTile(
        title: Text(widget.chat.outro.nome),
        subtitle:Text(widget.chat.mensagens.last.texto),

      ),
    );
  }
}

void pressedDefault ()
{
  return;
}