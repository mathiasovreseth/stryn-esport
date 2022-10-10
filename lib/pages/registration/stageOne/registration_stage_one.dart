import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:stryn_esport/pages/registration/stageOne/bloc/registration_stage_one_state.dart';

import 'package:stryn_esport/pages/registration/stageOne/bloc/registration_step_one_cubit.dart';
import 'package:stryn_esport/pages/registration/stageTwo/registration_stage_two.dart';
import 'package:stryn_esport/repositories/auth_repository.dart';
import 'package:stryn_esport/widgets/appBars/arrow_back_app_bar.dart';
import 'package:stryn_esport/widgets/loading_indicator.dart';
import 'package:stryn_esport/widgets/snackBars/errorSnackBar.dart';
import 'package:stryn_esport/widgets/spacer.dart';

class RegistrationFormStageOne extends StatefulWidget {
  RegistrationFormStageOne({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => RegistrationFormStageOne(),
    );
  }

  @override
  State<RegistrationFormStageOne> createState() =>
      _RegistrationFormStageOneState();
}

class _RegistrationFormStageOneState extends State<RegistrationFormStageOne> {
  final bool _emailTaken = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowBackAppBar(
          headerText: 'Registrer bruker',
          onBackClick: () => Navigator.of(context).pop()),
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (BuildContext context) =>
            RegistrationStageOneCubit(AuthenticationRepository()),
        child: Form(
            key: widget._formKey,
            child: BlocListener<RegistrationStageOneCubit,
                    RegistrationStageOneState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status.isSubmissionSuccess) {
                    Navigator.of(context).push(RegistrationFormStageTwo.route(state.email.value, state.password.value));
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
                  child: ListView(shrinkWrap: true, children: [
                    const VerticalSpacer(height: 22),
                    _EmailInput(),
                    const VerticalSpacer(),
                    _PasswordInput(),
                    const VerticalSpacer(),
                    _ConfirmPasswordInput(),
                    const VerticalSpacer(height: 12),
                    _ContinueButton(),
                  ]),
                ))),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationStageOneCubit, RegistrationStageOneState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.next,
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<RegistrationStageOneCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'E-post',
            suffixIcon: SvgPicture.asset(
              'assets/icons/email_small.svg',
              color: Colors.white,
              width: 16,
              height: 16,
            ),
            hintText: 'E-post...',
            labelStyle: Theme.of(context).primaryTextTheme.labelMedium,
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
    return BlocBuilder<RegistrationStageOneCubit, RegistrationStageOneState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.next,
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) => context
              .read<RegistrationStageOneCubit>()
              .passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            suffixIcon: SvgPicture.asset(
              'assets/icons/lock_small.svg',
              color: Colors.white,
              width: 16,
              height: 16,
            ),
            labelText: 'Passord',
            labelStyle: Theme.of(context).primaryTextTheme.labelMedium,
            hintText: 'Passord',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationStageOneCubit, RegistrationStageOneState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.done,
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<RegistrationStageOneCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            suffixIcon: SvgPicture.asset(
              'assets/icons/lock_small.svg',
              color: Colors.white,
              width: 16,
              height: 16,
            ),
            labelText: 'Bekreft passord',
            labelStyle: Theme.of(context).primaryTextTheme.labelMedium,
            hintText: 'Bekreft passord',
            errorText: state.confirmedPassword.invalid
                ? 'passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}

class _ContinueButton extends StatelessWidget {
  void unFocusTextField(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationStageOneCubit, RegistrationStageOneState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.isSubmissionInProgress) {
          return const LoadingIndicator();
        }
        return ElevatedButton(
          key: const Key('signUpForm_continue_raisedButton'),
          onPressed: state.status.isValidated
              ? () {
                  unFocusTextField(context);
                  if (state.status.isValidated) {
                    context
                        .read<RegistrationStageOneCubit>()
                        .signUpFormSubmitted();
                  } else {
                    return;
                  }
                }
              : null,
          child: const Text('Neste'),
        );
      },
    );
  }
}
