import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_task/bloc/auth_bloc/auth_bloc.dart';
import 'package:login_task/bloc/provider.dart';
import 'package:login_task/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'navigator_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
        onGenerateRoute: NavigatorRoutes.materialPageRoute,
      ),
    );
  }
}
