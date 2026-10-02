import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});
  static const route = 'editpage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        centerTitle: true,
        title: Text(
          'Edit Acount',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
