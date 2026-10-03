import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:passwordapp/models/password_data.dart';
import 'package:passwordapp/pages/acount_management.dart';
import '../widgets/passwordcard.dart';
import 'package:hive/hive.dart';

class Acountspage extends StatefulWidget {
  const Acountspage({super.key});
  static const route = '/';

  @override
  State<Acountspage> createState() => _AcountspageState();
}

class _AcountspageState extends State<Acountspage> {
  final _mybox = Hive.box<PasswordData>("Mybox");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          'Welcom',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: passwordDataList.length,
              itemBuilder: (context, index) {
                return Passwordcard(
                  passwordDataList[index].platform,
                  passwordDataList[index].email,
                  passwordDataList[index].password,
                  onDelete: () {
                    setState(() {
                      _mybox.delete(_mybox.keyAt(index));
                      passwordDataList = _mybox.values.toList();
                    });
                  },
                  onChange: () {},
                );
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: FloatingActionButton(
                onPressed: () async {
                  final added = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AcountManagement.add(),
                    ),
                  );
                  if (!mounted) return;
                  if (added == true) {
                    setState(() {
                      passwordDataList = _mybox.values.toList();
                    });
                  }
                },
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
