import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:stryn_esport/pages/registration/stageTwo/bloc/registration_stage_two_cubit.dart';
import 'package:stryn_esport/pages/registration/stageTwo/bloc/registration_stage_two_state.dart';
import 'package:stryn_esport/repositories/auth_repository.dart';
import 'package:stryn_esport/widgets/appBars/arrow_back_app_bar.dart';
import 'package:stryn_esport/widgets/datePicker/custom_date_picker.dart';
import 'package:stryn_esport/widgets/loading_indicator.dart';
import 'package:stryn_esport/widgets/snackBars/errorSnackBar.dart';
import 'package:stryn_esport/widgets/spacer.dart';

class RegistrationFormStageTwo extends StatelessWidget {
  RegistrationFormStageTwo({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);
  final String email;
  final String password;
  final _formKey = GlobalKey<FormState>();

  static Route route(String email, String password) {
    return MaterialPageRoute<void>(
      builder: (_) => RegistrationFormStageTwo(email: email, password: password,),
    );
  }

  void unFocusTextField(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }
  }

  void openAgePicker(BuildContext context) {
    unFocusTextField(context);
    DatePicker.showPicker(
      context,
      showTitleActions: true,
      locale: LocaleType.no,
      pickerModel: CustomPicker(currentTime: DateTime(2015, 6, 15)),
      onConfirm: (date) =>
          context.read<RegistrationStageTwoCubit>().ageChange(date),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowBackAppBar(
          headerText: 'Tillegs informasjon',
          onBackClick: () => Navigator.of(context).pop()),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (_) => RegistrationStageTwoCubit(
              authenticationRepository: AuthenticationRepository(),
              email: email,
              password: password),
          child: Form(
              key: _formKey,
              child: BlocListener<RegistrationStageTwoCubit,
                  RegistrationStageTwoState>(
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                    const VerticalSpacer(height: 22),
                    _FirstNameInput(),
                    const VerticalSpacer(),
                    _LastNameInput(),
                    const VerticalSpacer(),
                    _PhoneInput(
                        onEditComplete: (BuildContext blocContext) =>
                            openAgePicker(blocContext)),
                    const VerticalSpacer(),
                    _AgeInput(
                        onOpenAgeInput: (BuildContext blocContext) =>
                            openAgePicker(blocContext)),
                    const VerticalSpacer(),
                    _AddressInput(),
                    const VerticalSpacer(),
                    _PostNumberInput(),
                    const VerticalSpacer(),
                    _SignUpButton()
                  ]),
                ),
              )),
        ),
      ),
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationStageTwoCubit, RegistrationStageTwoState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.next,
          key: const Key('signUpForm_firstName_textField'),
          onChanged: (firstName) => context
              .read<RegistrationStageTwoCubit>()
              .firstNameChange(firstName),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'Navn',
            labelStyle: Theme.of(context).primaryTextTheme.labelMedium,
            suffixIcon: SvgPicture.asset(
              'assets/icons/person_mini.svg',
              color: Colors.white,
              width: 16,
              height: 16,
            ),
            hintText: "Navn...",
            errorText: state.firstName.invalid ? 'invalid name' : null,
          ),
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationStageTwoCubit, RegistrationStageTwoState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.next,
          key: const Key('signUpForm_lastName_textField'),
          onChanged: (lastName) => context
              .read<RegistrationStageTwoCubit>()
              .lastNameChange(lastName),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'Etternavn',
            suffixIcon: SvgPicture.asset(
              'assets/icons/person_mini.svg',
              color: Colors.white,
              width: 16,
              height: 16,
            ),
            hintText: 'Etternavn...',
            labelStyle: Theme.of(context).primaryTextTheme.labelMedium,
            errorText: state.lastName.invalid ? 'invalid name' : null,
          ),
        );
      },
    );
  }
}

class _PhoneInput extends StatelessWidget {
  const _PhoneInput({required this.onEditComplete});

  final Function(BuildContext blocContext) onEditComplete;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationStageTwoCubit, RegistrationStageTwoState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.next,
          key: const Key('signUpForm_phone_textField'),
          onChanged: (phoneNumber) => context
              .read<RegistrationStageTwoCubit>()
              .phoneNumberChange(phoneNumber),
          onEditingComplete: () => onEditComplete(context),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Telefon-nummer',
            suffixIcon: SvgPicture.asset(
              'assets/icons/person_mini.svg',
              color: Colors.white,
              width: 16,
              height: 16,
            ),
            hintText: 'Telefon nummer...',
            labelStyle: Theme.of(context).primaryTextTheme.labelMedium,
            errorText:
                state.phoneNumber.invalid ? 'invalid phone number' : null,
          ),
        );
      },
    );
  }
}

class _AddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationStageTwoCubit, RegistrationStageTwoState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.next,
          key: const Key('signUpForm_address_textField'),
          onChanged: (address) =>
              context.read<RegistrationStageTwoCubit>().addressChange(address),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'Adresse',
            suffixIcon: SvgPicture.asset(
              'assets/icons/person_mini.svg',
              color: Colors.white,
              width: 16,
              height: 16,
            ),
            hintText: 'Adresse...',
            labelStyle: Theme.of(context).primaryTextTheme.labelMedium,
            errorText: state.address.invalid ? 'invalid address' : null,
          ),
        );
      },
    );
  }
}

class _PostNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationStageTwoCubit, RegistrationStageTwoState>(
      buildWhen: (previous, current) =>
          previous.postNumber != current.postNumber,
      builder: (context, state) {
        return TextField(
          textInputAction: TextInputAction.done,
          key: const Key('signUpForm_post_number_textField'),
          onChanged: (postNumber) => context
              .read<RegistrationStageTwoCubit>()
              .postNumberChange(postNumber),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'Post-nr',
            suffixIcon: SvgPicture.asset(
              'assets/icons/person_mini.svg',
              color: Colors.white,
              width: 16,
              height: 16,
            ),
            hintText: 'Postnummer...',
            labelStyle: Theme.of(context).primaryTextTheme.labelMedium,
            errorText: state.postNumber.invalid ? 'invalid post number' : null,
          ),
        );
      },
    );
  }
}

class _AgeInput extends StatelessWidget {
  const _AgeInput({Key? key, required this.onOpenAgeInput}) : super(key: key);
  final Function(BuildContext blocContext) onOpenAgeInput;

  String formatDate(DateTime date) {
    String datePattern = "dd/MM/yyyy";
    return DateFormat(datePattern).format(date);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationStageTwoCubit, RegistrationStageTwoState>(
      buildWhen: (previous, current) {
        return previous.age != current.age;
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => onOpenAgeInput(context),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  children: [
                    Text(
                        state.age == null
                            ? "Velg alder"
                            : formatDate(state.age!),
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xffB2B0B4),
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              Positioned(
                  left: 11,
                  top: -7,
                  child: Text("Alder",
                      style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).primaryColor))),
            ],
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  void unFocusTextField(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationStageTwoCubit, RegistrationStageTwoState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.isSubmissionInProgress) {
          return const LoadingIndicator();
        }
        return ElevatedButton(
          key: const Key('signUpForm_signUp_raisedButton'),
          onPressed: state.status.isValidated && state.age != null
              ? () {
                  unFocusTextField(context);
                  context
                      .read<RegistrationStageTwoCubit>()
                      .signUpFormSubmitted();
                }
              : null,
          child: const Text('SIGN UP'),
        );
      },
    );
  }
}
