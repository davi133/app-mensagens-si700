import 'package:flutter/material.dart';
import '../model/user.dart';

class ConversaTile extends StatelessWidget {

  const ConversaTile(this.user,{super.key});
  final User user;

  @override
  Widget build(BuildContext context) {
    //return Text(user.toString());

    return ListTile(
      title: Text(user.nome),
      subtitle:const Text("alguma prévia do texto"),

    );
  }
}