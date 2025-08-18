import 'package:template_input/core/validator_function.dart';

class FormFieldState {
  final dynamic value;
  final bool isDirty;
  final String? error;
  final Function(dynamic) updateValue;
  final bool isValid;
  final List<ValidatorFunction> validators;
  // final bool validateOnFieldUpdate;

  FormFieldState({
    required this.value,
    required this.isDirty,
    required this.error,
    required this.updateValue,
    required this.isValid,
    required this.validators,
    // this.validateOnFieldUpdate = false,
  });
}

class FormFieldInternalState {
  final dynamic value;
  final bool isDirty;
  final String? error;
  final bool isValid;
  final List<ValidatorFunction> validators;
  final bool validateOnFieldUpdate;

  FormFieldInternalState({
    this.value,
    this.isDirty = false,
    this.error,
    this.validators = const [],
    this.isValid = false,
    this.validateOnFieldUpdate = true,
  });

  FormFieldInternalState copyWith({
    dynamic value,
    bool? isDirty,
    String? error,
    bool? isValid,
    List<ValidatorFunction>? validators,
    bool? validateOnFieldUpdate,
  }) {
    return FormFieldInternalState(
      value: value ?? this.value,
      isDirty: isDirty ?? this.isDirty,
      error: error,
      isValid: isValid ?? this.isValid,
      validators: validators ?? this.validators,
      validateOnFieldUpdate:
          validateOnFieldUpdate ?? this.validateOnFieldUpdate,
    );
  }
}
