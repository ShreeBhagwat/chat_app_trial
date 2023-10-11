import 'dart:developer';

import 'package:chat_app_main/model/user_data.dart';
import 'package:chat_app_main/repository/auth/auth_repository.dart';
import 'package:chat_app_main/ui/auth/login_screen.dart';
import 'package:chat_app_main/ui/auth/widgets/custom_button.dart';
import 'package:chat_app_main/ui/auth/widgets/custom_text_form_field.dart';
import 'package:chat_app_main/ui/auth/widgets/text_button.dart';
import 'package:chat_app_main/ui/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthRepository _authRepository = AuthRepository();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              'Create a New Account!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name cannot be empty';
                    }
                    return null;
                  },
                  hintText: 'Name',
                  showSuffixIcon: false,
                  prefixIcon: Icons.person,
                  isPassword: false),
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
                title: 'Sign Up',
                onButtonPressed: () async {
                  await createUser(context);
                },
              ),
            ),
            CustomTextButton(
              title: 'Have an account? Login In!',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createUser(BuildContext context) async {
    _authRepository
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      if (value != null) {
        if (value.user != null) {
          final uid = value.user!.uid;
          addToDatabase(uid, context);
        } else {
          log('User creation failed');
        }
      } else {
        log('User creation failed');
      }
    });
  }

  Future<void> addToDatabase(String uid, BuildContext context) async {
    final userData = UserData(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        uid: uid,
        timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
        profilePictureUrl: '',
        phoneNumber: '',
        isOnline: true,
        bio: 'bio');
    await _authRepository
        .addUserToFirestoreDatabase(userData: userData)
        .then((value) {
      if (value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const ChatScreen()),
            (route) => false);
      } else {
        log('User creation failed');
      }
    });
  }
}
