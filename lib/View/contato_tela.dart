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
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx){
                        return NewContactScreen();
                      })
                    );
                  },
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


class NewContactScreen extends StatelessWidget {
  NewContactScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Contato aux = Contato("", 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("novo contato")),
      body: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 80,minWidth: 300,maxWidth: 500),
                child:
                  SizedBox(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Apelido',
                      ),
                      validator: (String? inValue) {
                        if (inValue != null) {
                          if (inValue.isEmpty) {
                            return "Insira um apelido";
                          }
                        }
                        return null;
                      },
                      onSaved: (String? inValue) {
                        aux.apelido = inValue ?? "";
                      },
                    ),
                  ),
                
              ),
               ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 85,minWidth: 300,maxWidth: 500),
                child:
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Número',
                    ),
                    validator: (String? inValue) {
                      if (inValue != null) {
                        if (inValue.isEmpty) {
                          return "Insira um número de contato";
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(inValue)) {
                          return "Insira Apenas números";
                        }
                      }
                      return null;
                    },
                    onSaved: (String? inValue) {
                      aux.numero = int.parse(inValue ?? "0");
                    },
                  ),
              ),
              ElevatedButton(
                child: const Text("Salvar"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print(aux);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
