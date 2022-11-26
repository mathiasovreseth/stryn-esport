import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stryn_esport/models/user_model.dart';
import 'package:stryn_esport/pages/app/bloc/app_bloc.dart';
import 'package:stryn_esport/pages/app/bloc/app_state.dart';
import 'package:stryn_esport/pages/porfilePage/bloc/profile_cubit.dart';
import 'package:stryn_esport/pages/porfilePage/bloc/profile_state.dart';
import 'package:stryn_esport/pages/settings/settings_page.dart';
import 'package:stryn_esport/repositories/firebase_calendar_repository.dart';
import 'package:stryn_esport/widgets/images/cache_image_container.dart';
import 'package:stryn_esport/widgets/loading_indicator.dart';
import 'package:stryn_esport/widgets/spacer.dart';

import '../../models/booking_models.dart';



class ProfilePage extends StatelessWidget {
   ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfff3f3f3),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => {
                  Navigator.of(context).push(SettingsPage.route())
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ))
          ],
          centerTitle: true,
          title: const Text(
            "Min Profil",
            style: TextStyle(color: Colors.black),
          )),
      body: BlocProvider(
        create: (BuildContext context) => ProfileCubit(
            FirebaseCalendarRepository(),
            context.read<AppBloc>().state.user,
            ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 50, bottom: 12),
        child: ListView(
          children: [
            _UserTitleImage(),
            const VerticalSpacer(
              height: 20,
            ),
            BlocBuilder<AppBloc, AppState>(
              buildWhen: (previous, current) => previous.user != current.user,
              builder: (context, state){
                if(state.user.hasMembership != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      state.user.hasMembership!
                          ? _bookings()
                          : _becomeMemberInfo()
                    ],
                  );}
                return _becomeMemberInfo();
              },
            ),
          ],
        ));
  }

  final List<String> bulletListAdvantages = [
    "Tilgang til aktiviteter i alle våre klubber",
    "Spille på våre maskinparker",
    "Medlemsrabatt på klubbstore",
    "Medlemsrabatt på arrangementer",
    "Medlemsrabatt på utstyr og tilbehør",
    "Tilgang til Stryn e-sport sin Discord"
  ];
  Widget _becomeMemberInfo() {
    return Column(children: [
      const Text(
        "Bli medlem",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
        margin: const EdgeInsets.only(top: 16),
        child: Column(children: <Widget>[
          const Text("Fordeler", style: TextStyle(color: Colors.black, fontSize: 20)),
          for (String string in bulletListAdvantages)
            _createBulletListItem(string)
        ]),
      )
    ]);
  }

  Widget _createBulletListItem(String string) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            const Text('\u2022',
                style: TextStyle(color: Colors.black, fontSize: 20)),
            const SizedBox(
              width: 5,
            ),
            Text(string, style: const TextStyle(color: Colors.black, fontSize: 16))
          ],
        ));
  }

  Widget _bookings() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (prev, next) => prev.myEvents.length != next.myEvents.length,
      builder: (context, state) {
        if(state.status == ProfileStatus.success) {
          if(state.myEvents.isEmpty) {
            return _emptyBookings();
          } else {
            return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Mine bookings",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const VerticalSpacer(
                    height: 20,
                  ),
                  for (Booking booking in state.myEvents) _bookedItem(booking)
                ]);

          }
        }
        if(state.status == ProfileStatus.loading) {
          return const LoadingIndicator();
        }
        return Container();
      },

    );
  }
   Widget _emptyBookings() {
     return Container(
       height: 100,
       padding: const EdgeInsets.only(top: 16),
       width: double.infinity,
       decoration: const BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.all(Radius.circular(10))),
       margin: const EdgeInsets.only(top: 16),
       alignment: Alignment.center,
       child: Column(
         children: [
           Text("Mine bookings", style: TextStyle(color: Colors.black.withOpacity(0.85), fontSize: 16, fontWeight: FontWeight.bold),),
           const VerticalSpacer(height: 16,),
           Text("Du har ingen reservasjoner for øyeblikket", style: TextStyle(color: Colors.black.withOpacity(0.85), fontSize: 14),)
         ],
       ),
     );
   }

   Widget _bookedItem(Booking booking) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 4, bottom: 4),
            child: Column(
              //left section
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Station:  ${booking.stationName}",
                  style: TextStyle(color: Colors.black.withOpacity(0.85)),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Date:  ${DateFormat.yMMMd().format(booking.from)}",
                  style: TextStyle(color: Colors.black.withOpacity(0.85)),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Time:     ${booking.from.hour} - ${booking.to.hour}",
                  style: TextStyle(color: Colors.black.withOpacity(0.85)),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
     CustomPaint(
     painter: BoxShadowPainter(),
     child: ClipPath(
            clipper: _ImagePath(),
            child: CachedNetworkImageContainer(
              imageUrl: booking.stationImage,
            ),
          ),
          ),
        ],
      ),
    );
  }
}

class _UserTitleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 60),
          height: 180,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.white),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: BlocBuilder<AppBloc, AppState>(
            buildWhen: (previous, current) => previous.user != current.user,
            builder: (context, state) {
              MyUser user = state.user;
              if(user.firstName != null && user.lastName != null && user.hasMembership != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const VerticalSpacer(
                    height: 80,
                  ),
                  Text(
                    "${state.user.firstName!} ${state.user.lastName!}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const VerticalSpacer(
                    height: 10,
                  ),
                  Text(
                    state.user.hasMembership! ? "Er medlem" : "Er ikke medlem",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              );}
              return const Text("Couldn't load user data");
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Image.asset('assets/images/logo.png')),
        ),
      ],
    );
  }
}

class _ImagePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.moveTo(w / 5, 0); // sets start point
    path.lineTo(0, h); //pint 2
    path.lineTo(w, h); //point 3
    path.lineTo(w, 0); // point 4
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BoxShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.moveTo((w/5-5), 0); // sets start point
    path.lineTo(-5, h); //pint 2
    path.lineTo(w, h); //point 3
    path.lineTo(w, 0);


    canvas.drawShadow(path, Colors.black,3 , false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
