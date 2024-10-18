import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';

class IntoPageTwo extends StatelessWidget {
  const IntoPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Красота и Уход',
            style: TextStyle(
              color: AppColors.primaryElement,
              fontSize: 28.sp,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          Container(
            width: 375.w,
            padding: EdgeInsets.only(left: 35.w, right: 40.w),
            child: Center(
              child: Text(
                'Вашего питомца стригут, подстригают когти и причесывают для идеального вида.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.primarySecondText,
                      fontSize: 16.sp,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          SvgPicture.asset(
            'assets/images/two.svg',
            height: 400.0,
            width: 400.0,
          ),
        ],
      ),
    );
  }
}
