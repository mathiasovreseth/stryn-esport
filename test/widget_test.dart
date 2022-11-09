// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stryn_esport/firebase_options.dart';

import 'package:stryn_esport/pages/app/app.dart';
import 'package:stryn_esport/pages/loginPage/LoginForm.dart';
import 'package:stryn_esport/repositories/auth_repository.dart';

void main() {

  testWidgets('email input-field is present', (WidgetTester tester) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    // await tester.pumpWidget(App(authenticationRepository: AuthenticationRepository()));
    await tester.pumpWidget(MaterialApp(home:LoginPage()));
    expect(find.byKey(const Key('loginForm_emailInput_textField')), findsWidgets);

  });
}
