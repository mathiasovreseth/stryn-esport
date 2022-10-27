import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/booking_models.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Booking> bookings = [];
  @override
  void initState() {
    for (int i = 0; i < 5; i++) {
      bookings.add(Booking(bookingId: "1", stationId:"12", from: DateTime.now(), to: DateTime.now().add(const Duration(days:5)), userId: "2"));
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfff3f3f3),
        elevation: 0,
        actions: [IconButton(onPressed: ()=>{}, icon: const Icon(Icons.more_horiz, color: Colors.black,))],
        centerTitle: true,
        title: const Text("Min Profil", style: TextStyle(color: Colors.black),)),
        body: _buildContent() ,
      backgroundColor: const Color(0xfff3f3f3),
    );
  }

  Widget _buildContent() {
    return Padding(padding: const EdgeInsets.only(left: 24, right: 24, top: 50),
      child: ListView(
        children: [
          Container(
            height: 150,
            color: Colors.cyan,
            child: const Text("temp! insert ProfileInfo widget"),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              const Text("Mine bookings"),
              for (Booking booking in bookings)
                _bookedItem(booking)
            ],
          )
        ],
      )
    );
  }

  Widget _bookedItem(Booking booking) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
      ),
      margin: const EdgeInsets.only(top: 16 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 24,top:4, bottom: 4),
            child: Column( //left section
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Stasjon  ${booking.stationId}", textAlign: TextAlign.left,),
                Text("Dato:    ${DateFormat.yMMMd().format(booking.from)}", textAlign: TextAlign.left,),
                Text("Tid:     ${booking.from.hour} - ${booking.to.hour}", textAlign: TextAlign.left,),
              ],
            ),
          ),
          ClipPath(
            clipper: ImagePath(),
            child: Container( //Image
              height: 60,
              width: 169,
              color: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.moveTo(w/5, 0); // sets start point
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