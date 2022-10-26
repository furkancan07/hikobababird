// ignore_for_file: avoid_unnecessary_containers, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Kus extends StatefulWidget {
  final double kusKonum;
  final String kahraman;
  const Kus({required this.kusKonum, super.key, required this.kahraman});

  @override
  State<Kus> createState() => _KusState();
}

class _KusState extends State<Kus> {
  String url =
      "https://apksos.com/storage/images/com/mec/hikobabarun/com.mec.hikobabarun_1.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, widget.kusKonum),
      // KARAKTERİMİZİN FOTOSUNU SEÇME
      child: widget.kahraman == "1"
          ? Image.asset(
              "assets/hikobaba.png",
              width: 80,
            )
          : widget.kahraman == "2"
              ? Image.asset(
                  "assets/indir.jfif",
                  width: 50,
                )
              : widget.kahraman == "3"
                  ? Image.asset(
                      "assets/kus.png",
                      width: 50,
                    )
                  : widget.kahraman == "4"
                      ? Image.asset(
                          "assets/seyma.jpg",
                          width: 50,
                        )
                      : Image.asset(
                          "assets/betul.jpg",
                          width: 50,
                        ),
    );
  }
}
