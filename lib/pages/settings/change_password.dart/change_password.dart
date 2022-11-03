import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stryn_esport/pages/settings/change_password.dart/bloc/change_password_cubit.dart';
import 'package:stryn_esport/pages/settings/change_password.dart/bloc/change_password_state.dart';
import 'package:stryn_esport/styles/text_input_style.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  String _oldPassword = "";

  String _password = "";

  String _confirmPassword = "";

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordCompliant(String password) {
    RegExp regex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\w\W]{8,}$');

    if (!regex.hasMatch(password)) {
      return false;
    } else {
      return true;
    }
  }

  void onOldPasswordChange(String text) {
    setState(() {
      _oldPassword = text;
    });
  }

  void onPasswordChange(String text) {
    setState(() {
      _password = text;
    });
  }

  void onConfirmPasswordChange(String text) {
    setState(() {
      _confirmPassword = text;
    });
  }

  String currentUid = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void makeRoutePage({required BuildContext context, Widget? pageRef}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => pageRef!),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: []))));
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.next,
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<ChangePasswordCubit>().passwordChanged(password),
          obscureText: true,
          decoration: textFormDecoration(
            hintText: 'Passord...',
            context: context,
            errorText: state.password.invalid ? 'invalid password' : null,
            label: 'Passord',
            suffixIcon: 'assets/icons/lock_small.svg',
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.done,
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<ChangePasswordCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: textFormDecoration(
            hintText: 'Bekreft passord...',
            context: context,
            errorText: state.confirmedPassword.invalid
                ? 'passwords do not match'
                : null,
            label: 'Bekreft passord',
            suffixIcon: 'assets/icons/lock_small.svg',
          ),
        );
      },
    );
  }
}
