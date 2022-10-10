import 'package:flutter/material.dart';
import '../model/contato.dart';
import 'contato_tile.dart';

class TelaContatos extends StatelessWidget {
  const TelaContatos({super.key});

  @override
  Widget build(BuildContext context) {
    List<Contato> contatos = [Contato("davi", 1001), Contato("Felpe", 1002)];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: contatos.length,
              itemBuilder: (BuildContext context, int index) {
                return ContatoTile(contatos.elementAt(index));
              },
            ),
          ),
          SizedBox(///FROM HERE AND BELOW IS FOR THE FLOATING BUTTON
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {},
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
