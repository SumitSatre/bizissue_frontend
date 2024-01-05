// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class TextFormFieldPatreon extends StatelessWidget {
  final String? hintText;
  final String? formStateKey;
  final String? initialValue;
  final Colors? borderColor;
  final int? numberOfLines;
  final int? maxLength;
  final bool? readOnly;
  final bool? isNumber;

  final TextEditingController? controller;
  final void Function(String, String)? updateFormState;

  const TextFormFieldPatreon({
    Key? key,
    this.hintText,
    this.initialValue,
    this.isNumber,
    this.maxLength,
    this.readOnly,
    this.formStateKey,
    this.updateFormState,
    this.borderColor,
    this.numberOfLines,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        maxLength: maxLength,
        controller: controller,
        buildCounter: null,
        enabled: readOnly == true ? false : true,
        initialValue: initialValue,
        keyboardType: (isNumber != null && isNumber == true)
            ? TextInputType.number
            : null,
        maxLines: numberOfLines,
        onSaved: (value) {
          if (updateFormState != null && formStateKey != null) {
            updateFormState!(formStateKey!, value ?? "");
          }
        },
        minLines: numberOfLines,
        style: const TextStyle(color: Colors.black),
        // controller: widget.controller,
        decoration: InputDecoration(
          counterText: "",
          fillColor: Colors.grey.shade300,
          filled: readOnly,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          hintText: hintText,
          hintStyle: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Colors.black38,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Colors.black38,
            ),
          ),
        ),
      ),
    );
  }
}
