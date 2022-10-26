// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:async';

import 'package:flapy_bird/bariyer.dart';
import 'package:flapy_bird/karekter.dart';
import 'package:flapy_bird/kus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // Karekter sınıfından karekterimizi seçeceğiz
  final String karekter;
  const HomePage({super.key, required this.karekter});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double kusY = 0;
  double a = 0;
  double b = 0;
  double kusPozisyon = kusY;
  double uzunluk = 0;
  double hiz = 2.7;
  double yerCekimi = -4.9;
  double zaman = 0;
  bool oyunBasladiMi = false;
  static double birinci = 1.8;
  double ikinci = birinci + 1.5;
  double _skor = 0;
  double _bestScore = 0;
  //-gt^2*1/2+vt
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.brown.shade500,
          title: Text("Game Over"),
          content: Text("ÖLDÜN YETİM"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
                onPressed: () {
                  setState(() {
                    reset();
                  });
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Karekter();
                    },
                  ));
                },
                child: Text("Karekter Seçimine Geri Dön")),
            TextButton(child: Text("Oyna"), onPressed: reset),
          ],
        );
      },
    );
  }

// Oyunun Algoritması
  void run() {
    oyunBasladiMi = true;
    Timer.periodic(
      Duration(milliseconds: 50),
      (timer) {
        setState(() {
          //KUŞUN HAVADA KALMA SÜRESİNİ ATIŞLAR FORMÜLÜ İLE SAĞLADIM
          uzunluk = (yerCekimi * zaman * zaman) + (hiz * zaman);
          kusY = kusPozisyon - uzunluk;
          zaman += 0.01;
          if (_skor % 10 == 0) {
            hiz += 0.001;
          }
        });
        // BARİYERLERİ SONSUZ DÖNGÜ İÇİNE KOYDUK
        setState(() {
          if (birinci < -2) {
            birinci += 4.5;
          } else {
            birinci -= 0.04;
          }
        });
        setState(() {
          if (ikinci < -2) {
            ikinci += 4.5;
          } else {
            ikinci -= 0.04;
          }
        });
        if (kusOldumu()) {
          timer.cancel();
          oyunBasladiMi = false;
          _showDialog();
        }
      },
    );
  }

  bool kusOldumu() {
    // KUSUN ÜST VE ALT KISIMLARA DEĞDİĞİNDE ÖLMESİNİ SAĞLAYAN ALGORİTMA
    if (kusY < -1 || kusY > 1) {
      return true;
    }
    // KUSUN BARİYERLERE ÇARPINCA ÖLMESİNİ SAĞLAYAN ALGORİTMA
    if (birinci < 0.2 && birinci > -0.2) {
      setState(() {
        _skor = _skor + 0.1;
        /*if (_skor % 10 == 0) {
          _skor = _skor / 10;
        }*/
      });

      if (kusY < -0.45 || kusY > 0.23) {
        return true;
      }
    }
    if (ikinci < 0.2 && ikinci > -0.2) {
      setState(() {
        _skor = _skor + 0.1;
      });

      if (kusY < -0.69 || kusY > -0.20) {
        return true;
      }
    }

    return false;

    /* if (kusY < -1 || kusY > 1) {
      return true;
    } else {
      return false;
    }*/
  }

  void jump() {
    setState(() {
      zaman = 0;

      kusPozisyon = kusY;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: oyunBasladiMi ? jump : run,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Stack(children: [
                      Center(child: Text(kusY.toStringAsFixed(1))),
                      //KAREKTERİ KUŞ SINIFINA GÖDERİYORUZ SON İŞLEMLER ORDA
                      Kus(kusKonum: kusY, kahraman: widget.karekter),
                      AnimatedContainer(
                        alignment: Alignment(birinci, 1.1),
                        duration: Duration(),
                        child: MyBarier(size: 200.0),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(birinci, -1.1),
                        duration: Duration(),
                        child: MyBarier(size: 150.0),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(ikinci, 1.1),
                        duration: Duration(),
                        child: MyBarier(size: 300.0),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(ikinci, -1.1),
                        duration: Duration(),
                        child: MyBarier(size: 100.0),
                      ),
                      Container(
                        alignment: Alignment(0, -0.5),
                        child: oyunBasladiMi
                            ? Text("")
                            : Text(
                                "BAŞLA",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ]),
                  ),
                )),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: containerOlustur(
                                Text("Skor: ${(_skor.toStringAsFixed(0))}"))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: containerOlustur(Text(
                                "En iyi Skor: ${(_bestScore.toStringAsFixed(0))}"))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: containerOlustur(Text("Zorluk: Kolay"))),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "@FC 2022",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                          ),
                        )),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  containerOlustur(Text a) {
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400, width: 0.7),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white70),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: a),
      ),
    );
  }

  void reset() {
    Navigator.pop(context);
    if (_skor > _bestScore) {
      setState(() {
        _bestScore = _skor;
      });
    }
    setState(() {
      birinci = 1.8;
      ikinci = birinci + 1.5;
      kusY = 0;
      kusPozisyon = kusY;
      oyunBasladiMi = false;
      zaman = 0;
      _skor = 0;
    });
  }
}
