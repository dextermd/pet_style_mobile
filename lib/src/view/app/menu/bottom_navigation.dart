import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/view/router/app_routes.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, this.child});

  final Widget? child;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  int previousIndex = 0;

  void changeTab(int index) {
    switch (index) {
      case 0:
        context.goNamed('home');
        break;
      case 1:
        context.goNamed('chat');
        break;
      case 2:
        context.goNamed('schedule');
        break;
      case 3:
        context.pushNamed('setting');
        break;
    }

    setState(() {
      previousIndex = currentIndex;
      currentIndex = index;
      if (currentIndex == 3) {
        currentIndex = previousIndex;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String currentUrl = GoRouterState.of(context).uri.toString();
    final List<String> hideBottomNavBarPaths = [
      AppRoutes.settingPath,
      AppRoutes.editProfilePath,
      AppRoutes.phoneVerificationPath,
      AppRoutes.otpCodePath,
    ];

    bool shouldShowBottomNavBar = !hideBottomNavBarPaths.contains(currentUrl);

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: shouldShowBottomNavBar
          ? BottomNavigationBar(
              elevation: 1,
              onTap: changeTab,
              backgroundColor: AppColors.primarySecondElement,
              selectedItemColor: AppColors.primaryLinkActive,
              unselectedItemColor: AppColors.primaryText.withOpacity(0.8),
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.house_fill),
                  label: 'Главная',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chat_bubble_2_fill),
                  label: 'Чат',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.calendar),
                  label: 'Записи',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings),
                  label: 'Настройки',
                ),
              ],
            )
          : null,
    );
  }
}
