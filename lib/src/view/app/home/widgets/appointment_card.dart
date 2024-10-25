import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class AppointmentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Image imageRight;
  final Image imageLeft;

  const AppointmentCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageRight,
    required this.imageLeft,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed('appointment');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.containerColor.withOpacity(0.2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageLeft,
                      const SizedBox(height: 10),
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: AppColors.primaryText.withOpacity(0.5),
                          fontSize: 12,
                        ),
                      ),
                      // const SizedBox(height: 10),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     context.pushNamed('appointment');                      },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: AppColors.primaryElement,
                      //     foregroundColor: AppColors.primaryLinkText,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(1),
                      //     ),
                      //   ),
                      //   child: const Text('Записаться',
                      //       style: TextStyle(
                      //           fontSize: 14, color: AppColors.whiteText)),
                      // ),
                    ],
                  ),
                ),
                Flexible(child: imageRight),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
