import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Center(
          child: Text(
            'You have successfully Logined',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
