import '../Dados/contactList.dart';

class Contato {
  int id =0;//id in the local database
  String apelido = "";
  int numero = 0;//id of the other user

  Contato(this.apelido, this.numero,{this.id=-1});

  Contato.fromMap(map) {
    apelido = map[ContactDataProvider.apelido];
    numero = map[ContactDataProvider.numero];
    id = map[ContactDataProvider.chave];
  }

  @override
  String toString() {
    return "Contato [$apelido,$numero]";
  }

  Contato copy() {
    return Contato(apelido, numero);
  }

  toMap({bool withId=true})
  {
    var map = <String, dynamic>{};
    if (id !=-1) map[ContactDataProvider.chave] = id;
    map[ContactDataProvider.apelido] = apelido;
    map[ContactDataProvider.numero] = numero;
    return map;
  }

  
}
