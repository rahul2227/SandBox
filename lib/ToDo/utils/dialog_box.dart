import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;

  VoidCallback saveButtonPressed;
  VoidCallback cancelButtonPressed;
  DialogBox({
    Key? key,
    required this.controller,
    required this.saveButtonPressed,
    required this.cancelButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            // get user input
            TextField(
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            // buttons -> save + cancel
            Row(
              children: [
                DialogButton(
                  buttonName: "Save",
                  onPressed: saveButtonPressed,
                ),
                const Spacer(),
                DialogButton(
                  buttonName: "Cancel",
                  onPressed: cancelButtonPressed,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Row buttons of the dialog box
class DialogButton extends StatelessWidget {
  VoidCallback onPressed;
  final String buttonName;
  DialogButton({
    Key? key,
    required this.buttonName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
      ),
      child: Text(
        buttonName,
        style: const TextStyle(color: Colors.deepPurple),
      ),
    );
  }
}
