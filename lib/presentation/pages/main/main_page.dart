import '../../blocs/bottom_nav/bottom_nav_cubit.dart';
import '../../constant/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppPages.titles[state]),
          ),
          body: AppPages.pages[state],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "favorite",
              ),
            ],
            currentIndex: state,
            onTap: (v) {
              context.read<BottomNavCubit>().changeIndex(v);
            },
          ),
        );
      },
    );
  }
}
