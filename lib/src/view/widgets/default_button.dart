import 'package:flutter/material.dart';
import 'package:task1/src/controller/colors.dart';
import 'package:task1/src/controller/utils.dart';

Widget DefaultButton(
        {required String btnText,
        required VoidCallback onTap,
        Color? buttonColor}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: buttonColor ?? blueColor),
        child: Text(
          btnText,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: whiteColor),
        ),
      ),
    );
