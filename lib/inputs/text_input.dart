import 'package:flutter/material.dart';
import 'package:template_input/core/validator_function.dart';

class CustomTextInput extends StatelessWidget {
  final String? initialValue;
  final dynamic state;
  final dynamic controller;
  final List<ValidatorFunction>? validators;

  const CustomTextInput({
    super.key,
    this.initialValue,
    this.state,
    this.controller,
    this.validators,
  });

  @override
  Widget build(BuildContext context) {
    final text = state?.value ?? initialValue ?? '';
    return TextFormField(
      controller: TextEditingController(text: text)
        ..selection = TextSelection.collapsed(offset: text.length),
      onChanged: (val) {
        controller?.updateValue(val);
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        errorText: state?.error,
      ),
    );
  }
}
