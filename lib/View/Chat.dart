import 'package:flutter/material.dart';
import '../model/user.dart';
import 'conversa_tile.dart';
import '../model/mensagem.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Mensagem> mensagens = [
      Mensagem(User("davi", 1001), User("Felipe", 1002), "olá"),
      Mensagem(User("Felipe", 1002), User("davi", 1001), "opaa"),
    ];

    /*return Row(
      children:<Widget> [
        Expanded(
          child: ListView.builder(
            itemCount: mensagens.length,
            itemBuilder: (BuildContext context, int index) {
              return Text("mensagem");
            },
          ),
        ),
      ],
    );*/

    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:<Widget>[
          Expanded(
          child: ListView.builder(
            itemCount: mensagens.length,
            itemBuilder: (BuildContext context, int index) {
              return Text("${mensagens[index]}");
            },
          ),
        ),
          const TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Número',
            ),
          ),
        ],
      ),
    );
  }
}

Widget messagesList() => ListView.builder(
      itemCount: 0,
      itemBuilder: (BuildContext context, int index) {
        return Text("mensagem");
      },
    );
