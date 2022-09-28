import 'package:flutter/material.dart';

class Grupo1 extends StatelessWidget {
  const Grupo1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                "data:image/jpeg;base64,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",
                width: 200,
                height: 200,
              ),
              const Text("Davi Pereira\nBergamin",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 35)),
              const Text(
                  "Aluno de análise e desenvolvimento\nde sistemas na Unicamp",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20))
            ],
          ),
        ),
      ),
    );
  }
}

Widget presentationCard(
    {String imageLink = "", String nome = "nome", String desc = ""}) {
  return Center(
    child: SizedBox.expand(
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              imageLink,
              width: 200,
              height: 200,
            ),
            Text(
              nome,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35),
            ),
            Text(desc,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20))
          ],
        ),
      ),
    ),
  );
}

