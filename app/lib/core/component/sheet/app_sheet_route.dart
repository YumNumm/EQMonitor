import 'package:flutter/material.dart';
import 'package:sheet/route.dart';
import 'package:sheet/sheet.dart';

class AppSheetRoute<T> extends SheetRoute<T> {
  AppSheetRoute({
    required super.builder,
    super.initialExtent = 0.6,
  }) : super(
         fit: SheetFit.loose,
         stops: [initialExtent, 1],
         decorationBuilder:
             (context, child) => SafeArea(
               bottom: false,
               child: Material(
                 elevation: 2,
                 clipBehavior: Clip.hardEdge,
                 shape: const RoundedRectangleBorder(
                   borderRadius: BorderRadius.vertical(
                     top: Radius.circular(16),
                   ),
                 ),
                 child: child,
               ),
             ),
         animationCurve: Curves.easeOutExpo,
         duration: const Duration(milliseconds: 250),
       );
}
