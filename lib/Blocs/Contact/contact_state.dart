import '../../model/contato.dart';

abstract class ContactState{}

class ContactFetchING extends ContactState{}

class ContactLoaded extends ContactState{

  List<Contato> lista_de_contatos = [];
  ContactLoaded(this.lista_de_contatos);
}

class ContactEmpty extends ContactState
{
  ContactEmpty();
}