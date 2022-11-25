import 'package:flutter/material.dart';
import 'package:stryn_esport/models/station_model.dart';
import 'package:stryn_esport/pages/calendar/calendar_page.dart';

class StationCard extends StatelessWidget {
  const StationCard({Key? key, required this.station}) : super(key: key);

  final Station station;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        splashColor: Colors.black.withAlpha(80),
        onTap: () => Navigator.of(context).push(CalendarPage.route(station: station)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.35), BlendMode.darken),
              child: Image.network(
                station.image,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              station.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
