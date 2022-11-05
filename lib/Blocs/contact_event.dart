import '../model/contato.dart';
abstract class ContactEvent{}

class ContactFetchEvent extends ContactEvent{}

class ContactAddEvent extends ContactEvent{
  Contato cont;
  ContactAddEvent(this.cont);

}