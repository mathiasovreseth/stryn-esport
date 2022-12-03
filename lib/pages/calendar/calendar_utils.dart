import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// Converts a date to a more readable text
String convertDateToText(CalendarTapDetails details) {
  DateTime date = details.date!;
  String dateString = DateFormat('dd/MM/yy').format(date);
  dateString += " ${date.hour}:00 - ${date.hour + 2}:00";
  return dateString;
}

// Show a snackbar if a user taps an event that they have not created
void showNotOwnerSnackBar(BuildContext context) {
  final SnackBar snackBar = SnackBar(
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.red.shade900,
    content: const Text(
      'You do not have the permission to remove this booking',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// shows a snack bar if the user has > 2 bookings on a particular day.
void showToManyBookingsSnackBar(BuildContext context) {
  final SnackBar snackBar = SnackBar(
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.red.shade900,
    content: const Text(
      'Too many bookings, max 2 are allowed in a day',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// Confirmation message when removing a booking
void showBookingRemovedSnackBar(BuildContext context) {
  final SnackBar snackBar = SnackBar(
    duration: const Duration(seconds: 1),
    backgroundColor: Theme.of(context).primaryColor,
    content: const Text(
      'Booking removed',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// Confirmation message that a booking was added
void showBookingAddedSnackBar(BuildContext context) {
  final SnackBar snackBar = SnackBar(
    duration: const Duration(seconds: 1),
    backgroundColor: Theme.of(context).primaryColor,
    content: const Text(
      'Booking added',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// Shows an error message if an error occured creating a booking
void showBookingErrorSnackBar(BuildContext context) {
  final SnackBar snackBar = SnackBar(
    duration: const Duration(seconds: 3),
    backgroundColor: Colors.red.shade900,
    content: const Text(
      'Error, booking not added',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
