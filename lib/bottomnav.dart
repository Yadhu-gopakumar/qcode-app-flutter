import 'package:flutter/material.dart';
import 'package:qcode/qr_generator.dart';
import 'package:qcode/qr_reader.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int _curentindex = 0;
  final _pages = const <Widget>[
    Qrgenerate(),
    Qrreader(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_rounded),
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Colors.grey[800],
        elevation: 3,
        centerTitle: true,
        title: const Text(
          'QCode',
          style: TextStyle(
            color: Colors.tealAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _pages[_curentindex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.black38),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            enableFeedback: false,
            selectedFontSize: 15,
            elevation: 0,
            selectedItemColor: Colors.tealAccent,
            currentIndex: _curentindex,
            backgroundColor: Colors.transparent,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code), label: 'Create QR Code'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code_scanner), label: 'Scan QR Code'),
            ],
            onTap: (value) {
              setState(() {
                _curentindex = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
