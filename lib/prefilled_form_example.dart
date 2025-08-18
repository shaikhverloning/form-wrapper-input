import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_input/core/constants/enums.dart';
import 'package:template_input/ui/form_field_wrapper.dart';
import 'package:template_input/provider/form_field_notifier.dart';

class PrefilledFormWidget extends ConsumerStatefulWidget {
  const PrefilledFormWidget({super.key});

  @override
  PrefilledFormState createState() => PrefilledFormState();
}

class PrefilledFormState extends ConsumerState<PrefilledFormWidget> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _nameController =
  //     TextEditingController();
  // final TextEditingController _emailController =
  //     TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prefilled Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormFieldWrapper(
                validateOnFieldUpdate: true,
                initialValue: ref.watch(amountFieldProvider).value,
                label: 'Text Input',
                helperText: 'Enter a unique username',
                isOptional: true,
                // warningMessage: 'Username looks good, but double-check!',
                validators: [
                  //requiredValidator,
                  // (value) => ibanValidator(value)
                ],

                type: InputType.number,
                provider: amountFieldProvider,
              ),
              SizedBox(height: 16),
              FormFieldWrapper(
                validateOnFieldUpdate: true,
                initialValue: '${ref.read(usernameFieldProvider).value}',
                label: 'Email Input',
                helperText: 'Enter your email',
                isOptional: false,
                validators: [
                  //(value) => emailValidator(value),
                ],
                type: InputType.text,
                provider: usernameFieldProvider,
              ),
              // ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Handle form submission
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Form submitted')));
                    ref.read(usernameFieldProvider.notifier).reset();
                    ref.read(amountFieldProvider.notifier).reset();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
