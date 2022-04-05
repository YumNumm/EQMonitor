import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnEEWWidget extends StatelessWidget {
  const OnEEWWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: -2,
            blurRadius: 10,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            height: context.height * 0.07,
            width: context.width * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [Colors.red.shade900, Colors.redAccent],
                stops: const [0, 1],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
              ),
            ),
            child: Row(
              children: [
                // MaxInt
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /*const Flexible(
                      flex: 0,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: AutoSizeText(
                          '最大震度',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),*/
                    Flexible(
                      flex: 8,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.asset('assets/intensity/2.PNG'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 2),
                // EEW情報
                Column(
                  children: [
                    Container(width: 100),

                    const SizedBox(height: 2),
                    // 種別
                    const AutoSizeText(
                      '緊急地震速報(予報)',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                    const AutoSizeText('M2.0'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NonEEW extends StatelessWidget {
  const NonEEW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            height: context.height * 0.1,
            width: context.width * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withOpacity(0.3),
            ),
            child: const Padding(
              padding: EdgeInsetsDirectional.all(10),
              child: AutoSizeText(
                '',
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
