import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

Future<void> showPriceInfoDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.primaryBackground,
        insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
        ),
        content: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Популярные породы собак и цена стрижки за полный комплекс, в леях.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText.withAlpha(200),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Expanded(
                      child: Text(
                        'Цена услуг варьируется ввиду:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText.withAlpha(200),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildListItem('- Плохого поведения собаки'),
                _buildListItem('- Запущенного состояния питомца'),
                _buildListItem('- Более сложной стрижки'),
                Text(
                  'Эти аспекты напрямую влияют на сложность и длительность стрижки.',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[],
      );
    },
  );
}

Widget _buildListItem(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, size: 16, color: AppColors.primaryStatusOk),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primaryText.withAlpha(200),
            ),
          ),
        ),
      ],
    ),
  );
}
