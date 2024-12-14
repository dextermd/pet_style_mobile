import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  final Widget icon;
  final bool centerPosition;
  final void Function()? onTap;

  const TextLink({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
    this.centerPosition = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: centerPosition
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisAlignment: centerPosition
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            icon,
            const SizedBox(width: 5),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
