import 'package:flutter/material.dart';
import 'package:login_task/bloc/auth_bloc/auth_bloc.dart';

class AuthProvider extends ChangeNotifier {
  final _bloc = AuthBloc();

  get bloc => _bloc;
}
