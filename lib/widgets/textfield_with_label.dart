import 'package:bizissue/widgets/textfield_patreon.dart';
import 'package:flutter/material.dart';

class TextFieldWithLabel extends StatelessWidget {
  final String label;
  final int? numberOfLines;
  final int? maxLength;
  final String? placeholderText;
  final TextEditingController? controller;
  final String? formStateKey;
  final bool? readOnly;
  final bool? hideLabel;
  final bool? isNumber;
  final String? initialValue;
  final void Function(String, String)? updateFormState;
  const TextFieldWithLabel(
      {super.key,
      required this.label,
      this.updateFormState,
      this.initialValue,
      this.maxLength,
      this.isNumber,
      this.hideLabel,
      this.formStateKey,
      this.readOnly,
      this.numberOfLines,
      this.placeholderText,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          if (hideLabel == null || hideLabel == false)
            Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              ],
            ),
          if (hideLabel == null || hideLabel == false)
            const SizedBox(
              height: 8,
            ),
          TextFormFieldPatreon(
            maxLength: maxLength,
            hintText: placeholderText,
            formStateKey: formStateKey,
            readOnly: readOnly,
            isNumber: isNumber,
            initialValue: initialValue,
            updateFormState: updateFormState,
            numberOfLines: numberOfLines,
            controller: controller,
          )
        ],
      ),
    );
  }
}
