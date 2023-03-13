import 'package:flutter/material.dart';
import 'package:isitme_engelliler/views/sign_in.dart';
import 'package:isitme_engelliler/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String stundentnumber;
  late String nameandsurname, password, phonenumber;
  late String email;
  late String classvalue = "Türkçe";

  List<String> classlist = ["Türkçe", "English", "русский", "Deutsch"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignIn()));
            },
          );
        }),
        backgroundColor: Colors.orange,
        title: const Text(
          "İşitme Engelliler",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: const [
                    Padding(padding: EdgeInsets.all(2)),
                    Text(
                      "Ad - Soyad",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty
                        ? "Adınızı ve Soyadınızı Giriniz"
                        : null;
                  },
                  onChanged: (val) {
                    nameandsurname = val;
                  },
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Adınızı ve Soyadınızı Giriniz",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Padding(padding: EdgeInsets.all(2)),
                    Text(
                      "Telefon Numarası",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Telefon Numaranızı Giriniz" : null;
                  },
                  onChanged: (value) {
                    stundentnumber = value;
                  },
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Telefon Numarasınızı Giriniz",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Padding(padding: EdgeInsets.all(2)),
                    Text(
                      "E-posta",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "E-postanızı Giriniz" : null;
                  },
                  onChanged: (value) {
                    stundentnumber = value;
                  },
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "E-postanızı Giriniz",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Padding(padding: EdgeInsets.all(2)),
                    Text(
                      "Şifre",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Şifrenizi Giriniz" : null;
                  },
                  onChanged: (value) {
                    stundentnumber = value;
                  },
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Şifrenizi Giriniz",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Padding(padding: EdgeInsets.all(2)),
                    Text(
                      "Dil",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    decoration: const InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    value: classvalue,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                      size: 30,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        classvalue = value!;
                      });
                    },
                    items: classlist.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList()),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                  },
                  child: button(context: context, label: "Kayıt Ol"),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
