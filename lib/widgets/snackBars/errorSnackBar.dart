

import 'package:flutter/material.dart';


SnackBar createErrorSnackBar(String content) {
  return SnackBar(
      backgroundColor: Colors.black87,
      duration: const Duration(seconds: 8),
      
      content: Text(content, style: const TextStyle(color: Colors.red, fontSize: 16),),
  );
}
