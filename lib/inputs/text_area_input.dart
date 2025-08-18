import 'package:flutter/material.dart';

class CustomTextAreaInput extends StatelessWidget {
  final String? initialValue;
  final dynamic state;
  final dynamic controller;

  const CustomTextAreaInput({
    super.key,
    this.initialValue,
    this.state,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final text = state?.value ?? initialValue ?? '';
    return TextField(
      maxLines: null,
      controller: TextEditingController(text: text)
        ..selection = TextSelection.collapsed(offset: text.length),
      onChanged: (val) {
        controller?.updateValue(val);
      },
      decoration: const InputDecoration(border: InputBorder.none),
    );
  }
}
