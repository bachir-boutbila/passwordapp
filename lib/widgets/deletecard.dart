import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:passwordapp/models/password_data.dart';

class DeleteCard extends StatefulWidget {
  const DeleteCard({super.key});
  @override
  State<DeleteCard> createState() => _DeleteCardState();
}

class _DeleteCardState extends State<DeleteCard> {
  final _mybox = Hive.box<PasswordData>("mybox");
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to delete the card?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Yesnobutton('no', Colors.lightBlue, () {
                  Navigator.pop(context, false);
                }),
                Yesnobutton('yes', Colors.red, (() {
                  Navigator.pop(context, true);
                })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Yesnobutton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback function;
  const Yesnobutton(this.text, this.color, this.function, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
