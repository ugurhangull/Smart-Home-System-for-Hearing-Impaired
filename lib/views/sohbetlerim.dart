import 'package:flutter/material.dart';
import 'package:isitme_engelliler/services/database.dart';
import 'package:isitme_engelliler/views/detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Sohbetlerim extends StatefulWidget {
  const Sohbetlerim({Key? key}) : super(key: key);

  @override
  _SohbetlerimState createState() => _SohbetlerimState();
}

class _SohbetlerimState extends State<Sohbetlerim> {
  DatabaseService databaseService = new DatabaseService(uid: '');
  late Stream chatStream;
  Widget chatList() {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("conversation")
            .orderBy("order", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data == null
              ? const LoadingIndicator(
                  indicatorType: Indicator.ballPulse,
                  colors: [Colors.black, Colors.white],
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Chats(
                      name: snapshot.data!.docs[index].data()['name'],
                      date: snapshot.data!.docs[index].data()['date'],
                      id: snapshot.data!.docs[index].data()["id"],
                      time: snapshot.data!.docs[index].data()["time"],
                    );
                  });
        },
      ),
    );
  }

  @override
  void initState() {
    databaseService.getChatsdata().then((val) {
      chatStream = val;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text(
          "Sohbetlerim",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,
      body: chatList(),
    );
  }
}

class Chats extends StatefulWidget {
  final String name, time, date;
  final String id;

  Chats(
      {required this.name,
      required this.time,
      required this.id,
      required this.date});

  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Detail(widget.id, widget.name)));
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.orange,
                  child: Text(
                    widget.name[0].toUpperCase(),
                    style: const TextStyle(color: Colors.black, fontSize: 26),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.name,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    Text(
                      widget.date,
                      style: const TextStyle(color: Colors.black),
                    ),
                    Text(
                      widget.time,
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }
}
