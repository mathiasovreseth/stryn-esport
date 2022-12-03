import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stryn_esport/pages/store/bloc/store_state.dart';
import 'package:stryn_esport/repositories/firebase_store_repository.dart';
import 'package:stryn_esport/widgets/appBars/custom_app_bar.dart';

import '../../widgets/loading_indicator.dart';
import '../../widgets/store_item_card.dart';
import 'bloc/store_cubit.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StoreCubit(FirebaseStoreRepository()),
      child: Scaffold(
        appBar: const CustomAppBar(headerText: 'Store'),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: _buildContents(context),
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    return BlocBuilder<StoreCubit, StoreState>(
      builder: (context, state) {
        if (state.status == Status.success) {
          final items = state.items;
          return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              children: [
                for (final child in items) StoreItemCard(item: child)
              ]);
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }
}
