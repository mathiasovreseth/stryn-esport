import 'package:flutter/material.dart';
import 'package:stryn_esport/pages/app/bloc/app_state.dart';
import 'package:stryn_esport/pages/homePage/home_page.dart';
import 'package:stryn_esport/pages/loginPage/LoginForm.dart';

/// The flow state will be the state which drives the flow.
/// Each time this state changes, a new navigation stack will be generated based on the new flow state.
List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
