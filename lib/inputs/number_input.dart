import 'package:flutter/material.dart';

class NumberInput extends StatelessWidget {
  final int? initialValue;
  final dynamic state;
  final dynamic controller;

  const NumberInput({
    super.key,
    this.initialValue,
    this.state,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final value = (state?.value ?? initialValue)?.toString() ?? '';
    final textController = TextEditingController(text: value)
      ..selection = TextSelection.collapsed(offset: value.length);

    return TextField(
      controller: textController,
      onChanged: (val) {
        final number = int.tryParse(val);
        controller?.updateValue(number);
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: InputBorder.none),
    );
  }
}
