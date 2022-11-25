
import 'package:cloud_firestore/cloud_firestore.dart';
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
      "from": from,
      "to": to,
      "subject": subject
    });

    CollectionReference userRef = FirebaseFirestore.instance.collection('users').doc(userId).collection('events');
    await userRef.doc(docRef.id).set({
      "eventId": docRef.id
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
        .where('to', isGreaterThan: Timestamp.fromDate(getDateMorningToday()))
        .snapshots()
        .map((event) {
      return event.docs.map((e)  {
        return Booking.fromQueryDocumentSnapshot(e);
      }).toList();
    });

  }

  @override
  Stream<List<Booking>> getMyEvents(String userId)  {
    return FirebaseFirestore.instance.collection('events')
        .where('userId', isEqualTo: userId)
        .where('to', isGreaterThan: Timestamp.now())
        .snapshots()
        .map((event) {
      return event.docs.map((e)  {
        return Booking.fromQueryDocumentSnapshot(e);
      }).toList();
    });

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

}