import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stryn_esport/pages/app/bloc/app_bloc.dart';
import 'package:stryn_esport/pages/app/bloc/app_state.dart';
import 'package:stryn_esport/widgets/spacer.dart';

import '../../models/booking_models.dart';
import '../loginPage/bloc/login_cubit.dart';
import '../loginPage/bloc/login_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Booking> bookings = [];
  @override
  void initState() {
    for (int i = 0; i < 5; i++) {
      bookings.add(Booking(
          bookingId: "1",
          stationId: "12",
          from: DateTime.now(),
          to: DateTime.now().add(const Duration(days: 5)),
          userId: "2"));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfff3f3f3),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                ))
          ],
          centerTitle: true,
          title: const Text(
            "Min Profil",
            style: TextStyle(color: Colors.black),
          )),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 50),
        child: ListView(
          children: [
            _UserTitleImage(),
            const VerticalSpacer(
              height: 20,
            ),
            BlocBuilder<AppBloc, AppState>(
              buildWhen: (previous, current) => previous.user != current.user,
              builder: (context, state){
                if(state.user.hasMembership != null){
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
            )
          ],
        ));
  }

  final List<String> bulletListAdvantages = [
    "Tilgang til aktiviteter i alle våre klubber",
    "Spille på våre maskinparker",
    "Medlemsrabatt på klubbstore (Kommer snart)",
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
            Text(string, style: TextStyle(color: Colors.black, fontSize: 16))
          ],
        ));
  }

  Widget _bookings() {
    return Column(children: [
      const Text(
        "Mine bookings",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      const VerticalSpacer(
        height: 20,
      ),
      for (Booking booking in bookings) _bookedItem(booking)
    ]);
  }

  Widget _bookedItem(Booking booking) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 4, bottom: 4),
            child: Column(
              //left section
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stasjon  ${booking.stationId}",
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Dato:    ${DateFormat.yMMMd().format(booking.from)}",
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Tid:     ${booking.from.hour} - ${booking.to.hour}",
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          ClipPath(
            clipper: _ImagePath(),
            child: Container(
              //Image
              height: 60,
              width: 169,
              color: Colors.brown,
              //TODO: insert image of station
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
              if(state.user.firstName != null){
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
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
