




import 'package:stryn_esport/models/booking_models.dart';
import 'package:stryn_esport/models/station_model.dart';

abstract class CalendarRepository {
  Stream<List<Booking>> getEvents(String stationId);
  Stream<List<Booking>> getMyEvents(String userId);
  Future<void> addEvent(Station station, DateTime from, DateTime to, String userId, String subject);
  Future<void> removeEvent(Station station, Booking booking, String userId);
}