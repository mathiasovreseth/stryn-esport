

class Booking {

  const Booking({
    required this.bookingId,
    required this.stationId,
    required this.from,
    required this.to,
    required this.userId,
  });

  final String stationId;

  final DateTime from;

  final DateTime to;

  final String bookingId;

  final String userId;

}