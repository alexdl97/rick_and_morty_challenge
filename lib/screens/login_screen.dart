import 'package:flutter/material.dart';
import 'package:rick_and_morty_challenge/routes/routes_app.dart';
import 'package:rick_and_morty_challenge/utils/auth.dart';

final regExpEmail = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

const userEmail = 'test@gmail.com';
const userPassword = '123123';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background_login.jpeg'),
              fit: BoxFit.cover),
          //color: Theme.of(context).primaryColor
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(16),
            height: _size.height * 0.4,
            width: _size.width * 0.8,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Expanded(
                  //   child: Text(
                  //     'Ryck and Morty',
                  //     style: TextStyle(
                  //       fontSize: 36,
                  //       fontWeight: FontWeight.w700,
                  //       color: Colors.white
                  //     ),
                  //   ),
                  // ),
                  TextFormField(
                    controller: _emailController,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }

                      return regExpEmail.hasMatch(value)
                          ? null
                          : 'Please enter a valid email';
                    }),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                      ),
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        // color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    }),
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: Theme.of(context).primaryColor,
                      ),
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        fontSize: 22,
                      ), //styl
                      //border:
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: _size.width * 0.6,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: _login,
                      child: const Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (_emailController.text == userEmail &&
          _passwordController.text == userPassword) {
        Auth.saveSession();
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesApp.homeScreen,
          (_) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: const Text(
                'Incorect Password',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor),
        );
      }
    }
  }
}
