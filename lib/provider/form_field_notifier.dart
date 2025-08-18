import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_input/provider/form_field_state.dart';
import 'package:template_input/core/validator_function.dart';

final usernameFieldProvider =
    NotifierProvider<FormFieldController, FormFieldInternalState>(
      FormFieldController.new,
    );

final amountFieldProvider =
    NotifierProvider<FormFieldController, FormFieldInternalState>(
      FormFieldController.new,
    );
final selectProvider =
    NotifierProvider<FormFieldController, FormFieldInternalState>(
      FormFieldController.new,
    );

class FormFieldController extends Notifier<FormFieldInternalState> {
  @override
  FormFieldInternalState build() => FormFieldInternalState();
  List<ValidatorFunction> _validators = [];
  bool validateOnFieldUpdate = true;
  void setValidateOnFieldUpdate(bool value) {
    validateOnFieldUpdate = value;
  }

  void setValidators(List<ValidatorFunction> validators) {
    _validators = validators;
    // state = state.copyWith(validators: validators);
  }

  Future<void> updateValue(dynamic newValue) async {
    String? firstError;
    bool allValid = true;

    for (final validator in _validators) {
      final result = await validator(newValue);
      if (!result.isValid) {
        allValid = false;
        firstError = result.message;
        break; // short-circuit on first error
      }
    }
    // }
    state = state.copyWith(
      value: newValue,
      isDirty: true,
      error: firstError,
      isValid: allValid,
      validators: _validators,
    );
  }

  void reset() {
    state = FormFieldInternalState();
  }
}
