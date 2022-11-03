import 'package:flutter/material.dart';

SnackBar createErrorSnackBar(String content) {
  return SnackBar(
    backgroundColor: Colors.black87,
    duration: const Duration(seconds: 8),
    content: Text(
      content,
      style: const TextStyle(color: Colors.red, fontSize: 16),
    ),
  );
}

SnackBar createSuccessSnackBar(String content, BuildContext context) {
  return SnackBar(
    backgroundColor: Theme.of(context).primaryColor,
    duration: const Duration(seconds: 8),
    content: Text(
      content,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}
