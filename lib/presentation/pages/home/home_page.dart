import '../../../core/bloc/pagination_state.dart';
import '../../blocs/beers/beers_cubit.dart';
import '../../widgets/home_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/routes.dart';
import '../../../domain/entities/beers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: BlocBuilder<BeersCubit, PaginationState<List<Beers>, String>>(
        builder: (context, state) {
          if (state.isInProgress) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          } else if (state.isFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 60,
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Error",
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
            );
          } else if (state.isSuccess) {
            if (state.isEmpty) {
              return const Center(
                child: Text(
                  "Empty",
                  style: TextStyle(fontSize: 30),
                ),
              );
            }
            return CustomScrollView(
              controller: scrollController
                ..addListener(() async {
                  if (scrollController.offset >=
                      scrollController.position.maxScrollExtent) {
                    await context.read<BeersCubit>().fetchBeersPagination();
                  }
                }),
              slivers: [
                SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    Beers beers = state.data![index];
                    return HomeItem(
                      item: beers,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.homeDetails,
                          arguments: beers,
                        );
                      },
                    );
                  }, childCount: state.data!.length),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: width / 2 - 15,
                    mainAxisExtent: 300,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
                if (!state.hasReachedToEnd)
                  SliverToBoxAdapter(
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            spreadRadius: -10,
                            blurRadius: 24,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CupertinoActivityIndicator(
                            radius: 15,
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
