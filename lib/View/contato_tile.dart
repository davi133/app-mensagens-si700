import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/contato.dart';


class ContatoTile extends StatelessWidget {

  const ContatoTile(this.cont,{super.key});
  final Contato cont;

  @override
  Widget build(BuildContext context) {
    //return Text(user.toString());

    return ListTile(
      title: Text(cont.apelido),
      subtitle:const Text("email??? quem sabe"),

    );
  }
}