import 'package:UnitalkV0_2/Dados/chat_provider.dart';

import 'chat_list_event.dart';
import 'chat_list_state.dart';
import 'package:bloc/bloc.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc(ChatListState initialstate) : super(initialstate) {
    on<ChatListFetchEvent>(
      (event, emit) async {
        print("fetching chat list");
        String res = await ChatProvider.helper.fetchChats();
        emit(ChatListLoadedState(ChatProvider.helper.Conversas));
       /* if (res == "") {
          
        } else {
          emit(ChatListErrorState(res));
        }*/
        //print("chat fetchin done");
      },
    );

    on<ChatListRefreshEvent>(
      (event, emit) {
        print("evento de update chat list");
        emit(ChatListLoadedState(ChatProvider.helper.Conversas));
      },
    );

    on<ChatListAddEvent>(
      (event, emit) {},
    );

    ChatProvider.helper.stream.listen((event) {
      if (event[0] == "received" || event[0]=="newChat") {
        add(ChatListRefreshEvent());
      }
    });

  }

  
}
