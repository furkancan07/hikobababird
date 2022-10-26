// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flapy_bird/home_page.dart';
import 'package:flutter/material.dart';

class Karekter extends StatefulWidget {
  // final String karekter1;

  const Karekter({
    super.key,
  });

  @override
  State<Karekter> createState() => _KarekterState();
}

class _KarekterState extends State<Karekter> {
  // Oyun sayfasına gidecek karekterimizi heroya atayacağız
  late String hero;
  // Youtube Abone Ol :)
  String url = "https://www.youtube.com/channel/UCtCNReVcK78NW7B7oL6bbkQ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: containerOlustur("1", Colors.red.shade400, "Hiko Baba")),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: containerOlustur("2", Colors.orange.shade300, "Furkan")),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: containerOlustur("3", Colors.blue.shade500, "Kuş")),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: containerOlustur("4", Colors.brown.shade400, "Şeyma")),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: containerOlustur("5", Colors.purple, "Betül")),
          ),
        ],
      ),
    );
  }

  containerOlustur(String kNumara, Color renk, String karekterAdi) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/hikobaba.png"), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(30),
          color: renk,
          border: Border.all(color: Colors.white, width: 0.7)),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
          onPressed: () {
            // Seçtiğimiz karekterin ıd sini  heroya atıyoruz
            setState(() {
              hero = kNumara;
            });
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                // anasayfa için karekteri atıyoruz
                return HomePage(karekter: hero);
              },
            ));
          },
          child: Text("Karekter: $karekterAdi")),
    );
  }
}
