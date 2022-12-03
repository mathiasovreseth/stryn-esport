import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stryn_esport/pages/app/bloc/app_event.dart';

import '../app/bloc/app_bloc.dart';
import '../navigationPage/navigation_page.dart';

///Home page of the app
///Loads user information and redirects to landing page
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    context.read<AppBloc>().add(const LoadUserInfo());
    return const NavigationPage();
  }
}
