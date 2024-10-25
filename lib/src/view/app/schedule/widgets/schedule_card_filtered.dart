import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class ScheduleCardFiltered extends StatelessWidget {
  final String time;
  final String date;
  final String petName;
  final String breed;
  final bool isCancelled;

  const ScheduleCardFiltered({
    super.key,
    required this.time,
    required this.date,
    required this.petName,
    required this.breed,
    this.isCancelled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          // The card with grayscale filter
          ColorFiltered(
            colorFilter: ColorFilter.matrix(
              <double>[
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
              ],
            ),
            child: Card(
              color: AppColors.containerColor.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: AppColors.containerColor.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: AppColors.primaryText.withOpacity(0.6),
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              time,
                              style: TextStyle(
                                color: AppColors.primaryText.withOpacity(0.6),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: AppColors.primaryText.withOpacity(0.6),
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              date,
                              style: TextStyle(
                                color: AppColors.primaryText.withOpacity(0.6),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(50), // Circular image
                          child: Image.network(
                            'https://images.pexels.com/photos/160846/french-bulldog-summer-smile-joy-160846.jpeg?auto=compress&cs=tinysrgb&w=600',
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Имя: $petName',
                                style: TextStyle(
                                  color: AppColors.primaryText.withOpacity(0.6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Порода: $breed',
                                style: TextStyle(
                                  color: AppColors.primaryText.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Мастер: Катя',
                                style: TextStyle(
                                  color: AppColors.primaryText.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isCancelled)
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: 0.6,
                  child: Container(
                    width: 200,
                    height: 20,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: Colors.red.withOpacity(0.2),
                  ),
                ),
              ),
            ),
          if (isCancelled)
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: -0.6,
                  child: Container(
                    width: 200,
                    height: 20,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: Colors.red.withOpacity(0.2),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
