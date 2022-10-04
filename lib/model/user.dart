import 'contato.dart';

class User {
  String nome = "";
  int numero = 0;
  List<Contato> contatos = [];


  User( this.nome, this.numero);

  @override
  String toString()
  {
    return "$nome[#$numero]";
  }




}
