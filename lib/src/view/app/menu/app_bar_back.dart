import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class AppBarBack extends StatelessWidget implements PreferredSizeWidget {
  final Function() onPressed;
  final String? title;
  final double toolbarHeight;
  final Color? backgroundColor;

  const AppBarBack({
    super.key,
    required this.onPressed,
    this.title,
    this.toolbarHeight = 60,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ??AppColors.primarySecondElement,
      shadowColor: AppColors.primarySecondElement,
      foregroundColor: AppColors.primarySecondElement,
      surfaceTintColor: AppColors.primarySecondElement,
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: toolbarHeight,
      centerTitle: true,
      leading: IconButton(
        color: AppColors.whiteText,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            AppColors.containerBorder,
          ),
        ),
        alignment: Alignment.center,
        icon: const Icon(
          Icons.arrow_back,
          size: 26,
          color: AppColors.whiteText,
        ),
        onPressed: onPressed,
      ),
      title: Text(
        title ?? '',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.primaryText.withAlpha(200),
            ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


// InkWell(
//         onTap: onPressed,
//         child: Container(
//           height: 40,
//           width: 40,
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//             color: AppColors.containerBorder,
//           ),
//           child: const Center(
//             child: Icon(
//               Icons.arrow_back,
//               color: AppColors.whiteText,
//               size: 20,
//             ),
//           ),
//         ),
//       ),