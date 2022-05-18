import '../../../injection/src/externals.dart';
import '../../widgets/home_item.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/routes.dart';
import '../../../data/data_source/local/preferences_local_data_source.dart';
import '../../../domain/entities/beers.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: FutureBuilder<List<Beers>>(
          future: getIt<PreferencesLocalDataSource>().favorites,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    "Empty",
                    style: TextStyle(fontSize: 30),
                  ),
                );
              }
              return GridView.builder(
                itemBuilder: (context, index) {
                  Beers beers = snapshot.data![index];
                  return HomeItem(
                    item: beers,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.homeDetails,
                        arguments: beers,
                      );
                    },
                    isVisible: false,
                  );
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: width / 2 - 15,
                  mainAxisExtent: 300,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: snapshot.data!.length,
              );
            }
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }),
    );
  }
}
