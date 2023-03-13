import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Bildirimler extends StatefulWidget {
  const Bildirimler({Key? key}) : super(key: key);

  @override
  _BildirimlerState createState() => _BildirimlerState();
}

class _BildirimlerState extends State<Bildirimler> {
  Widget notificationList() {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("conversation")
            .orderBy("time", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Notification(
                      date: snapshot.data!.docs[index].data()['date'],
                      time: snapshot.data!.docs[index].data()["time"],
                    );
                  });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
          backgroundColor: Colors.orange,
          title: const Text(
            "Bildirimler",
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: Colors.black,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Kapı Çalma Tarih ve Saatleri ",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),
                notificationList()
              ],
            ),
          ),
        ));
  }
}

class Notification extends StatelessWidget {
  String time, date;
  Notification({required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                date,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                time,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }
}
