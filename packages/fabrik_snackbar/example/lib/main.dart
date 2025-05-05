import 'package:fabrik_snackbar/fabrik_snackbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeView());
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fabrik Snackbars & Toasts')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Snackbars',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton(
                    onPressed:
                        () => FabrikSnackbar.success(
                          context,
                          title: 'Registration Successful!',
                          message: 'You have been successfully registered.',
                        ),
                    child: const Text('Success'),
                  ),
                  ElevatedButton(
                    onPressed:
                        () => FabrikSnackbar.error(
                          context,
                          title: 'Error Occurred',
                          message: 'Something went wrong, please try again.',
                        ),
                    child: const Text('Error'),
                  ),
                  ElevatedButton(
                    onPressed:
                        () => FabrikSnackbar.warning(
                          context,
                          title: 'Warning!',
                          message: 'Your internet is unstable.',
                        ),
                    child: const Text('Warning'),
                  ),
                  ElevatedButton(
                    onPressed:
                        () => FabrikSnackbar.info(
                          context,
                          title: 'Heads Up!',
                          message: 'New update is available.',
                        ),
                    child: const Text('Info'),
                  ),
                  ElevatedButton(
                    onPressed:
                        () => FabrikSnackbar.custom(
                          context,
                          config: FabrikSnackbarConfig(
                            title: 'Custom Title',
                            message: 'Custom background and style.',
                            backgroundColor: Colors.purple,
                            borderRadius: BorderRadius.circular(16),
                            duration: const Duration(seconds: 2),
                            actionButton: ElevatedButton(
                              onPressed:
                                  () => FabrikToast.show(
                                    context,
                                    message: 'Toast from Snackbar!',
                                  ),
                              child: const Text('Toast'),
                            ),
                          ),
                        ),
                    child: const Text('Custom'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Toasts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton(
                    onPressed:
                        () => FabrikToast.show(
                          context,
                          message: 'Toast at Top!',
                          position: FabrikToastPosition.top,
                        ),
                    child: const Text('Top'),
                  ),
                  ElevatedButton(
                    onPressed:
                        () => FabrikToast.show(
                          context,
                          message: 'Toast at Center!',
                          position: FabrikToastPosition.center,
                        ),
                    child: const Text('Center'),
                  ),
                  ElevatedButton(
                    onPressed:
                        () => FabrikToast.show(
                          context,
                          message: 'Toast at Bottom!',
                          position: FabrikToastPosition.bottom,
                          icon: Icons.check_circle_outline_rounded,
                          iconColor: Colors.green,
                        ),
                    child: const Text('Bottom'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
