import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class MyListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? trailing;
  final void Function()? onTap;
  final bool addBorderBottom;
  final EdgeInsets? contentPadding;

  const MyListTile({
    super.key,
    this.leading,
    required this.title,
    this.trailing = const Icon(
      Icons.chevron_right,
      color: AppColors.primaryLinkActive,
    ),
    this.onTap,
    this.addBorderBottom = true,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 5),
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: addBorderBottom
          ? Border(
              bottom: BorderSide(
                color: AppColors.lightGray.withOpacity(0.5),
              ),
            )
          : null,
      contentPadding: contentPadding,
      dense: true,
      visualDensity: VisualDensity.compact,
      onTap: onTap,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      leading: leading,
      trailing: trailing,
    );
  }
}
