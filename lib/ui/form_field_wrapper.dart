import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart' hide FormFieldState;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_input/core/constants/enums.dart';
import 'package:template_input/inputs/franchise_input.dart';
import 'package:template_input/inputs/number_input.dart';
import 'package:template_input/inputs/select_input.dart';
import 'package:template_input/inputs/text_area_input.dart';
import 'package:template_input/inputs/text_input.dart';
import 'package:template_input/provider/form_field_notifier.dart';
import 'package:template_input/provider/form_field_state.dart';
import 'package:template_input/core/validator_function.dart';

class FormFieldWrapper extends ConsumerWidget {
  final String? label;
  final InputType type;
  final String? helperText;
  final bool isOptional;
  final List<ValidatorFunction>? validators;
  final String? warningMessage;
  final bool showWarning;
  final dynamic initialValue;
  final NotifierProvider<FormFieldController, FormFieldInternalState>? provider;
  final bool validateOnFieldUpdate;

  const FormFieldWrapper({
    super.key,
    this.label,
    required this.type,
    this.helperText,
    this.isOptional = false,
    this.validators,
    this.warningMessage,
    this.showWarning = true,
    this.initialValue,
    this.provider,
    this.validateOnFieldUpdate = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = provider != null ? ref.watch(provider!) : null;
    final controller = provider != null ? ref.read(provider!.notifier) : null;

    // Set validators if needed
    if (provider != null && validators != null) {
      controller!.setValidators(validators!);
    }
    // Set validateOnFieldUpdate if needed

    Widget input;
    switch (type) {
      case InputType.text:
        input = CustomTextInput(
          initialValue: initialValue,
          state: state,
          controller: controller,
          validators: validators,
        );
        break;
      case InputType.number:
        input = NumberInput(
          initialValue: initialValue,
          state: state,
          controller: controller,
        );
        break;
      case InputType.select:
        input = SelectInput(
          field: FormFieldState(
            value: initialValue,
            isDirty: state!.isDirty,
            error: state.error,
            updateValue: controller!.updateValue,
            isValid: state.isValid,
            validators: validators ?? [],
          ),
          options: const [
            DropDownValueModel(name: 'Option 1', value: 'value1'),
            DropDownValueModel(name: 'Option 2', value: 'value2'),
            DropDownValueModel(name: 'Option 3', value: 'value3'),
          ],
        );
        break;
      case InputType.franchise:
        input = FranchiseInput(
          field: FormFieldState(
            value: initialValue,
            isDirty: state!.isDirty,
            error: state.error,
            updateValue: controller!.updateValue,
            isValid: state.isValid,
            validators: validators ?? [],
          ),
        );
        break;
      case InputType.textArea:
        input = CustomTextAreaInput(
          initialValue: initialValue,
          state: state,
          controller: controller,
        );
        break;
      default:
        input = Text("Unsupported input type: $type");
    }

    final showError = state?.error != null && state?.isDirty == true;
    final showWarningMessage =
        showWarning &&
        warningMessage != null &&
        state?.isDirty == true &&
        state?.error == null;
    final borderColor = state!.isDirty
        ? state.isValid
              ? Colors.blue
              : Colors.red
        : state.error != null
        ? Colors.red
        : Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(label!, style: const TextStyle(fontWeight: FontWeight.bold)),
        if (helperText != null || isOptional)
          Text(
            helperText ?? 'Optional',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              //prefix
              Expanded(child: input),
            ],
          ),
        ),
        if (showError)
          Text(state.error!, style: const TextStyle(color: Colors.red)),
        if (showWarningMessage)
          Text(warningMessage!, style: const TextStyle(color: Colors.orange)),
      ],
    );
  }
}
