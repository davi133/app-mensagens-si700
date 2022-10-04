import 'package:flutter/material.dart';
import 'View/contato_tela.dart';
import "View/conversa_tela.dart";
import 'model/contato.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("WhatsApp 2"),
            bottom: const TabBar(tabs: [
              Tab(text: "Conversa"),
              Tab(text: "Contatos"),
              Tab(text: "depois eu excluo isso",)
            ]),
          ),
          body: TabBarView(children: [
            TelaConversas(),
            TelaContatos(),
            NewContactScreen(),
          ]),
        ),
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
    return Container(
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
    );
  }
}
