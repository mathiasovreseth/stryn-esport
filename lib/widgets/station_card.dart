import 'package:flutter/material.dart';
import 'package:stryn_esport/models/station_model.dart';

class StationCard extends StatelessWidget {
  const StationCard({Key? key, required this.station}) : super(key: key);

  final Station station;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        splashColor: Colors.black.withAlpha(80),
        onTap: () {
          debugPrint("test");
        },
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.35), BlendMode.darken),
          child: Image.network(
            station.image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
