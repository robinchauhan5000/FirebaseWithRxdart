import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_task/bloc/auth_bloc/auth_bloc.dart';
import 'package:login_task/bloc/provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var _width;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    final bloc = Provider.of<AuthProvider>(context).bloc;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade400,
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.focusedChild.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      Text(
                        'Register here',
                        style: TextStyle(fontSize: 50.0, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      emailField(bloc),
                      SizedBox(
                        height: 30.0,
                      ),
                      passwordField(bloc),
                      SizedBox(
                        height: 30.0,
                      ),
                      signUpButton(bloc),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'you have an account',
                            style: TextStyle(fontSize: 15),
                          ),
                          registerTextButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailField(AuthBloc authBloc) {
    return StreamBuilder<String>(
        stream: authBloc.email,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: _width * 0.08),
            child: TextField(
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Colors.white54,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
              decoration: new InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 20, top: 20, right: 15),
                hintText: "name@example.com",
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white54,
                  fontWeight: FontWeight.w600,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                authBloc.settingEmail(value);
              },
            ),
          );
        });
  }

  Widget passwordField(AuthBloc authBloc) {
    return StreamBuilder<String>(
        stream: authBloc.password,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: _width * 0.08),
            child: TextFormField(
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 20.0,
                color: Colors.white54,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
              decoration: new InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                errorText: snapshot.error,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 20, top: 20, right: 15),
                hintText: "Password",
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white54,
                  fontWeight: FontWeight.w600,
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onChanged: authBloc.settingPassword,
            ),
          );
        });
  }

  Widget signUpButton(AuthBloc authBloc) {
    return StreamBuilder<String>(builder: (context, snapshot) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue.shade400,
          padding:
              EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
          textStyle: GoogleFonts.roboto(
            fontSize: 20.0,
            color: Colors.white54,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
          ),
        ),
        onPressed: () async {
          await authBloc.signupEmail();
          Navigator.pushReplacementNamed(context, "/signin");
        },
        child: Text('Sign up'),
      );
    });
  }

  Widget registerTextButton() {
    return TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/signin");
        },
        child: Text(
          'Login here',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white),
        ));
  }
}
