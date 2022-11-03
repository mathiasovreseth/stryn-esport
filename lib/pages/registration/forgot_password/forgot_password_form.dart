
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stryn_esport/repositories/auth_repository.dart';
import 'package:stryn_esport/widgets/snackBars/errorSnackBar.dart';

import '../../../styles/text_input_style.dart';
import '../../../widgets/appBars/arrow_back_app_bar.dart';
import '../../../widgets/loading_indicator.dart';
import 'bloc/forgot_password_cubit.dart';
import 'bloc/forgot_password_state.dart';

class ForgotPasswordForm extends StatefulWidget {
  ForgotPasswordForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => ForgotPasswordForm(),
    );
  }

  @override
  State<StatefulWidget> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {

  bool _success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowBackAppBar(
          headerText: 'Glømt passord',
          onBackClick: () => Navigator.of(context).pop()),
          resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (BuildContext context) => ForgotPasswordCubit(AuthenticationRepository()),
        child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listenWhen: (previous, current) =>
          previous.status != current.status,
          listener: (context, state) {
            if (state.status.isSubmissionSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(infoSnackBar('Password reset sent'));
            } else if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(createErrorSnackBar(state.errorMessage ?? 'Failure'));
            }
          },
        child: Form(
          key: widget._formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              children: [
                _EmailInput(),
                Divider(height: 12, color: Theme.of(context).backgroundColor),
                _ResettButton(),
                Divider(height: 12, color: Theme.of(context).backgroundColor),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.next,
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<ForgotPasswordCubit>().emailChange(email),
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

class _ResettButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
            ? const LoadingIndicator()
                : ElevatedButton(
                key: const Key('forgot_password_form_submit'),
                onPressed: state.status.isValidated ? () {
                    context.read<ForgotPasswordCubit>().sendEmail();
                  } : null,
                child: const Text('Send nytt passord'),);

    },);
  }
}