
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

class ConversaTile extends StatelessWidget {

  const ConversaTile(this.chat,{super.key, this.onPressed=(pressedDefault)});
  final Conversa chat;
  final Function onPressed;



  @override
  Widget build(BuildContext context) {
     
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext ctx){return ChatScreen(chat.outro);})
        );

      },
      child: ListTile(
        title: Text(chat.outro.nome),
        subtitle:Text(chat.mensagens.last.texto),

      ),
    );
  }
}

void pressedDefault ()
{
  return;
}