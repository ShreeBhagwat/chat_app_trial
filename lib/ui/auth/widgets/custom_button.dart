import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onButtonPressed,
    this.width = double.infinity,
    this.height = 50,
    required this.title,
    this.backgroundColor = Colors.amber,
    this.textColor = Colors.black,
  });
  final Function()? onButtonPressed;
  final double? width;
  final double? height;
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:  MaterialStatePropertyAll(backgroundColor),
          foregroundColor:  MaterialStatePropertyAll(textColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onButtonPressed,
        child:  Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
