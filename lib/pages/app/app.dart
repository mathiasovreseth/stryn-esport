import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stryn_esport/pages/app/bloc/app_bloc.dart';
import 'package:stryn_esport/pages/app/bloc/app_state.dart';
import 'package:stryn_esport/pages/app/utils/app_utils.dart';
import 'package:stryn_esport/repositories/auth_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider<AppBloc>(
        create: (_) =>
            AppBloc(authenticationRepository: _authenticationRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromRGBO(24, 144, 255, 1),
        backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
        accentColor: const Color.fromRGBO(24, 144, 255, 1),
        unselectedWidgetColor: Colors.white,
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: const Color.fromRGBO(243, 243, 243, 1),
        buttonColor: const Color(0x00bc9546),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: const TextTheme(
          labelSmall:
              TextStyle(color: Color.fromRGBO(24, 144, 255, 1), fontSize: 12),
          labelMedium:
              TextStyle(color: Color.fromRGBO(24, 144, 255, 1), fontSize: 14),
          labelLarge:
              TextStyle(color: Color.fromRGBO(24, 144, 255, 1), fontSize: 16),
        ),
        fontFamily: GoogleFonts.manrope().fontFamily,
        textTheme: const TextTheme(
          subtitle1: TextStyle(color: Colors.black),
          headline5:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(color: Colors.black),
        ).apply(
          bodyColor: Colors.black,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Colors.white,
            ),
            primary: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            enabledBorder: const OutlineInputBorder(
                //Outline border type for TextFeild
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                )),
            filled: true,
            hintStyle:
                TextStyle(color: Colors.black.withOpacity(0.35), fontSize: 14)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).accentColor,
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              onSurface: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}



//   ThemeData(
//     // Define the default brightness and colors.
//       brightness: Brightness.dark,
//       primaryColor: const Color.fromRGBO(24, 144, 255, 1),
//       fontFamily: 'Georgia',
//       scaffoldBackgroundColor: const Color.fromRGBO(243, 243, 243, 1),
//       backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
//       // Define the default `TextTheme`. Use this to specify the default
//       // text styling for headlines, titles, bodies of text, and more.
//       textTheme: const TextTheme(
//           headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//           headline2: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           bodyText2: TextStyle(fontSize: 16.0, color: Color.fromRGBO(0, 0, 0, .85)),
//           labelMedium: TextStyle(fontSize: 16.0, color: Color.fromRGBO(24, 144, 255, 1))
//       ),
//       textButtonTheme:  TextButtonThemeData(
//           style: TextButton.styleFrom(
//             padding: EdgeInsets.zero,
//             minimumSize: Size.zero,
//             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             animationDuration: const Duration(seconds: 5),
//             textStyle: const TextStyle(color: Colors.white, fontSize: 16),
//           )
//       )
//   )