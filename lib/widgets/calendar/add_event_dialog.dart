import 'package:flutter/material.dart';
import 'package:stryn_esport/pages/calendar/calendar_utils.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AddEventDialogContent extends StatelessWidget {
  const AddEventDialogContent({
    Key? key,
    required this.markAsBusy,
    required this.details,
  }) : super(key: key);
  final bool markAsBusy;
  final CalendarTapDetails details;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          alignment: Alignment.topLeft,
          child: Text('New event at ${convertDateToText(details)}',
              style: const TextStyle(
                  fontSize: 18, letterSpacing: 0.5, color: Colors.white)),
        ),
      ],
    );
  }
}
