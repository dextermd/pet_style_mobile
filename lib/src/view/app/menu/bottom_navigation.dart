import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/gen/assets.gen.dart';
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

  final GlobalKey _chatButtonKey = GlobalKey();

  void changeTab(int index) {
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.home);
        break;
      case 1:
        context.goNamed(AppRoutes.schedule);
        break;
      case 2:
        _showChatOptions(context);
        break;
      case 3:
        context.pushNamed(AppRoutes.setting);
        break;
    }

    setState(() {
      previousIndex = currentIndex;
      currentIndex = index;
      if (currentIndex == 4) {
        currentIndex = previousIndex;
      }
    });
  }

  void _showChatOptions(BuildContext context) {
    final RenderBox button =
        _chatButtonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final Offset position =
        button.localToGlobal(Offset.zero, ancestor: overlay);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx + MediaQuery.of(context).size.width * 00.04,
        position.dy - 165,
        position.dx + button.size.width,
        0,
      ),
      elevation: 1,
      constraints: const BoxConstraints(
        minWidth: 50,
        maxWidth: 50,
      ),
      color: AppColors.primarySecondElement,
      shadowColor: AppColors.primaryTransparent,
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'telegram',
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Assets.icons.teleg.svg(),
          ),
        ),
        PopupMenuItem<String>(
          value: 'viber',
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Assets.icons.viber.svg(),
          ),
        ),
        PopupMenuItem<String>(
          value: 'whatsapp',
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Assets.icons.whats.svg(),
          ),
        ),
      ],
    );
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
              unselectedItemColor: AppColors.primaryText.withAlpha(200),
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.house_fill),
                  label: 'Главная',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.calendar),
                  label: 'Записи',
                ),
                BottomNavigationBarItem(
                  key: _chatButtonKey,
                  icon: Icon(CupertinoIcons.chat_bubble_2_fill),
                  label: 'Чат',
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
