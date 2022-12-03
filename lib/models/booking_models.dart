import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  const Booking({
    required this.bookingId,
    required this.stationId,
    required this.stationName,
    required this.stationImage,
    required this.from,
    required this.to,
    required this.userId,
    required this.subject,
  });

  final String stationId;
  final String stationName;
  final String stationImage;

  final String subject;

  final DateTime from;

  final DateTime to;

  final String bookingId;

  final String userId;

  Booking copyWith({
    required String bookingId,
    required String stationId,
    required String stationName,
    required String stationImage,
    required DateTime from,
    required DateTime to,
    required String userId,
    required String subject,
    // required List<SegmentOfUser> lastThreeLikes,
  }) {
    return Booking(
      bookingId: bookingId,
      stationId: stationId,
      stationImage: stationImage,
      stationName: stationName,
      from: from,
      to: to,
      userId: userId,
      subject: subject,
    );
  }

  Booking.fromQueryDocumentSnapshot(DocumentSnapshot snapshot)
      : bookingId = snapshot.id,
        stationId = snapshot.get('stationId'),
        stationName = snapshot.get('stationName'),
        stationImage = snapshot.get('stationImage'),
        from = DateTime.fromMillisecondsSinceEpoch(
            (snapshot.get('from') as Timestamp).millisecondsSinceEpoch),
        to = DateTime.fromMillisecondsSinceEpoch(
            (snapshot.get('to') as Timestamp).millisecondsSinceEpoch),
        userId = snapshot.get('userId') as String,
        subject = snapshot.get('subject') as String;
}
