// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stryn_esport/pages/settings/settings_page.dart';


void main() {

  testWidgets('email input-field is present', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsPage(),
      )
    );
    expect(find.byKey(const Key('edit-information-button')), findsWidgets);
    expect(find.byKey(const Key('change-password-button')), findsWidgets);
    expect(find.byKey(const Key('terms-of-service-button')), findsWidgets);
    expect(find.byKey(const Key('privacy-policy-button')), findsWidgets);

  });
}
