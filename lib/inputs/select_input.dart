import 'package:flutter/material.dart' hide FormFieldState;
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:template_input/provider/form_field_state.dart';

class SelectInput extends StatefulWidget {
  final FormFieldState field;
  final List<DropDownValueModel> options;

  const SelectInput({super.key, required this.field, required this.options});

  @override
  State<SelectInput> createState() => _SelectInputState();
}

class _SelectInputState extends State<SelectInput> {
  late final SingleValueDropDownController _cnt;

  @override
  void initState() {
    super.initState();

    _cnt = SingleValueDropDownController();

    // Set the initial value if it exists
    final existingValue = widget.field.value;
    if (existingValue != null &&
        existingValue is String &&
        existingValue.isNotEmpty) {
      _cnt.setDropDown(
        DropDownValueModel(name: existingValue, value: existingValue),
      );
    }
  }

  @override
  void dispose() {
    _cnt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showError = widget.field.isDirty && widget.field.error != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropDownTextField(
          searchDecoration: InputDecoration(
            hintText: "Search...",
            border: InputBorder.none,
          ),
          controller: _cnt,
          enableSearch: true,
          dropDownItemCount: widget.options.length,
          dropDownList: widget.options,
          onChanged: (val) {
            if (val is DropDownValueModel) {
              widget.field.updateValue(val.value);
            }
          },
          textFieldDecoration: InputDecoration(
            hintText: "Select an option",
            border: InputBorder.none,
            errorText: showError ? widget.field.error : null,
          ),
        ),
      ],
    );
  }
}
