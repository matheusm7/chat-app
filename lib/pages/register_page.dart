import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  // email and pw text controllers
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  // tap to go to Login page
  final void Function()? ontap;

  RegisterPage({super.key, required this.ontap});

  // register method
  void register(BuildContext context) {
    // get auth service
    final auth = AuthService();

    if (_pwcontroller.text == _confirmPwController.text) {
      try {
        auth.signUpWithEmailPassword(
          _emailcontroller.text,
          _pwcontroller.text,
        );
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }
    // password dont match -> tell user to fix

    else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Password doesnt match"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 50),

          // welcome back message
          Text(
            "Vamos criar uma conta!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 25),

          // email textfield
          MyTextField(
            hintText: "Email",
            obscureText: false,
            controller: _emailcontroller,
          ),
          const SizedBox(height: 10),

          // pw textfield
          MyTextField(
            hintText: "Senha",
            obscureText: true,
            controller: _pwcontroller,
          ),
          const SizedBox(height: 10),

          // confirm pw password
          MyTextField(
            hintText: "Confirme sua senha",
            obscureText: true,
            controller: _confirmPwController,
          ),
          const SizedBox(height: 25),

          // login button
          MyButton(
            text: "Registrar",
            ontap: () => register(context),
          ),
          const SizedBox(height: 25),

          // register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Já possui uma conta? ', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              GestureDetector(onTap: ontap, child: Text('Fazer login.', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary))),
            ],
          )
        ],
      ),
    );
  }
}
