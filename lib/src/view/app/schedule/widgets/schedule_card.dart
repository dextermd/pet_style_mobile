import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/view/widget/my_elevation_button.dart';

class ScheduleCard extends StatelessWidget {
  final String time;
  final String date;
  final String petName;
  final String breed;
  final void Function()? onCanceled;
  final void Function()? onEdit;

  const ScheduleCard({
    super.key,
    required this.time,
    required this.date,
    required this.petName,
    required this.breed,
    this.onCanceled,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    borderRadius: BorderRadius.circular(50), // Circular image
                    child: Image.network(
                      'https://images.pexels.com/photos/160846/french-bulldog-summer-smile-joy-160846.jpeg?auto=compress&cs=tinysrgb&w=600', // Replace with your image URL
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
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyElevatedButton(
                    text: 'Отменить',
                    onPressed: onCanceled,
                    backgroundColor:
                        AppColors.primaryStatusError.withOpacity(0.6),
                  ),
                  MyElevatedButton(
                    text: 'Редактировать',
                    onPressed: onEdit,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
