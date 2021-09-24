import 'package:flutter/material.dart';

final List<Widget> pages = [
  // ProfileScreen(),
  // HomeScreens(),
  // TripHistoryScreen(),
];

Route createRoute(index) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => pages[index],
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
