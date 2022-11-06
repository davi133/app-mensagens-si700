import 'package:flutter_atividade2/model/contato.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'contact_state.dart';
import 'contact_event.dart';
import '../Dados/contactList.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  List<Contato> currentList = [];

  ContactBloc(ContactState initialState) : super(initialState) {
    on<ContactFetchEvent>((event, emit) async {
      currentList = await ContactDataProvider.helper.getContacts();
      if (currentList.isNotEmpty) {
        emit(ContactLoaded(currentList));
      } else {
        emit(ContactEmpty());
      }
    });

    on<ContactAddEvent>(
      (event, emit) async {
        int res = await ContactDataProvider.helper.addContato(event.cont);

        if (res != 0) {
          //updating local lisy
          currentList.add(event.cont);
          //updating view
          if (currentList.isNotEmpty) {
            emit(ContactLoaded(currentList));
          } else {
            emit(ContactEmpty());
          }
        }
      },
    );

    on<ContactDeleteEvent>(
      (event, emit) async {
        int res = await ContactDataProvider.helper.removeContato(event.cont);
        if (res !=0) {
          //updating local list
          for (int i = 0; i < currentList.length; i++) {
            if (event.cont.numero == currentList[i].numero) {
              currentList.removeAt(i);
              //updating view
              if (currentList.isNotEmpty) {
                emit(ContactLoaded(currentList));
              } else {
                emit(ContactEmpty());
              }
              return;
            }
          }
        }
      },
    );

    on<ContactEditEvent>(
      (event, emit) async {
        int res = await ContactDataProvider.helper.editContato(event.cont);
        if (res !=0) {
          //updating local list
          for (int i = 0; i < currentList.length; i++) {

            if (event.cont.id == currentList[i].id) {
              currentList[i] = event.cont;

              //updating view
              if (currentList.isNotEmpty) {
              
             
                emit(ContactLoaded(currentList));
              } else {
                emit(ContactEmpty());
              }
              return;
            }
          }
        }
      },
    );
  }
}
