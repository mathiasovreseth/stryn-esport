import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stryn_esport/models/booking_models.dart';

/// The app which hosts the home page which contains the calendar on it.

import 'package:stryn_esport/models/station_model.dart';
import 'package:stryn_esport/models/user_model.dart';
import 'package:stryn_esport/pages/app/bloc/app_bloc.dart';
import 'package:stryn_esport/pages/calendar/bloc/calendar_cubit.dart';
import 'package:stryn_esport/pages/calendar/bloc/calendar_state.dart';
import 'package:stryn_esport/pages/calendar/calendar_utils.dart';
import 'package:stryn_esport/repositories/firebase_calendar_repository.dart';

import 'package:stryn_esport/widgets/appBars/arrow_back_app_bar.dart';
import 'package:stryn_esport/widgets/loading_indicator.dart';
import 'package:stryn_esport/widgets/spacer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({
    Key? key,
    required this.station,
  }) : super(key: key);

  // Id of the user that owns the profile
  final Station station;

  static Route route({required Station station}) {
    return MaterialPageRoute<void>(
      builder: (_) => CalendarPage(station: station),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: ArrowBackAppBar(
                headerText: station.name,
                onBackClick: () => Navigator.of(context).pop()),
          ),
          body: BlocProvider(
            create: (BuildContext context) => CalendarCubit(
                FirebaseCalendarRepository(),
                context.read<AppBloc>().state.user,
                station.id),
            child: BlocBuilder<CalendarCubit, CalendarState>(
              builder: (context, state) {
                if (state.status == CalendarStatus.success) {
                  final events = state.events;
                  return _Calendar(station: station, events: events);
                } else {
                  return const LoadingIndicator();
                }
              },
            ),
          )),
    );
  }
}

class _Calendar extends StatefulWidget {
  const _Calendar({
    Key? key,
    required this.station,
    required this.events,
  }) : super(key: key);

  // Id of the user that owns the profile
  final Station station;
  final List<Booking> events;

  @override
  State<_Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<_Calendar> {
  final CalendarController _calendarController = CalendarController();
  final DateTime _minDate = DateTime.now(),
      _maxDate = DateTime.now().add(const Duration(days: 365 ~/ 2));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _getCalendar(
          _calendarController,
          MeetingDataSource(widget.events),
          _minDate,
          _maxDate,
          context,
          widget.station),
    );
  }
}

SfCalendar _getCalendar([
  CalendarController? calendarController,
  CalendarDataSource? calendarDataSource,
  DateTime? minDate,
  DateTime? maxDate,
  BuildContext? context,
  Station? station,
]) {
  Future<void> _onCalendarTap(
      BuildContext cubitContext, CalendarTapDetails details) async {
    Booking? booking = details.appointments?.first;
    if(booking != null) {
      String userId = cubitContext.read<AppBloc>().state.user.id;
        if(booking.userId == userId) {
          return showDialog<void>(
            context: cubitContext,
            barrierDismissible: false, // user must tap button!
            builder: (context) => _addRemoveEventDialogContent(cubitContext, context, details, station!),
          );
        } else {
          showNotOwnerSnackBar(cubitContext);
        }
    } else {
      bool canAddMoreBookings = await cubitContext.read<CalendarCubit>().checkNrOfEventsInADay(station!, details.date!);
      if(canAddMoreBookings) {
        return showDialog<void>(
          context: cubitContext,
          barrierDismissible: false, // user must tap button!
          builder: (context) =>
              _addNewEventDialogContent(cubitContext, context, details, station),
        );
      } else {
        showToManyBookingsSnackBar(cubitContext);
      }

    }
  }

  return SfCalendar(
    controller: calendarController,
    dataSource: calendarDataSource,
    onTap: (CalendarTapDetails details) =>
        _onCalendarTap(context!, details),
    view: CalendarView.week,
    headerStyle: CalendarHeaderStyle(
        textStyle:
            TextStyle(color: Colors.black.withOpacity(0.85), fontSize: 18),
        textAlign: TextAlign.start),
    cellBorderColor: Colors.black.withOpacity(0.6),
    viewHeaderStyle: ViewHeaderStyle(
        dateTextStyle: TextStyle(color: Colors.black.withOpacity(0.85)),
        dayTextStyle: TextStyle(color: Colors.black.withOpacity(0.85))),
    blackoutDatesTextStyle: const TextStyle(
        decoration: TextDecoration.lineThrough, color: Colors.red),
    minDate: minDate,
    cellEndPadding: 0,
    appointmentBuilder: appointmentBuilder,
    maxDate: maxDate,
    firstDayOfWeek: 1,
    timeSlotViewSettings: TimeSlotViewSettings(
        numberOfDaysInView: 7,
        timeIntervalHeight: 60,
        timeInterval: const Duration(hours: 2),
        dayFormat: 'EE',
        dateFormat: 'dd',
        timeFormat: 'HH:mm',
        timeTextStyle: TextStyle(color: Colors.black.withOpacity(0.85)),
        timelineAppointmentHeight: -1,
        timeRulerSize: 62,
        startHour: 8),
  );
}

AlertDialog _addNewEventDialogContent(BuildContext context, BuildContext dialogContext, CalendarTapDetails details, Station station) {

  Future<void> onConfirm() async {
    Navigator.of(dialogContext).pop();
    bool success = await context
        .read<CalendarCubit>()
        .addEvent(station, details.date!);
    if(success) {
        showBookingAddedSnackBar(context);
    } else {
       showBookingErrorSnackBar(context);
    }
  }
  return AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: Container(
      padding: const EdgeInsets.only(top: 22),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              "Do you want to book station 1 the\n${convertDateToText(details)}",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.85), fontSize: 14)),
          const VerticalSpacer(),
          Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 6),
            decoration: BoxDecoration(
              border:
                  Border.all(width: .5, color: Colors.black.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: Text(
                      "Avbryt",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.85),
                          fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: onConfirm,
                    child: const Text("Bekreft")),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

AlertDialog _addRemoveEventDialogContent(
    BuildContext context, BuildContext dialogContext, CalendarTapDetails details, Station station) {
  Future<void> onRemove() async {
    Navigator.of(dialogContext).pop();
    bool success = await context
        .read<CalendarCubit>()
        .removeEvent(station, details.appointments!.first! as Booking);
    if(success) {
      showBookingRemovedSnackBar(context);
    } else {
      showBookingErrorSnackBar(context);
    }
  }

  return AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: Container(
      padding: const EdgeInsets.only(top: 22),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              "Vil du fjerne booking på ${station.name} den \n${convertDateToText(details)}",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.85), fontSize: 14)),
          const VerticalSpacer(),
          Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 6),
            decoration: BoxDecoration(
              border:
              Border.all(width: .5, color: Colors.black.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: Text(
                      "Avbryt",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.85),
                          fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: onRemove,
                    child: const Text("Fjern")),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


Widget appointmentBuilder(BuildContext context,
    CalendarAppointmentDetails calendarAppointmentDetails) {
  final Booking appointment = calendarAppointmentDetails.appointments.first;
  return Container(
    color: Theme.of(context).primaryColor,
    child: Column(
      children: [
        SizedBox(
            width: calendarAppointmentDetails.bounds.width,
            height: calendarAppointmentDetails.bounds.height / 2,
            child: Center(
              child: Icon(
                Icons.person,
                size: 16,
                color: Colors.white.withOpacity(0.9),
              ),
            )),
        SizedBox(
          width: calendarAppointmentDetails.bounds.width,
          height: calendarAppointmentDetails.bounds.height / 2,
          child: Text(
            appointment.subject,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          ),
        )
      ],
    ),
  );
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Booking> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  bool isAllDay(int index) {
    return false;
    // return _getMeetingData(index).isAllDay;
  }

  Booking _getMeetingData(int index) {
    final Booking meeting = appointments![index];
    late final Booking meetingData;
    if (meeting is Booking) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
