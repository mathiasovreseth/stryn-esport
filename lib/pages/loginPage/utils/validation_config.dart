import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

/// Validation errors for the [Password] [FormzInput].
enum PasswordValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for an password input.
/// {@endtemplate}
class Password extends FormzInput<String, PasswordValidationError> {
  /// {@macro password}
  const Password.pure() : super.pure('');

  /// {@macro password}
  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }
}

/// Validation errors for the [Email] [FormzInput].
enum EmailValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template email}
/// Form input for an email input.
/// {@endtemplate}
class Email extends FormzInput<String, EmailValidationError> {
  /// {@macro email}
  const Email.pure() : super.pure('');

  /// {@macro email}
  const Email.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegExp = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}
/// Validation errors for the [ConfirmedPassword] [FormzInput].
enum ConfirmedPasswordValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template confirmed_password}
/// Form input for a confirmed password input.
/// {@endtemplate}
class ConfirmedPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {
  /// {@macro confirmed_password}
  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');

  /// {@macro confirmed_password}
  const ConfirmedPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  /// The original password.
  final String password;

  @override
  ConfirmedPasswordValidationError? validator(String value) {
    return password == value ? null : ConfirmedPasswordValidationError.invalid;
  }
}

/// Validation errors for the [Name] [FormzInput].
enum NameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template name}
/// Form input for a name input.
/// {@endtemplate}
class Name extends FormzInput<String, NameValidationError> {
  /// {@macro name}
  const Name.pure() : super.pure('');

  /// {@macro name}
  const Name.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
    "[a-z']{2,10}",
  );

  @override
  NameValidationError? validator(String value) {
    return _nameRegExp.hasMatch(value) ? null : NameValidationError.invalid;
  }
}

/// Validation errors for the [PhoneNumber] [FormzInput].
enum PhoneNumberValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template name}
/// Form input for a name input.
/// {@endtemplate}
class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  /// {@macro name}
  const PhoneNumber.pure() : super.pure('');

  /// {@macro name}
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final RegExp _phoneNumberRegExp = RegExp(r'^[0-9]{8}$');

  @override
  PhoneNumberValidationError? validator(String value) {
    // return null;
    return _phoneNumberRegExp.hasMatch(value)
        ? null
        : PhoneNumberValidationError.invalid;
  }
}

/// Validation errors for the [Address] [FormzInput].
enum AddressValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template name}
/// Form input for a name input.
/// {@endtemplate}
class Address extends FormzInput<String, AddressValidationError> {
  /// {@macro name}
  const Address.pure() : super.pure('');

  /// {@macro name}
  const Address.dirty([String value = '']) : super.dirty(value);

  @override
  AddressValidationError? validator(String value) {
    return value.isNotEmpty ? null : AddressValidationError.invalid;
  }
}

/// Validation errors for the [PostNumber] [FormzInput].
enum PostNumberValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template name}
/// Form input for a name input.
/// {@endtemplate}
class PostNumber extends FormzInput<String, PostNumberValidationError> {
  /// {@macro name}
  const PostNumber.pure() : super.pure('');

  /// {@macro name}
  const PostNumber.dirty([String value = '']) : super.dirty(value);

  static final RegExp _postNumberRegExp = RegExp(r'^[0-9]{4}$');

  @override
  PostNumberValidationError? validator(String value) {
    return _postNumberRegExp.hasMatch(value)
        ? null
        : PostNumberValidationError.invalid;
  }
}
