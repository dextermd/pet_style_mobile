import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/view/widget/my_elevation_button.dart';

class ScheduleCard extends StatelessWidget {
  final String time;
  final String date;
  final String petName;
  final String breed;
  final String petPhoto;
  final void Function()? onCanceled;
  final void Function()? onEdit;

  const ScheduleCard({
    super.key,
    required this.time,
    required this.date,
    required this.petName,
    required this.breed,
    required this.petPhoto,
    this.onCanceled,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        color: AppColors.containerColor.withAlpha(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: AppColors.containerColor.withAlpha(50),
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
                        color: AppColors.primaryText.withAlpha(160),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(
                          color: AppColors.primaryText.withAlpha(160),
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
                        color: AppColors.primaryText.withAlpha(160),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: TextStyle(
                          color: AppColors.primaryText.withAlpha(160),
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
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      '${AppSecrets.baseUrl}/uploads/pets/$petPhoto',
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
                            color: AppColors.primaryText.withAlpha(160),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Порода: $breed',
                          style: TextStyle(
                            color: AppColors.primaryText.withAlpha(210),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Мастер: Катя',
                          style: TextStyle(
                            color: AppColors.primaryText.withAlpha(201),
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
                        AppColors.primaryStatusError.withAlpha(160),
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
