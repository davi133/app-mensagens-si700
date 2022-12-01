import 'package:UnitalkV0_2/Dados/chat_provider.dart';

import 'chat_list_event.dart';
import 'chat_list_state.dart';
import 'package:bloc/bloc.dart';

class ChatListBloc extends Bloc<ChatListEvent,ChatListState>
{
  ChatListBloc(ChatListState initialstate) : super(initialstate){
      on<ChatListFetchEvent>((event, emit) async {
        print("fetching chat list");
        String res = await ChatProvider.helper.fetchChats();
        if (res == "")
        { 
          
          emit(ChatListLoadedState(ChatProvider.helper.Conversas));
        }
        else
        {
          emit(ChatListErrorState(res));
        }

      },);

      on<ChatListAddEvent>((event, emit) {
        
      },);
  }
  
}
