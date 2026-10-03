import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passwordapp/models/password_data.dart';
import 'package:hive/hive.dart';
import 'package:passwordapp/pages/acountspage.dart';
import 'dart:math';

import 'package:passwordapp/widgets/text_field.dart';

List<String> charachtersList = [
  // lowercase
  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
  'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
  // uppercase
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
  // digits
  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
  // symbols
  '!', '@', '#', '\$', '%', '^', '&', '*', '(', ')', '_', '+', '-', '=',
];
String generatepassword() {
  final Random r = Random.secure();
  String pwd = '';
  for (int i = 0; i < 20; i++) {
    pwd += charachtersList[r.nextInt(charachtersList.length)];
  }
  return pwd;
}

class AcountManagement extends StatefulWidget {
  final AcountManagementMode mode;
  final String? platform;
  final String? email;
  final String? password;
  final dynamic hiveKey;

  const AcountManagement.add({super.key})
    : mode = AcountManagementMode.add,
      platform = null,
      email = null,
      password = null,
      hiveKey = null;

  const AcountManagement.edit({
    super.key,
    required this.platform,
    required this.email,
    required this.password,
    required this.hiveKey,
  }) : mode = AcountManagementMode.edit;

  static const route = 'add_acount';

  @override
  State<AcountManagement> createState() => _AcountManagementState();
}

class _AcountManagementState extends State<AcountManagement> {
  final acontController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _mybox = Hive.box<PasswordData>("Mybox");

  @override
  void initState() {
    super.initState();

    if (widget.mode == AcountManagementMode.edit) {
      // put your existing values here
      acontController.text = '${widget.platform}';
      emailController.text = '${widget.email}';
      passwordController.text = '${widget.password}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdd = widget.mode == AcountManagementMode.add;
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        centerTitle: true,
        title: Text(
          isAdd ? 'Add Acount' : 'Edit Acount',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  isAdd ? 'Add Acount' : 'Edit Acount',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TEXTFIELD('Platform', 'Platform', acontController),
              SizedBox(height: 20),
              TEXTFIELD('Email', 'Email', emailController),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TEXTFIELD(
                      'Password',
                      'Password',
                      passwordController,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      final pwd = generatepassword();
                      passwordController.text = pwd;
                    },
                    icon: Icon(Icons.password, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 190),
              MaterialButton(
                onPressed: () async {
                  if (isAdd) {
                    await _mybox.add(
                      PasswordData(
                        acontController.text,
                        emailController.text,
                        passwordController.text,
                      ),
                    );
                  } else {
                    final account = _mybox.get(widget.hiveKey);
                    if (account != null) {
                      account.platform = acontController.text;
                      account.email = emailController.text;
                      account.password = passwordController.text;
                      await _mybox.put(widget.hiveKey, account);
                    }
                  }
                  Navigator.pop(context, true);
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black54,
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      isAdd ? 'Save Acount' : 'Save Edit',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    acontController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
