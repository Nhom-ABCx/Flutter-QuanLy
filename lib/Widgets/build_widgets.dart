import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget itemMenuWidget({required BuildContext context, required Widget child}) => Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width / 2.2,
      decoration: customContainerDeco(),
      child: child,
    );

Decoration customContainerDeco() => const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey, offset: Offset(1, 2))]);
