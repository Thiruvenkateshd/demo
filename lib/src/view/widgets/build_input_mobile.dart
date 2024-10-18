import 'package:flutter/material.dart';

Widget BuildInputMobile(
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
      keyboardType: TextInputType.phone,
      maxLength: 10,
      controller: inputController,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          hintText: hintText,
          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(10, 14, 0, 14),
            child: Text(
              '+91-',
              style: TextStyle(fontSize: 16),
            ),
          ),
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
    );
