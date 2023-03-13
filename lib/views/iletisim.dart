import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class Iletisim extends StatefulWidget {
  const Iletisim({Key? key}) : super(key: key);

  @override
  State<Iletisim> createState() => _IletisimState();
}

class _IletisimState extends State<Iletisim> {
  String number = "+905519473193";
  String message = "Merhaba, sorun yaşıyorum. Yardımcı olur musunuz?";
  String topic = "Hata";

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: number,
      text: message,
    );
    await launch('$link');
  }

  void send_email(message, topic) async {
    final Email email = Email(
      body: message,
      subject: topic,
      recipients: ["mustafatunc030600@gmail.com"],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  void _launchMail({@required topic, @required message}) async {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'mustafatunc030600@gmail.com',
        queryParameters: {'subject': '$topic', 'body': '$message'});
    await canLaunch(_emailLaunchUri.toString());
  }

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
          "İletişim",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Whatsapp İle İletişim İçin Tıklayınız",
              style: const TextStyle(
                  color: Colors.green, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            FloatingActionButton(
                heroTag: "1",
                backgroundColor: Colors.green,
                child: const Icon(
                  Icons.whatsapp,
                  color: Colors.white,
                ),
                onPressed: (() {
                  launchWhatsApp();
                })),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "E-posta İle İletişim İçin Tıklayınız",
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            FloatingActionButton(
                heroTag: "2",
                backgroundColor: Colors.orange,
                child: const Icon(
                  Icons.mail,
                  color: Colors.white,
                ),
                onPressed: (() {
                  send_email(message, topic);
                })),
          ],
        ),
      ),
    );
  }
}
