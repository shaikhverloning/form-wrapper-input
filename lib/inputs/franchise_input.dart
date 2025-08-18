import 'package:flutter/material.dart' hide FormFieldState;
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:template_input/provider/form_field_state.dart';

final List<DropDownValueModel> franchise = [
  DropDownValueModel(name: 'Franchise 1', value: 'franchise_1'),
  DropDownValueModel(name: 'Franchise 2', value: 'franchise_2'),
  DropDownValueModel(name: 'Franchise 3', value: 'franchise_3'),
];

class FranchiseInput extends StatefulWidget {
  final FormFieldState field;

  const FranchiseInput({super.key, required this.field});

  @override
  State<FranchiseInput> createState() => _FranchiseInputState();
}

class _FranchiseInputState extends State<FranchiseInput> {
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
          enableSearch: false,
          searchAutofocus: false,
          dropDownItemCount: franchise.length,
          dropDownList: franchise,
          onChanged: (val) {
            if (val is DropDownValueModel) {
              widget.field.updateValue(val.value);
            }
          },
          textFieldDecoration: InputDecoration(
            hintText: "Select Franchise",
            border: InputBorder.none,
            errorText: showError ? widget.field.error : null,
          ),
        ),
      ],
    );
  }
}
