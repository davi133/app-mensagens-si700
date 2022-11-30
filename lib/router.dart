import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main.dart';

import 'Blocs/Authentication/auth_bloc.dart';
import 'Blocs/Authentication/auth_state.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    

    switch (routeSettings.name) {
      case "/":
        print("routing /");
        return MaterialPageRoute(builder: (_) => const Wrapper());

      case "/login":
        return MaterialPageRoute(builder: (_) => const Text("a"));

      case "/register":
        return MaterialPageRoute(builder: (_) => const Text("a"));

      case "/home":
        return MaterialPageRoute(builder: (_) => const Text("a"));

      case "/home/chats":
        return MaterialPageRoute(builder: (_) => const Text("a"));

      case "/home/chatswith":
        return MaterialPageRoute(builder: (_) => const Text("a"));

      case "/home/contacts":
        return MaterialPageRoute(builder: (_) => const Text("a"));

      default:
        return MaterialPageRoute(builder: (_) => const Text("a"));
    }
  }

  void dispose() {}
}
