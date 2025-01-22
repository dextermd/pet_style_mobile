import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/data/model/promotion/promotion.dart';
import 'package:pet_style_mobile/src/view/router/app_routes.dart';

class PromoCard extends StatelessWidget {
  final Promotion promo;

  const PromoCard({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: '${AppSecrets.baseUrl}/uploads/promotions/${promo.image}',
          imageBuilder: (context, imageProvider) => Container(
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: 0.w,
                  top: 0.h,
                  child: Container(
                    width: 330.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: AppColors.whiteText.withAlpha(120),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.r),
                        topRight: Radius.circular(15.r),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
                      child: Text(
                        currentLocale == 'ro'
                            ? promo.nameRo ?? ''
                            : promo.nameRu ?? '',
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 20,
                          wordSpacing: 2.0,
                          color: AppColors.primaryText.withAlpha(200),
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 15.w,
                  bottom: 10.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.goNamed(
                            AppRoutes.promotionDetails,
                            extra: promo,
                          );
                        },
                        child: Container(
                          height: 30.h,
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 20.w),
                          decoration: BoxDecoration(
                            color: AppColors.containerBorder,
                            borderRadius: BorderRadius.circular(82.r),
                          ),
                          child: Center(
                            child: Text(
                              'Подробнее',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.whiteText,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (promo.discount != null && promo.discount != 0)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: AppColors.whiteText.withAlpha(200),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          bottomRight: Radius.circular(15.r),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            "Скидка:",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.containerBorder,
                              fontWeight: FontWeight.w500,
                              height: 0.5.h,
                            ),
                          ),
                          Text(
                            promo.discount != null
                                ? '${promo.discount!.toInt()}%'
                                : "-",
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.containerBorder,
                              fontWeight: FontWeight.w500,
                              height: 2.5.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
