import 'contato.dart';

class User {
  String nome = "";
  int numero = 0;



  User( this.nome, this.numero);

  @override
  String toString()
  {
    return "$nome[#$numero]";
  }

  User copy()
  {
    return User(nome, numero);
  }



}
