import 'package:flutter/material.dart';

class Destek extends StatefulWidget {
  const Destek({Key? key}) : super(key: key);

  @override
  _DestekState createState() => _DestekState();
}

class _DestekState extends State<Destek> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Destek",
          style: const TextStyle(color: Colors.orange),
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1)),
                  hintText: "Ad-Soyad",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                return value!.isEmpty ? "E-postanızı Giriniz" : null;
              },
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1)),
                  hintText: "E-posta",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1)),
                  hintText: "Hata",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            const Spacer(),
            const Padding(padding: const EdgeInsets.all(40)),
            FloatingActionButton(
                backgroundColor: Colors.orange,
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
        ),
      ),
    );
  }
}
