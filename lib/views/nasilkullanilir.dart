import 'package:flutter/material.dart';

class NasilKullanilir extends StatefulWidget {
  const NasilKullanilir({Key? key}) : super(key: key);

  @override
  _NasilKullanilirState createState() => _NasilKullanilirState();
}

class _NasilKullanilirState extends State<NasilKullanilir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }),
        title: const Text(
          "Nasıl Kullanılır",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Container(
        child: Image.asset(
          "assets/samplee.jpg",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
