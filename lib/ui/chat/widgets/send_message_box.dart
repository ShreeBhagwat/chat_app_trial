
import 'package:flutter/material.dart';

class SendMessageBox extends StatelessWidget {
  const SendMessageBox({
    super.key,
    required this.messageController,
    this.onPressed,
  });

  final TextEditingController messageController;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.blue,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 8, bottom: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.78,
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: 'Message ...',
                    hintStyle: const TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: onPressed, icon: const Icon(Icons.send)),
            )
          ],
        ),
      ),
    );
  }
}
