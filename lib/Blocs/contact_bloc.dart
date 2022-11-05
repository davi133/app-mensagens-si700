import 'package:flutter_bloc/flutter_bloc.dart';
import 'contact_state.dart';
import 'contact_event.dart';

class ContactBloc extends Bloc<ContactEvent,ContactState>
{
   ContactBloc(ContactState initialState) : super(initialState) 
   {
    
   }
}

