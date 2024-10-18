import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

Widget BuildInputPassword(
        {required String hintText,
        required String imgPath,
        required TextEditingController inputController}) =>
    TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: inputController,
      maxLength: 4,
      cursorColor: Colors.black,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(
              imgPath,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              // toggleVisible();
            },
            child: Icon(
              Icons.visibility_off,
              color: Colors.black54,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF000000)),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFBCBCBC)),
              borderRadius: BorderRadius.circular(10))),
    );
