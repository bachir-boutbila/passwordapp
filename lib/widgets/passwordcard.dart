// removed unused import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:passwordapp/models/password_data.dart';
import 'package:passwordapp/pages/acount_management.dart';
import 'package:passwordapp/widgets/deleteCard.dart';

class Passwordcard extends StatefulWidget {
  final String platform;
  final String email;
  final String password;
  final VoidCallback onDelete;
  const Passwordcard(
    this.platform,
    this.email,
    this.password, {
    required this.onDelete,
    super.key,
  });

  @override
  State<Passwordcard> createState() => _PasswordcardState();
}

class _PasswordcardState extends State<Passwordcard> {
  //static const route = 'passwordCard';
  bool isHidden = true;
  IconData icon = Icons.visibility_off;
  final _mybox = Hive.box<PasswordData>("mybox");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20, top: 10),
      child: Container(
        height: 170,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white24, width: 5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.platform,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final shouldDelete = await showDialog<bool>(
                        context: context,
                        builder: (context) => const DeleteCard(),
                      );
                      if (shouldDelete == true) {
                        widget.onDelete();
                      }
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.redAccent,
                      size: 30,
                      weight: 200,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                widget.email,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      isHidden ? '........................' : widget.password,
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (isHidden == true) {
                        setState(() {
                          icon = Icons.visibility;
                          isHidden = false;
                        });
                      } else {
                        setState(() {
                          icon = Icons.visibility_off;
                          isHidden = true;
                        });
                      }
                    },
                    icon: Icon(icon, color: Colors.blueAccent),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.password));
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(Icons.copy, color: Colors.teal),
                  ),
                  IconButton(
                    onPressed: () async {
                      final edited = await Navigator.pushNamed(
                        context,
                        AcountManagement.route,
                        arguments: AcountManagementMode.edit,
                      );
                      if (edited == true) {
                        ///
                      }
                    },
                    icon: Icon(Icons.edit, color: Colors.white),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
