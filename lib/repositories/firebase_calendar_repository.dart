
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stryn_esport/models/booking_models.dart';
import 'package:stryn_esport/models/station_model.dart';

import 'package:stryn_esport/repositories/calendar_repository.dart';

class FirebaseCalendarRepository extends CalendarRepository {

  @override
  Future<void> addEvent(Station station, DateTime from, DateTime to, String userId, String subject) async {
    CollectionReference bookingRef = FirebaseFirestore.instance.collection('computerStations')
        .doc(station.id)
        .collection('events');
    DocumentReference docRef = await bookingRef.add({
      "userId": userId,
      "stationId": station.id,
      "stationName": station.name,
      "stationImage": station.image,
      "from": from,
      "to": to,
      "subject": subject
    });

    CollectionReference userRef = FirebaseFirestore.instance.collection('users').doc(userId).collection('events');
    await userRef.doc(docRef.id).set({
      "eventRef": FirebaseFirestore.instance.doc('computerStations/${station.id}/events/${docRef.id}'),
      "to": to,
      "from": from,
    });
  }
  // min date for events to be fetched
  DateTime getDateMorningToday() {
    DateTime dateNow = DateTime.now();
    return DateTime(dateNow.year, dateNow.month, dateNow.day, 8, 0);
  }


  @override
  Stream<List<Booking>> getEvents(String stationId) {
    return FirebaseFirestore.instance.collection('computerStations')
        .doc(stationId)
        .collection('events')
        .where('from', isGreaterThan: Timestamp.fromDate(getDateMorningToday()))
        .snapshots()
        .map((event) {
      return event.docs.map((e)  {
        return Booking.fromQueryDocumentSnapshot(e);
      }).toList();
    });

  }

  @override
  Stream<List<Booking>> getMyEvents(String userId)  {
    return FirebaseFirestore.instance.collection('users')
        .doc(userId)
        .collection('events')
        .where('from', isGreaterThan: Timestamp.fromDate(getDateMorningToday()))
        .orderBy('from', descending: false)
        .snapshots()
        .asyncMap((event) => _getEventsFromSnapshot(event));

  }

  Future<List<Booking>> _getEventsFromSnapshot(QuerySnapshot snapshot) async {
    final futures = snapshot.docs.map((doc) async {
      DocumentReference ref = doc.get('eventRef');
      DocumentSnapshot snapshot = await ref.get();
      return Booking.fromQueryDocumentSnapshot(snapshot);
    });
    return Future.wait(futures);
  }


  @override
  Future<void> removeEvent(Station station, Booking booking, String userId) async {
    CollectionReference bookingRef = FirebaseFirestore.instance.collection('computerStations')
        .doc(station.id)
        .collection('events');
    await bookingRef.doc(booking.bookingId).delete();
    await FirebaseFirestore
        .instance
        .collection('users')
        .doc(userId)
        .collection('events')
        .doc(booking.bookingId)
        .delete();
  }

  DateTime getMorningOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 8, 0);
  }
  DateTime getEndOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 24, 0);
  }

  /// fetch bookings for a day
  @override
  Future<List<Booking>> getMyEventsByDay(String userId, String stationId, DateTime dayToCheck) async {
    QuerySnapshot bookings = await FirebaseFirestore.instance.collection('computerStations')
        .doc(stationId)
        .collection('events')
        .where('userId', isEqualTo: userId)
        .where('to', isGreaterThanOrEqualTo: Timestamp.fromDate(getMorningOfDay(dayToCheck)), isLessThanOrEqualTo: Timestamp.fromDate(getEndOfDay(dayToCheck)))
        .get();
    return bookings.docs.map((e)  {
        return Booking.fromQueryDocumentSnapshot(e);
      }).toList();

  }

}