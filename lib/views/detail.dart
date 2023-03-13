import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isitme_engelliler/services/database.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Detail extends StatefulWidget {
  final String id, name;
  Detail(this.id, this.name);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  DatabaseService databaseService = DatabaseService(uid: '');

  late Stream chatStream;

  Widget messagesList() {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("conversation")
            .doc(widget.id)
            .collection("messages")
            .orderBy("time", descending: false)
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
                    return Messages(
                      messages: snapshot.data!.docs[index].data()['messages'],
                      user: snapshot.data!.docs[index].data()["user"],
                    );
                  });
        },
      ),
    );
  }

  void initState() {
    Future.delayed(Duration.zero, () {
      databaseService.getMessagesData(widget.id).then((val) {
        chatStream = val;
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 3,
            titleSpacing: -5,
            backgroundColor: Colors.orange,
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
            title: Row(children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.black,
                child: Text(
                  widget.name[0],
                  style: const TextStyle(color: Colors.orange, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.name,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(
                height: 2,
              ),
            ])),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.jpeg"),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: messagesList(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )));
  }
}

class Messages extends StatefulWidget {
  final String messages;
  final String user;

  const Messages({required this.messages, required this.user});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: widget.user == "app"
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.user == "app" ? Colors.orange : Colors.green,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  widget.messages,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
