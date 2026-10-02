import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TEXTFIELD extends StatelessWidget {
  final String text;
  final String hint;
  final TextEditingController controller;
  const TEXTFIELD(this.text, this.hint, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey[400],
            ),
          ),
        ),
        SizedBox(height: 7),
        TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            focusColor: Colors.blueAccent,
            hintText: hint,
            hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.zero),
          ),
          controller: controller,
        ),
      ],
    );
  }
}
