import 'package:flutter/material.dart';
import 'package:isitme_engelliler/views/ayarlar.dart';
import 'package:isitme_engelliler/views/bildirimler.dart';
import 'package:isitme_engelliler/views/iletisim.dart';
import 'package:isitme_engelliler/views/nasilkullanilir.dart';
import 'package:isitme_engelliler/views/sohbetlerim.dart';
import 'package:isitme_engelliler/widgets/widgets.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (contex) => const Sohbetlerim()));
        break;
      case 1:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NasilKullanilir()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Ayarlar()));
        break;
      case 3:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Bildirimler()));
        break;
      case 4:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Iletisim()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            buildHeader(name: "Mustafa Tunç", eposta: "tncmmustafa@gmail.com"),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            buildMenuItem(
                text: "Sohbetlerim",
                icon: Icons.bar_chart_outlined,
                onClicked: () => selectedItem(context, 0)),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.white,
            ),
            buildMenuItem(
                text: "Nasıl Kullanılır",
                icon: Icons.menu_book,
                onClicked: () => selectedItem(context, 1)),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.white,
            ),
            buildMenuItem(
                text: "Ayarlar",
                icon: Icons.settings,
                onClicked: () => selectedItem(context, 2)),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.white,
            ),
            buildMenuItem(
              text: "Bildirimler",
              icon: Icons.notifications,
              onClicked: () => selectedItem(context, 3),
            ),
            const Divider(
              height: 1,
              color: Colors.white,
              thickness: 1,
            ),
            buildMenuItem(
                text: "Hata Bildir",
                icon: Icons.error_outline,
                onClicked: () => selectedItem(context, 4)),
            const Divider(
              height: 1,
              color: Colors.white,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
