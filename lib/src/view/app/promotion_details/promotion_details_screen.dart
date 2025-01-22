import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/data/model/promotion/promotion.dart';
import 'package:pet_style_mobile/src/view/app/menu/app_bar_back.dart';

class PromotionDetailsScreen extends StatefulWidget {
  final Promotion promo;
  const PromotionDetailsScreen({super.key, required this.promo});

  @override
  State<PromotionDetailsScreen> createState() => _PromotionDetailsScreenState();
}

class _PromotionDetailsScreenState extends State<PromotionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBarBack(
        onPressed: () {
          context.pop();
        },
        title: currentLocale == 'ro'
            ? widget.promo.nameRo ?? ''
            : widget.promo.nameRu ?? '',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              '${AppSecrets.baseUrl}/uploads/promotions/${widget.promo.image}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      currentLocale == 'ro'
                          ? widget.promo.nameRo ?? ''
                          : widget.promo.nameRu ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.primaryText.withAlpha(200),
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '${widget.promo.discount}%',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.primaryText.withAlpha(200),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                currentLocale == 'ro'
                    ? widget.promo.descriptionRo ?? ''
                    : widget.promo.descriptionRu ?? '',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryText.withAlpha(200),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
