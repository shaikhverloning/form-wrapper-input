import 'package:flutter/material.dart' hide FormFieldState;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_input/core/constants/enums.dart';
import 'package:template_input/ui/form_field_wrapper.dart';
import 'package:template_input/prefilled_form_example.dart';
import 'package:template_input/provider/form_field_notifier.dart';
import 'package:template_input/core/validator_function.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ' TextInput Value: ${ref.watch(usernameFieldProvider).value}',
                ),
                Text(' Isdirty: ${ref.watch(usernameFieldProvider).isDirty}'),
                Text(' IsValid: ${ref.watch(usernameFieldProvider).isValid}'),
                FormFieldWrapper(
                  initialValue: 'afrah',
                  validateOnFieldUpdate: true,
                  // initialValue:'${ref.watch(amountFieldProvider).value}' ,
                  label: 'Text Input',
                  helperText: 'Enter a unique username',
                  isOptional: true,
                  // warningMessage: 'Username looks good, but double-check!',
                  validators: [
                    requiredValidator,
                  ],

                  type: InputType.text,
                  provider: usernameFieldProvider,
                ),
                FormFieldWrapper(
                  validateOnFieldUpdate: true,
                  label: 'Number Input',
                  isOptional: false,
                  validators: [
                    (value) => minLengthValidator(value, 3),
                    (value) => maxLengthValidator(value, 10),
                  ],
                  type: InputType.number,
                  provider: amountFieldProvider,
                ),
                FormFieldWrapper(
                  label: 'Select an option',
                  initialValue: 'Maak een keuze',
                  //showWarning: true,
                  //warningMessage: 'Minimum value should be min 3',
                  isOptional: false,
                  validators: [(value) => requiredValidator(value)],
                  type: InputType.select,
                  provider: selectProvider,
                  //provider: amountFieldProvider,
                ),
                FormFieldWrapper(
                  label: 'Select an Franchise',
                  //initialValue: 'Maak een keuze',
                  //showWarning: true,
                  //warningMessage: 'Minimum value should be min 3',
                  isOptional: false,
                  validators: [(value) => requiredValidator(value)],
                  type: InputType.franchise,
                  provider: selectProvider,
                  //provider: amountFieldProvider,
                ),
                FormFieldWrapper(
                  label: 'Text Area',
                  isOptional: false,
                  validators: [
                    //(value) => requiredValidator(value),
                  ],
                  type: InputType.textArea,
                  provider: selectProvider,
                ),

                TextButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrefilledFormWidget(),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
