
import 'package:flutter/material.dart';
import '../model/user.dart';
import 'conversa_tile.dart';

class TelaConversas extends StatelessWidget {
  const TelaConversas({super.key});

  @override
  Widget build(BuildContext context) {
    List<User> users = [User("davi", 1001),User("Felipe", 1002)];


    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return ConversaTile(users.elementAt(index));
      },
    );
  }
}