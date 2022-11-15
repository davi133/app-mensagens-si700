import '../../model/contato.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'contact_state.dart';
import 'contact_event.dart';
import '../../Dados/contactList.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  List<Contato> currentList = [];

  ContactBloc(ContactState initialState) : super(initialState) {
    
    on<ContactFetchEvent>((event, emit) async {
      currentList = await ContactDataProvider.helper.getContacts();
      add(ContactUpdateList());
    });

    on<ContactUpdateList>(
      (event, emit) {
        if (currentList.isNotEmpty) {
          emit(ContactLoaded(currentList));
        } else {
          emit(ContactEmpty());
        }
      },
    );

    on<ContactAddEvent>(
      (event, emit) async {
        ContactDataProvider.helper.addContato(event.cont);
      },
    );

    on<ContactDeleteEvent>(
      (event, emit) async {
        ContactDataProvider.helper.removeContato(event.cont);
      },
    );

    on<ContactEditEvent>(
      (event, emit) async {
        ContactDataProvider.helper.editContato(event.cont);
      },
    );

    //listen for changes
    ContactDataProvider.helper.stream.listen((event) {
      String operation = event[0];
      int res = event[1];
      Contato target = event[2];
      bool shouldUpdateList = false;
      switch (operation) {
        case "c":
          if (res != 0) {
            //updating local list
            currentList.add(target);
            //update view later
            shouldUpdateList = true;
          }
          break;
        case "u":
          if (res != 0) {
            //updating local list
            for (int i = 0; i < currentList.length; i++) {
              if (target.id == currentList[i].id) {
                currentList[i] = target;
                //updating view later
                shouldUpdateList = true;
                break;
              }
            }
          }

          break;
        case "d":
          if (res != 0) {
            //updating local list
            for (int i = 0; i < currentList.length; i++) {
              if (target.id == currentList[i].id) {
                currentList.removeAt(i);
                //updating view later
                shouldUpdateList = true;
                break;
              }
            }
          }
          break;
      }

      if (shouldUpdateList) {
        this.add(ContactUpdateList());
      }
    });
  }
}
