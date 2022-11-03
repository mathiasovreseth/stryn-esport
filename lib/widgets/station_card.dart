import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stryn_esport/models/station_model.dart';

class StationCard extends StatelessWidget {
  const StationCard({Key? key, required this.station}) : super(key: key);

  final Station station;

  @override
  Widget build(BuildContext context) {
   return Card(
     clipBehavior: Clip.hardEdge,
     child: InkWell(
       splashColor: Colors.blue.withAlpha(30),
       onTap: () {
         debugPrint('Card tapped.');
       },
       child: SizedBox(
         width: 300,
         height: 100,
         child: Text(station.name),
       ),
     ),
   );
  }
}