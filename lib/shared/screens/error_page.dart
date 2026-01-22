import 'package:flutter/material.dart';
import 'package:myapp/core/extensions/color_extensions.dart';

/// Error page
class ErrorPage extends StatelessWidget {
  /// Constructor
  const ErrorPage({required this.error, super.key});

  final String error;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Login')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 24),
            const Text(
              'Something went wrong',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              error,
              style: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withAlphaValue(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: () => {}, child: const Text('Go Home')),
          ],
        ),
      ),
    ),
  );
}
