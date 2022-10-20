
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/arrow_back_header_bar.dart';
import 'bloc/forgot_password_cubit.dart';
import 'bloc/forgot_password_state.dart';


class ForgotPasswordForm extends StatefulWidget {
  ForgotPasswordForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  State<StatefulWidget> createState() => _ForgotPasswordFormState();

}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  bool _success = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget._formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 84),
                child: ArrowBackHeader(
                  onBackClick: () {
                    Navigator.of(context).pop();
                  },
                  headerText: 'Glømt passord',
                )
              ),
              _EmailInput(),
              Divider(height: 12, color: Theme.of(context).backgroundColor),
              if(_success)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: const Text('Ein e-post er sendt til deg for å tilbakestille passord', style: TextStyle(color: Colors.white)),
                  ),
                ),
              Divider(height: 12, color: Theme.of(context).backgroundColor),
            ],
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
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<ForgotPasswordCubit>().emailChange(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'E-post',
            suffixIcon: SvgPicture.asset(
              'asset/icons/e,ail_small.svg',
              color: Colors.white,
              width: 16,
              height: 16,
            ),
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' :null,
          ),
        );
      },
    );
  }
}