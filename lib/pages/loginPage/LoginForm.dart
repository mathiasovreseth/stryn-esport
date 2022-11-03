import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:stryn_esport/pages/loginPage/bloc/login_cubit.dart';
import 'package:stryn_esport/pages/loginPage/bloc/login_state.dart';
import 'package:stryn_esport/pages/registration/forgot_password/forgot_password_form.dart';
import 'package:stryn_esport/pages/registration/stageOne/registration_stage_one.dart';
import 'package:stryn_esport/repositories/auth_repository.dart';
import 'package:stryn_esport/styles/text_input_style.dart';

import 'package:stryn_esport/widgets/loading_indicator.dart';
import 'package:stryn_esport/widgets/snackBars/errorSnackBar.dart';
import 'package:stryn_esport/widgets/spacer.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  static Page page() => MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (BuildContext context) =>
            LoginCubit(AuthenticationRepository()),
        child: Form(
            key: _formKey,
            child: BlocListener<LoginCubit, LoginState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status.isSubmissionSuccess) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } else if (state.status.isSubmissionFailure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      createErrorSnackBar(
                          state.errorMessage ?? 'Authentication Failure'),
                    );
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const VerticalSpacer(height: 66),
                          _TitleAndImage(),
                          const VerticalSpacer(height: 34),
                          _EmailInput(),
                          const VerticalSpacer(),
                          _PasswordInput(),
                          // add forgot password her
                          const VerticalSpacer(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _LoginButton(),
                              ),
                              Expanded(
                                child: TextButton(
                                  child: Text(
                                    "Glømt passord",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  onPressed: () => {
                                    Navigator.of(context)
                                        .push(ForgotPasswordForm.route()),
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      TextButton(
                        child: Text(
                          "Har du ikkje bruker? Registrer deg",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () => {
                          Navigator.of(context)
                              .push(RegistrationFormStageOne.route()),
                        },
                      ),
                    ]),
              ),
            )),
      ),
    );
  }
}

class _TitleAndImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 120,
          height: 120,
        ),
        const SizedBox(height: 12),
        Text(
          'Velkommen til Stryn esport',
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.black.withOpacity(0.85),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.next,
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: textFormDecoration(
            hintText: 'E-post...',
            context: context,
            errorText: state.email.invalid ? 'invalid email' : null,
            label: 'E-post',
            suffixIcon: 'assets/icons/email_small.svg',
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.done,
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
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

class _LoginButton extends StatelessWidget {
  void unFocusTextField(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const LoadingIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                    ? () {
                        unFocusTextField(context);
                        context.read<LoginCubit>().logInWithCredentials();
                      }
                    : null,
                child: const Text('LOGIN'),
              );
      },
    );
  }
}
