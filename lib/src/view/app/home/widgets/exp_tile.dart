import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class ExpTile extends StatelessWidget {
  final String title;
  final String text;

  const ExpTile({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ExpansionTile(
        dense: true,
        collapsedBackgroundColor: AppColors.containerColor.withAlpha(50),
        collapsedIconColor: AppColors.primaryIcon,
        iconColor: AppColors.primaryIcon,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: HtmlWidget(
              text,
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
