import 'package:flutter/material.dart';
import './Apresentacao1.dart';
import "model/contato.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(text: "Integrante 1"),
              Tab(text: "Integrante 2"),
              Tab(text: "subsistema")
            ]),
            title: const Text("Atividade 2"),
          ),
          body: TabBarView(children: [
            presentationCard(imageLink: "https://media-exp1.licdn.com/dms/image/C4D03AQFh7uSwig7Waw/profile-displayphoto-shrink_200_200/0/1662439561558?e=1668643200&v=beta&t=5paimSdr8OIVXv0ytCdcgHrFyuTb7G_vWc8BY_2YYOo",
            nome: "Davi Pereira\nBergamin",
            desc:"Aluno de análise e desenvolvimento\nde sistemas na Unicamp"),
            presentationCard(imageLink: "https://seeklogo.com/images/A/android-messages-logo-020799A598-seeklogo.com.png",
            nome:"Felipe Araujo\nSantos Pinto",
            desc:"Aluno de análise e desenvolvimento\nde sistemas na Unicamp"),
            NewContactScreen(),
          ]),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            validator: (String? inValue) {
              if (inValue != null) {
                if (inValue.isEmpty) {
                  return "Insira um nome de usuário";
                }
              }
              return null;
            },
            onSaved: (String? inValue) {
              print(inValue);
            },
          ),
          ElevatedButton(
            child: const Text("Log In!"),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
            },
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
