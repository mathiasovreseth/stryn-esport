import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stryn_esport/pages/settings/change_password.dart/change_password.dart';
import 'package:stryn_esport/pages/settings/edit_user_information.dart/edit_user_information.dart';
import 'package:stryn_esport/pages/settings/privacy_policy.dart';
import 'package:stryn_esport/pages/settings/terms_of_service.dart';
import 'package:stryn_esport/widgets/appBars/arrow_back_app_bar.dart';
import 'package:stryn_esport/widgets/buttons/my_text_button.dart';
import 'package:stryn_esport/widgets/spacer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SettingsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowBackAppBar(
          headerText: "Settings",
          onBackClick: () => Navigator.of(context).pop()),
      body: Column(children: const [
        VerticalSpacer(height: 22),
        _EditInformationButton( key: Key("edit-information-button"),),
        VerticalSpacer(
          height: 18,
        ),
        _ChangePasswordButton(key: Key("change-password-button")),
        VerticalSpacer(
          height: 18,
        ),
        _TermsOfserviceButton(key: Key("terms-of-service-button")),
        VerticalSpacer(
          height: 18,
        ),
        _PrivacyPolicyButton(key: Key("privacy-policy-button")),
      ]),
    );
  }
}

class _EditInformationButton extends StatelessWidget {
  const _EditInformationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTextButton(
                onPressed: () => Navigator.of(context)
                    .push(ChangeUserInformationPage.route()),
                child: Text("Rediger personalia",
                    style: Theme.of(context).textTheme.subtitle2)),
            Image.asset(
              'assets/icons/user.png',
              color: Theme.of(context).primaryColor,
              width: 24,
              height: 24,
            )
          ]),
    );
  }
}

class _ChangePasswordButton extends StatelessWidget {
  const _ChangePasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTextButton(
                onPressed: () =>
                    Navigator.of(context).push(ChangePasswordPage.route()),
                child: Text("Endre passord",
                    style: Theme.of(context).textTheme.subtitle2)),
            SvgPicture.asset(
              'assets/icons/lock_small.svg',
              color: Theme.of(context).primaryColor,
              width: 24,
              height: 24,
            )
          ]),
    );
  }
}

class _TermsOfserviceButton extends StatelessWidget {
  const _TermsOfserviceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTextButton(
                onPressed: () => Navigator.of(context).push(TermsOfService.route()),
                child: Text("Vilkår for bruk",
                    style: Theme.of(context).textTheme.subtitle2)),
            Image.asset(
              'assets/icons/document.png',
              color: Theme.of(context).primaryColor,
              width: 24,
              height: 24,
            )
          ]),
    );
  }
}

class _PrivacyPolicyButton extends StatelessWidget {
  const _PrivacyPolicyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTextButton(
                onPressed: () => Navigator.of(context).push(PrivacyPolicy.route()),
                child: Text("Personverns erklering",
                    style: Theme.of(context).textTheme.subtitle2)),
            Image.asset(
              'assets/icons/document.png',
              color: Theme.of(context).primaryColor,
              width: 24,
              height: 24,
            )
          ]),
    );
  }
}
