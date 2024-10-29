import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/view/widget/base_container.dart';
import 'package:pet_style_mobile/src/view/widget/t_rounded_image.dart';

class PetCard extends StatelessWidget {
  final String id;
  final String photo;
  final String name;
  final String breed;
  final String age;
  final bool isNetworkImage;

  const PetCard({
    super.key,
    required this.width,
    required this.photo,
    required this.name,
    required this.breed,
    required this.age,
    required this.isNetworkImage,
    required this.id,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      width: width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TRoundedImage(
                  width: 80,
                  height: 80,
                  imageUrl: '${AppSecrets.baseUrl}/$photo',
                  applyImageRadius: true,
                  isNetworkImage: isNetworkImage,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Возраст: $age лет',
                            style: TextStyle(
                              color: AppColors.primaryText.withOpacity(0.7),
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            breed,
                            style: TextStyle(
                              color: AppColors.primaryText.withOpacity(0.7),
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.containerBorder,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            context.goNamed('pet_form', extra: id);
                          },
                          child: const SizedBox(
                            height: 36,
                            width: 36,
                            child: Icon(
                              Icons.edit,
                              color: AppColors.whiteText,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AddPetCard extends StatelessWidget {
  const AddPetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed('pet_form');
      },
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.containerColor.withOpacity(0.2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/pet-care.png'),
            const SizedBox(height: 5),
            Text(
              'Добавить питомца',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryText.withOpacity(0.7),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
