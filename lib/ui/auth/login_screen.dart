import 'dart:developer';
import 'package:chat_app_main/repository/auth/auth_repository.dart';
import 'package:chat_app_main/ui/auth/signup_screen.dart';
import 'package:chat_app_main/ui/auth/widgets/custom_button.dart';
import 'package:chat_app_main/ui/auth/widgets/custom_text_form_field.dart';
import 'package:chat_app_main/ui/auth/widgets/text_button.dart';
import 'package:chat_app_main/ui/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  AuthRepository _authRepository = AuthRepository();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                ),
                child: const Center(
                  child: Icon(
                    Icons.message,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      return null;
                    },
                    hintText: 'Email',
                    showSuffixIcon: false,
                    prefixIcon: Icons.email,
                    isPassword: false),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                  hintText: 'Password',
                  showSuffixIcon: true,
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  sufixIcon: Icons.visibility_off,
                  suffixIconPressed: () {
                    log('Show password pressed');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  title: 'Login',
                  onButtonPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await loginUser(context);
                    }
                  },
                ),
              ),
              CustomTextButton(
                title: 'Do not have an account? Sign Up!',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SignUpScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future loginUser(BuildContext context) async {
    _authRepository
        .loginWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      if (value != null) {
        if (value.user != null) {
          // Naivgate to chat screen
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (_) => const ChatScreen(),
          // ));

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const ChatScreen()),
              (route) => false);
        } else {
          // Failed to login user
        }
      } else {
        // Failed to login user
      }
    });
  }
}
