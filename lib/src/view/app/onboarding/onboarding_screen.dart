import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/core/services/storage_services.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/core/values/constants.dart';
import 'package:pet_style_mobile/src/view/app/onboarding/widgets/into_page_one.dart';
import 'package:pet_style_mobile/src/view/app/onboarding/widgets/into_page_three.dart';
import 'package:pet_style_mobile/src/view/app/onboarding/widgets/into_page_two.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  late StorageServices _storageServices;
  bool onLastPage = false;

  @override
  void initState() {
    super.initState();
    _storageServices = GetIt.I<StorageServices>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              IntoPageOne(),
              IntoPageTwo(),
              IntoPageThree(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: const Text('skip'),
                  onTap: () {
                    _pageController.jumpToPage(2);
                  },
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const SlideEffect(
                    dotColor: AppColors.primarySecondText,
                    activeDotColor: AppColors.primaryElement,
                  ),
                ),
                onLastPage
                    ? GestureDetector(
                        child: const Text('done'),
                        onTap: () async {
                          context.goNamed('splash');
                          await _storageServices.setBool(
                              AppConstants.STORAGE_SHOW_ONBOARDING, false);
                        },
                      )
                    : GestureDetector(
                        child: const Text('next'),
                        onTap: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardPage extends StatelessWidget {
  final String title, subtitle, imagePath, buttonName;
  final int index;
  final PageController pageController;

  const OnboardPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.index,
    required this.buttonName,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: 375.w,
            height: 375.w,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            )),
        SizedBox(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(left: 35.w, right: 35.w),
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.primaryText.withOpacity(0.5),
                ),
          ),
        ),
        SizedBox(height: 75.h),
        // MyButton(
        //   text: buttonName,
        //   onPressed: () async {
        //     if (index < 3) {
        //       pageController.animateToPage(index,
        //           duration: const Duration(milliseconds: 400),
        //           curve: Curves.easeIn);
        //     } else {
        //       try {
        //         context.goNamed('sign_in');
        //         await StorageServices.setBool(
        //             AppConstants.STORAGE_SHOW_ONBOARDING, false);
        //         log("The value is ${StorageServices.getDeviceOnboardingOpen()}");
        //       } catch (e) {
        //         log('Failed to navigate: $e');
        //       }
        //     }
        //   },
        // ),
      ],
    );
  }
}
