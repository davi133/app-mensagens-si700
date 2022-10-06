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

    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MessageList(mensagens),
          Row(
            children: [
              const Expanded(
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Escreva uma mensagem',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Icon(Icons.arrow_forward),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  MessageList(this.mensagens, {super.key});
  List<Mensagem> mensagens;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: mensagens.length,
        itemBuilder: (BuildContext context, int index) {
          return MessageTile(mensagens[index]);
        },
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile(this.msg,{super.key});
  final Mensagem msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("$msg"),
    );
  }
}