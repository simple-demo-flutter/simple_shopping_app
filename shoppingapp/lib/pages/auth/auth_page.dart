import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingsecond/providers/auth_provider.dart';

class AuthPage extends StatelessWidget {
  static const routeName = '/auth';
  AuthPage({Key? key}) : super(key: key);

  final TextEditingController _emailController  = TextEditingController();
  final TextEditingController _passwordController  = TextEditingController();



  @override
  Widget build(BuildContext context) {

    void handleSubmit(){
      final email = _emailController.text;
      final password = _passwordController.text;

      if( email.isNotEmpty && password.isNotEmpty){
        Provider.of<AuthProvider>(context , listen : false).login(email, password);
      }
      print(email);
      print(password);

    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller:  _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: handleSubmit,
                child: const Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
