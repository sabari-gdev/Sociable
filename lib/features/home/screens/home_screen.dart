import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociable/core/utils/theme/colors.dart';
import 'package:sociable/features/alerts/screens/alerts_screen.dart';
import 'package:sociable/features/chats/screens/chat_screen.dart';
import 'package:sociable/features/posts/screens/feed_screen.dart';
import 'package:sociable/features/home/cubit/home_cubit.dart';
import 'package:sociable/features/profile/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Page<void> page() => const MaterialPage<void>(
        child: HomeScreen(),
      );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      lazy: false,
      child: _HomeNavigationView(),
    );
  }
}

class _HomeNavigationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int selectedTabIndex =
        context.select((HomeCubit homeCubit) => homeCubit.state.tabIndex);
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedTabIndex,
          children: const [
            FeedScreen(),
            ChatScreen(),
            AlertsScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTabIndex,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: "Feed",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.message),
            icon: Icon(Icons.message_outlined),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.notifications),
            icon: Icon(Icons.notifications_outlined),
            label: "Alerts",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
        onTap: (value) {
          context.read<HomeCubit>().setTab(value);
        },
        selectedItemColor: kPinkColor,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPinkColor,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
