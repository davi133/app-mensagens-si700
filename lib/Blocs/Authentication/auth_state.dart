import '../../model/session_user.dart';

abstract class AuthState{}

class UnauthenticatedState extends AuthState
{

}

class AuthenticatedState extends AuthState
{
  SessionUser sessionUser;
  AuthenticatedState({required this.sessionUser});
}

class AuthErroState extends AuthState
{
  final String message;
  AuthErroState(this.message);
}