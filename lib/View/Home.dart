import 'package:flutter/material.dart';
import 'contato_tela.dart';
import "conversa_tela.dart";
import 'Chat.dart';
import '../model/user.dart';



class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("WhatsApp 2"),
            bottom: const TabBar(tabs: [
              Tab(text: "Conversa"),
              Tab(text: "Contatos"),
              Tab(text: "chat"),
            ]),
          ),
          body: TabBarView(children: [
            TelaConversas(),
            TelaContatos(),
            ChatScreen(),
          ]),
        ),
      );
  }
}