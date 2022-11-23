import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../bookingPage/booking_page.dart';
import 'package:stryn_esport/pages/settings/settings_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stryn_esport/pages/app/bloc/app_event.dart';
import 'package:stryn_esport/pages/porfilePage/profile_page.dart';

import '../app/bloc/app_bloc.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    context.read<AppBloc>().add(LoadUserInfo());
    return ProfilePage();
  }
  
}
