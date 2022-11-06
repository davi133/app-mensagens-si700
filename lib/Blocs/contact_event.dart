import '../model/contato.dart';
abstract class ContactEvent{}

class ContactFetchEvent extends ContactEvent{}

class ContactAddEvent extends ContactEvent{
  Contato cont;
  ContactAddEvent(this.cont);

}
class ContactEditEvent extends ContactEvent
{
  Contato cont;
  ContactEditEvent(this.cont);
}

class ContactDeleteEvent extends ContactEvent
{
  Contato cont;
  ContactDeleteEvent(this.cont);
}