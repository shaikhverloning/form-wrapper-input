import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoneyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final void Function(String)? onChanged;

  const MoneyTextField({
    super.key,
    required this.controller,
    this.label = 'Amount',
    this.onChanged,
  });

  String _formatNumber(String s) {
    s = s.replaceAll(RegExp(r'[^0-9]'), '');
    if (s.isEmpty) return '';
    final value = int.parse(s);
    return value.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: label,
        prefixText: '\$ ',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        final formatted = _formatNumber(value);
        controller.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
        if (onChanged != null) onChanged!(formatted);
      },
    );
  }
}
