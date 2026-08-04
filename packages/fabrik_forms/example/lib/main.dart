import 'package:flutter/material.dart';
import 'package:fabrik_forms/fabrik_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fabrik Forms Example')),
      body: const SignInForm(),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late final FabrikFormNotifier formNotifier;

  @override
  void initState() {
    super.initState();

    formNotifier = FabrikFormNotifier(
      FabrikForm(
        {
          // Fields keep their own types, so one form can mix String, int
          // and bool values.
          'email': FabrikField<String>(
            value: '',
            validators: [EmailValidator()],
          ),
          'password': FabrikField<String>(
            value: '',
            validators: [
              PasswordValidator(
                requireDigit: true,
                requireUppercase: true,
                requireSpecialChar: true,
              ),
            ],
          ),
          'confirmPassword': FabrikField<String>(value: ''),
          'age': FabrikField<int>(
            value: 18,
            validators: [RangeValidator(min: 18, max: 120)],
          ),
        },
        // Rules spanning more than one field live at the form level.
        validators: [
          FieldsMatchValidator(
            field: 'password',
            matchField: 'confirmPassword',
            message: 'Passwords do not match',
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (!formNotifier.isValid) {
      formNotifier.markAllTouched();
      return;
    }

    final form = formNotifier.value;
    final email = form.get<String>('email').value;
    final password = form.get<String>('password').value;

    debugPrint('Logging in with email: $email & password: $password');

    if (form.isValid) {
      debugPrint('✅ Form is valid, proceeding with login...');
      // perform login
    } else {
      debugPrint('❌ Form is invalid, showing errors...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FabrikFormBuilder(
      formNotifier: formNotifier,
      builder: (context, form, get) {
        final emailField = get<String>('email');
        final passwordField = get<String>('password');
        final confirmField = get<String>('confirmPassword');
        final ageField = get<int>('age');

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: emailField.value,
                onChanged: (val) => formNotifier.update('email', val),
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: emailField.visibleError,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: passwordField.value,
                onChanged: (val) => formNotifier.update('password', val),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: passwordField.visibleError,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: confirmField.value,
                onChanged: (val) =>
                    formNotifier.update<String>('confirmPassword', val),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm password',
                  // Cross-field errors belong to the form, not to one field.
                  errorText: confirmField.isTouched ? form.formError : null,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: '${ageField.value}',
                keyboardType: TextInputType.number,
                onChanged: (val) =>
                    formNotifier.update<int>('age', int.tryParse(val) ?? 0),
                decoration: InputDecoration(
                  labelText: 'Age',
                  errorText: ageField.visibleError,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onSubmit,
                child: const Text('Sign In'),
              ),
            ],
          ),
        );
      },
    );
  }
}
