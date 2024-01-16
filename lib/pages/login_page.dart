import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // email and pw text controllers
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();

  // tap  to go to register page
  final void Function()? ontap;

  LoginPage({super.key, required this.ontap});

  // login method
  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailPassword(_emailcontroller.text, _pwcontroller.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
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
            "Bem-Vindo de volta!",
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
          const SizedBox(height: 25),

          // login button
          MyButton(
            text: "Login",
            ontap: () => login(context),
          ),
          const SizedBox(height: 25),

          // register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Não tem login? ', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              GestureDetector(
                  onTap: ontap,
                  child: Text(' Registre-se',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ))),
            ],
          )
        ],
      ),
    );
  }
}
