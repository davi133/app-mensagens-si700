import 'package:flutter/material.dart';
import 'package:flutter_atividade2/View/Chat.dart';
import '../model/user.dart';

class ConversaTile extends StatelessWidget {

  const ConversaTile(this.user,{super.key, this.onPressed=(pressedDefault)});
  final User user;
  final Function onPressed;


  @override
  Widget build(BuildContext context) {
    //return Text(user.toString());

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext ctx){return ChatScreen(user);})
        );

      },
      child: ListTile(
        title: Text(user.nome),
        subtitle:const Text("alguma prévia do texto"),

      ),
    );
  }
}

void pressedDefault ()
{
  return;
}