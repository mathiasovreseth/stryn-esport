import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stryn_esport/models/station_model.dart';
import 'package:provider/provider.dart';
import 'package:stryn_esport/pages/bookingPage/bloc/station_cubit.dart';
import 'package:stryn_esport/pages/bookingPage/bloc/station_state.dart';
import 'package:stryn_esport/pages/loginPage/bloc/login_cubit.dart';
import 'package:stryn_esport/widgets/loading_indicator.dart';
import '../../services/database.dart';
import '../../widgets/appBars/custom_app_bar.dart';

class BookingPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => BookingPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StationCubit(FirestoreDatabase()),
      child: Scaffold(
        appBar: const CustomAppBar(
          headerText: 'Book stasjoner',
        ),
        body: _buildContents(context),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    return BlocBuilder<StationCubit, StationsState>(
      builder: (context, state) {
        if (state.status == Status.success) {
          final stations = state.stations;
          final children = stations.map((station) => Text(station.name)).toList();
          return ListView(children: children);
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }
}
