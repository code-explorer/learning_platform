import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const ListTile(
              title: Text('Add authentication'),
            ),
            NeumorphicButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/paths');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
