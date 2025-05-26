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
  late final FabrikFormNotifier<String> formNotifier;

  @override
  void initState() {
    super.initState();

    formNotifier = FabrikFormNotifier<String>(
      FabrikForm({
        'email': FabrikField<String>(value: '', validators: [EmailValidator()]),
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
      }),
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

    print('Logging in with email: $email & password: $password');

    if (form.isValid) {
      print('✅ Form is valid, proceeding with login...');
      // perform login
    } else {
      print('❌ Form is invalid, showing errors...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FabrikFormBuilder<String>(
      formNotifier: formNotifier,
      builder: (context, form, get) {
        final emailField = get<String>('email');
        final passwordField = get<String>('password');

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
