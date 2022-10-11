import 'dart:html';

import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/contato.dart';

class ContatoTile extends StatelessWidget {
  const ContatoTile(this.cont, {super.key});
  final Contato cont;

  @override
  Widget build(BuildContext context) {
    //return Text(user.toString());

    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (_) {
              return ContactOptions();
            });
      },
      child: ListTile(
        title: Text(cont.apelido),
        subtitle: Text("#${cont.numero}"),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.chat),
          color: Colors.blue,
        ),
      ),
    );
  }
}

class ContactOptions extends StatelessWidget {
  const ContactOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.edit,color: Colors.blue,),
          title: const Text("Editar"),
          onTap: (){},
        ),
        ListTile(
          leading: const Icon(Icons.delete,color: Colors.red,),
          title: const Text("Excluir"),
          onTap: (){},
        )
      ],
    );
  }
}
