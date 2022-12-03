import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

String convertDateToText(CalendarTapDetails details) {
  DateTime date = details.date!;
  String dateString = DateFormat('dd/MM/yy').format(date);
  dateString += " ${date.hour}:00 - ${date.hour + 2}:00";
  return dateString;
}

void showNotOwnerSnackBar(BuildContext context) {
  final SnackBar snackBar = SnackBar(
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.red.shade900,
    content: const Text(
      'Du har ikke tillatelse til å fjerne bookingen',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showToManyBookingsSnackBar(BuildContext context) {
  final SnackBar snackBar = SnackBar(
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.red.shade900,
    content: const Text(
      'Du har for mange bookings, max 2 per dag!',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showBookingRemovedSnackBar(BuildContext context) {
  final SnackBar snackBar = SnackBar(
    duration: const Duration(seconds: 1),
    backgroundColor: Theme.of(context).primaryColor,
    content: const Text(
      'Booking fjernet',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showBookingAddedSnackBar(BuildContext context) {
  final SnackBar snackBar = SnackBar(
    duration: const Duration(seconds: 1),
    backgroundColor: Theme.of(context).primaryColor,
    content: const Text(
      'Booking lagt til',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showBookingErrorSnackBar(BuildContext context) {
  final SnackBar snackBar = SnackBar(
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.red.shade900,
    content: const Text(
      'Error, booking ikkje lagt til',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
