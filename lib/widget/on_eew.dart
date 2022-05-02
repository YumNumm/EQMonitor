import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnEEWWidget extends StatelessWidget {
  OnEEWWidget({Key? key}) : super(key: key);

  final headGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 255, 0, 0),
            spreadRadius: -2,
            blurRadius: 10,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          height: context.height * 0.1,
          width: context.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 158, 2, 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 228, 221, 255),
                    ),
                    child: AutoSizeText(
                      'EEW(予報)',
                      group: headGroup,
                      minFontSize: 17,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  AutoSizeText(
                    '福島県沖',
                    group: headGroup,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(),
                  //! Overflowする....
                  Image.asset(
                    'assets/intensity/0.PNG',
                    fit: BoxFit.fitHeight,
                  ),
                  //! 
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
