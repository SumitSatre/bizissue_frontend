// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final int? maxLines;
  final String? initialValue;
  final void Function(String)? onChanged;
  final TextEditingController? textEditingController;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isReadOnly;

  const CustomTextFormField(
      {Key? key,
      this.hintText,
      this.textEditingController,
      this.initialValue,
      this.maxLines,
      this.enabled,
      this.onChanged,

        this.inputFormatters,this.isReadOnly})

      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly ?? false,
      enabled: enabled,
      initialValue: initialValue,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.black),
      controller: textEditingController,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.black12,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.grey.shade600),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.black12,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
      cursorColor: Colors.black,
      cursorHeight: 22,
      cursorWidth: 1.8,
    );
  }
}
