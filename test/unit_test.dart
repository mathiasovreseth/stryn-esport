import 'package:flutter_test/flutter_test.dart';
import 'package:stryn_esport/pages/loginPage/utils/validation_config.dart';

void main() {
  test('Check correct email', () {
    const Email email = Email.dirty("test@test.no");

    expect(email.valid, true);
  });

  test('Check incorrect email', () {
    const Email email = Email.dirty("chuck");
    expect(email.valid, false);
  });
  test('Check incorrect email', () {
    const Email email = Email.dirty("@chuck");
    expect(email.valid, false);
  });
  test('Check incorrect email', () {
    const Email email = Email.dirty("chuck@");
    expect(email.valid, false);
  });
  test('Check incorrect email', () {
    const Email email = Email.dirty("chuck@microsoft");
    expect(email.valid, false);
  });
  test('Check incorrect email', () {
    const Email email = Email.dirty("@chuck@microsoft.com");
    expect(email.valid, false);
  });
  test('Check incorrect email', () {
    const Email email = Email.dirty("chuck@micr@osoft.com");
    expect(email.valid, false);
  });
  test('Check incorrect email', () {
    const Email email = Email.dirty("chuck@microsoft.com@");
    expect(email.valid, false);
  });
  test('Check incorrect email', () {
    const Email email = Email.dirty("  chuck@microsoft.com");
    expect(email.valid, false);
  });
  test('Check incorrect email', () {
    const Email email = Email.dirty("chuck@microsoft.com ");
    expect(email.valid, false);
  });

}