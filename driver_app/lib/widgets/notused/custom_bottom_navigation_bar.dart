import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar(this.bottomBarIndex, this.onTap) : super();

  final int bottomBarIndex;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(17),
          topRight: Radius.circular(17),
        ),
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: primaryColorDark,
          currentIndex: bottomBarIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: primaryColorWhite,
                size: 30,
              ),
              label: "Profile",
              activeIcon: Container(
                decoration: BoxDecoration(
                  color: primaryColorLight,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.5),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: primaryColorBlack,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                color: primaryColorWhite,
                size: 30,
              ),
              label: "Home",
              activeIcon: Container(
                decoration: BoxDecoration(
                  color: primaryColorLight,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.5),
                  child: Center(
                    child: Icon(
                      Icons.home_rounded,
                      color: primaryColorBlack,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_book_rounded,
                color: primaryColorWhite,
                size: 30,
              ),
              label: "History",
              activeIcon: Container(
                decoration: BoxDecoration(
                  color: primaryColorLight,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.5),
                  child: Center(
                    child: Icon(
                      Icons.menu_book_rounded,
                      color: primaryColorBlack,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
