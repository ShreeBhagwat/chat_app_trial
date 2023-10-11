import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.showSuffixIcon,
    required this.prefixIcon,
    this.sufixIcon,
    required this.isPassword,
    this.validator,
    this.suffixIconPressed, 
    required this.controller,
  });

  final String hintText;
  final bool showSuffixIcon;
  final IconData prefixIcon;
  final IconData? sufixIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Function()? suffixIconPressed;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: showSuffixIcon
            ? IconButton(
                onPressed: suffixIconPressed,
                icon: Icon(
                  sufixIcon ?? Icons.visibility,
                  color: Colors.amber,
                ),
              )
            : const SizedBox.shrink(),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.amber,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.amber, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
