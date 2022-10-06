import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:stryn_esport/pages/loginPage/bloc/login_cubit.dart';
import 'package:stryn_esport/pages/loginPage/bloc/login_state.dart';
import 'package:stryn_esport/repositories/auth_repository.dart';

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
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 70),
                      _TitleAndImage(),
                      const SizedBox(height: 24),
                      _EmailInput(),
                      const SizedBox(
                        height: 12,
                      ),
                      _PasswordInput(),
                      // add forgot password her
                      const SizedBox(height: 12),
                      _LoginButton(),
                    ],
                  ),
                  TextButton(
                    child: Text(
                      "Har du ikkje bruker? Registrer deg",
                      style: TextStyle(color: Colors.black.withOpacity(0.65)),
                    ),
                    onPressed: () => {},
                  ),
                ]),
          ),
        ),
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
          'assets/images/tempbilde.png',
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
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            suffixIconConstraints:
                const BoxConstraints(minHeight: 24, minWidth: 24),
            suffixIcon: SvgPicture.asset(
              'assets/icons/email_small.svg',
              color: Theme.of(context).primaryColor,
              width: 24,
              height: 24,
              allowDrawingOutsideViewBox: false,
              fit: BoxFit.contain,
            ),
            labelText: 'E-post',
            labelStyle: Theme.of(context).primaryTextTheme.labelMedium,
            hintText: 'E-post...',
            errorText: state.email.invalid ? 'invalid email' : null,
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
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Passord',
            labelStyle: Theme.of(context).primaryTextTheme.labelMedium,
            suffixIconConstraints:
                const BoxConstraints(minHeight: 24, minWidth: 24),
            suffixIcon: SvgPicture.asset(
              'assets/icons/lock_small.svg',
              color: Theme.of(context).primaryColor,
              allowDrawingOutsideViewBox: false,
              width: 24,
              height: 24,
            ),
            hintText: 'Passord...',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    primary: Colors.red),
                onPressed: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
                child: const Text('LOGIN'),
              );
      },
    );
  }
}
