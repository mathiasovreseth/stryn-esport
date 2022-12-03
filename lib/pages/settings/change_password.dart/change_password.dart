import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stryn_esport/pages/app/bloc/app_bloc.dart';
import 'package:stryn_esport/pages/settings/change_password.dart/bloc/change_password_cubit.dart';
import 'package:stryn_esport/pages/settings/change_password.dart/bloc/change_password_state.dart';
import 'package:stryn_esport/repositories/auth_repository.dart';
import 'package:stryn_esport/styles/text_input_style.dart';
import 'package:stryn_esport/widgets/appBars/arrow_back_app_bar.dart';
import 'package:stryn_esport/widgets/loading_indicator.dart';
import 'package:stryn_esport/widgets/snackBars/errorSnackBar.dart';
import 'package:stryn_esport/widgets/spacer.dart';

class ChangePasswordPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ChangePasswordPage({Key? key});

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const ChangePasswordPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChangePasswordCubit(
          AuthenticationRepository(), context.read<AppBloc>().state.user),
      child: Scaffold(
          appBar: ArrowBackAppBar(
              headerText: "Endre passord",
              onBackClick: () => Navigator.of(context).pop()),
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status.isSubmissionSuccess) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        createSuccessSnackBar("Passord endret!", context),
                      );
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } else if (state.status.isSubmissionFailure) {
                    print("SUBMISSION FAILIURE");
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        createErrorSnackBar(state.errorMessage),
                      );
                  }
                },
                child: const _ChangePasswordForm()),
          )),
    );
  }
}

class _ChangePasswordForm extends StatelessWidget {
  const _ChangePasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const VerticalSpacer(height: 66),
            _OldPasswordInput(),
            const VerticalSpacer(
              height: 22,
            ),
            _PasswordInput(),
            const VerticalSpacer(),
            _ConfirmPasswordInput(),
            const VerticalSpacer(),
            _ChangePasswordButton(),
          ]),
    );
  }
}

class _OldPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.next,
          key: const Key('changePassword_oldPasswordInput_textField'),
          onChanged: (password) =>
              context.read<ChangePasswordCubit>().oldPasswordChanged(password),
          obscureText: true,
          decoration: textFormDecoration(
            hintText: 'Gjeldande passord...',
            context: context,
            label: 'Gjeldande passord',
            suffixIcon: 'assets/icons/lock_small.svg',
          ),
        );
      },
    );
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
          key: const Key('changePassword_passwordInput_textField'),
          onChanged: (password) =>
              context.read<ChangePasswordCubit>().passwordChanged(password),
          obscureText: true,
          decoration: textFormDecoration(
            hintText: 'Nytt passord...',
            context: context,
            errorText: state.password.invalid ? 'invalid password' : null,
            label: 'Nytt passord',
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
          key: const Key('changePassword_confirmPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<ChangePasswordCubit>()
              .confirmPasswordChanged(confirmPassword),
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

class _ChangePasswordButton extends StatelessWidget {
  void unFocusTextField(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const LoadingIndicator()
            : ElevatedButton(
                key: const Key('changePasswordForm_submit_raisedButton'),
                onPressed: state.status.isValidated
                    ? () {
                        unFocusTextField(context);
                        context.read<ChangePasswordCubit>().onSubmit();
                      }
                    : null,
                child: const Text('Endre passord'),
              );
      },
    );
  }
}
