import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isitme_engelliler/services/database.dart';
import 'package:isitme_engelliler/views/drawermenu.dart';
import 'package:isitme_engelliler/views/iletisim.dart';
import 'package:random_string/random_string.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:google_speech/google_speech.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<int> voicelist = [];

  TextEditingController message = TextEditingController();
  TextEditingController name = TextEditingController();
  DatabaseService databaseService = DatabaseService(uid: '');
  DateTime currenttime = DateTime.now();
  var mydateFormat = DateFormat('dd.MM.yyyy');
  var mytimeFormat = DateFormat('hh:mm');
  bool kayit = true;
  bool zil = false;

  bool istranscribing = false;
  String door_message = "";
  IOWebSocketChannel channel =
      IOWebSocketChannel.connect('ws://192.168.244.200/ws');
  late String conversationId;
  late bool ready;
  late bool done;
  void transcribe() async {
    setState(() {
      door_message = "";
      istranscribing = true;
    });
    final serviceAccount = ServiceAccount.fromString(
        '${(await rootBundle.loadString('assets/isitmeengelliler-344807-8cf87108e6d4.json'))}');
    final speechToText = SpeechToText.viaServiceAccount(serviceAccount);

    final config = RecognitionConfig(
        encoding: AudioEncoding.LINEAR16,
        languageCode: 'tr-TR',
        audioChannelCount: 1,
        model: RecognitionModel.basic,
        enableAutomaticPunctuation: true,
        sampleRateHertz: 16000);
    final audio = voicelist;
    await speechToText.recognize(config, audio).then((value) {
      setState(() {
        door_message = value.results
            .map((e) => e.alternatives.first.transcript)
            .join('\n');
      });
    }).whenComplete(() {
      setState(() {
        voicelist.clear();
        istranscribing = false;
        done = false;
      });
    });
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.orange,
            title: const Text("Konuştuğunuz Kişi Kim ?"),
            content: TextField(
              controller: name,
              decoration: const InputDecoration(
                  hintText: "Konuştuğunuz Kişinin İsmini Giriniz",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    updateName();
                    channel.sink.add("Bitti");
                  },
                  child: const Text("Görüşmeyi Bitir",
                      style: TextStyle(color: Colors.black)))
            ],
          ));

  Future notificationalert() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.orange,
            title: const Text("Zil Çalıyor"),
            actions: [
              TextButton(
                  onPressed: () {
                    channel.sink.add("Konusma Basladi");
                    zil = false;
                    Navigator.pop(context, false);
                  },
                  child: const Text("Görüşmeyi Başlat",
                      style: TextStyle(color: Colors.white)))
            ],
          ));

  conversationsData() {
    setState(() {
      conversationId = randomAlphaNumeric(8);
    });
    Map<String, String> conversationData = {
      "date": mydateFormat.format(currenttime).toString(),
      "name": "İsimsiz- ${mydateFormat.format(currenttime).toString()}",
      "id": conversationId,
      "time": mytimeFormat.format(currenttime).toString()
    };
    databaseService
        .addConversationData(conversationData, conversationId)
        .then((value) {});
    setState(() {
      kayit = false;
    });
  }

  Future messages(String text) async {
    Map<String, String> messagesData = {
      "app_user": message.text,
      "door_user": door_message,
      "time": currenttime.toString()
    };
    /*if (door_message == "") {
      var collection = FirebaseFirestore.instance.collection('conversation');
      var snapshot = await collection.where('door_user', isEqualTo: "").get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }*/
    door_message = "";
    channel.sink.add(text);
    databaseService.addMessagesData(messagesData, conversationId).then((value) {
      print("Mesajlar Gönderildi");
    });
    _sendMessage();
    message.clear();
  }

  updateName() {
    FirebaseFirestore.instance
        .collection("conversation")
        .doc(conversationId)
        .update({"name": name.text});
    Navigator.of(context).pop();
    message.clear();
    kayit = true;
  }

  listener() {
    try {
      channel.stream.listen(
        (event) {
          print(event);
          setState(() {
            if (event == "zil") {
              setState(() {
                zil = true;
                if (zil) {
                  notificationalert();
                }
              });
            }
            if (event == "donestream") {
              setState(() {
                done = true;
              });
            } else {
              voicelist.addAll(event);
            }
          });

          callfunctions();
        },
      );
    } catch (_) {
      print("error on connecting to websocket.");
    }
  }

  callfunctions() {
    try {
      if (zil == true) {
        notificationalert();
      }
      if (kayit == true) {
        conversationsData();
      }
      if (done == true) {
        transcribe();
      }
    } catch (_) {}
  }

  void _sendMessage() {
    if (message.text.isNotEmpty) {
      channel.sink.add(message.text);
    }
  }

  void setpermission() async {
    await Permission.manageExternalStorage;
    await Permission.storage.request();
  }

  void initState() {
    Future.delayed(Duration.zero, () {
      setpermission();
      listener();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerMenu(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 3,
        backgroundColor: Colors.orange,
        title: const Text(
          "İşitme Engelliler Projesi",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  " Gelen Mesaj ",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      backgroundColor: Colors.white),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: istranscribing
                      ? const LoadingIndicator(
                          indicatorType: Indicator.ballBeat,
                          colors: [Colors.black, Colors.orange],
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Text(
                            door_message,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        )),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.black,
                thickness: 2,
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: message,
                validator: (val) {
                  return val!.isEmpty
                      ? "Lütfen bir mesaj giriniz Giriniz"
                      : null;
                },
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Mesajınızı Giriniz",
                    hintStyle: TextStyle(color: Colors.orange)),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      FloatingActionButton(
                          heroTag: "button1",
                          child: const Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.orange,
                          onPressed: () => messages(message.text)),
                      const Text(
                        "Gönder",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      FloatingActionButton(
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.orange,
                          onPressed: () {
                            openDialog();
                          }),
                      const Text(
                        "Görüşmeyi Bitir",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 220,
              ),
              Row(
                children: [
                  const Padding(
                    padding: const EdgeInsets.only(left: 10),
                  ),
                  FloatingActionButton(
                    heroTag: "button2",
                    backgroundColor: Colors.orange,
                    child: const Icon(
                      Icons.support_agent,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Iletisim()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    message.dispose();
    super.dispose();
  }
}
