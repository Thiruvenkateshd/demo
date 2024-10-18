import 'package:flutter/material.dart';
import 'package:task1/src/controller/colors.dart';

Widget BuildInputEmail({
  required TextEditingController inputController,
  String? Function(String?)? validate,
  String? hintText,
}) =>
    TextFormField(
      controller: inputController,
      validator: validate,
      cursorColor: blueColor,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15, 12, 5, 12),
          hintText: hintText,
          suffix: inputController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : GestureDetector(
                  onTap: () => inputController.clear(),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.close,
                      size: 18,
                    ),
                  ),
                ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF000000)),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFBCBCBC)),
              borderRadius: BorderRadius.circular(10))),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
    );
