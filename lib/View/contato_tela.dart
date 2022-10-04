import 'package:flutter/material.dart';
import '../model/contato.dart';
import 'contato_tile.dart';

class TelaContatos extends StatelessWidget {
  const TelaContatos({super.key});

  @override
  Widget build(BuildContext context) {
    List<Contato> contatos = [Contato("davi", 1001), Contato("Felpe", 1002)];

    return ListView.builder(
      itemCount: contatos.length,
      itemBuilder: (BuildContext context, int index) {
        return ContatoTile(contatos.elementAt(index));
      },
    );
  }
}
