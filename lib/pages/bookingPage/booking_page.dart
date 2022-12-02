import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stryn_esport/pages/app/bloc/app_bloc.dart';
import 'package:stryn_esport/pages/becomeMemberPage/become_member_page.dart';
import 'package:stryn_esport/pages/bookingPage/bloc/station_cubit.dart';
import 'package:stryn_esport/pages/bookingPage/bloc/station_state.dart';
import 'package:stryn_esport/repositories/firebase_station_repository.dart';
import 'package:stryn_esport/widgets/loading_indicator.dart';
import '../../widgets/appBars/custom_app_bar.dart';
import '../../widgets/station_card.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const BookingPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool? isMember = context.read<AppBloc>().state.user.hasMembership;

    return isMember! ? _bookingPage(context) : const BecomeMemberPage();
  }

  Widget _bookingPage(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StationCubit(FirebaseStationRepository()),
      child: Scaffold(
        appBar: const CustomAppBar(
          headerText: 'Book Stations',
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: _buildContents(context),
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    return BlocBuilder<StationCubit, StationsState>(
      builder: (context, state) {
        if (state.status == Status.success) {
          final stations = state.stations;
          return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              children: [
                for (final child in stations) StationCard(station: child)
              ]);
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }
}
