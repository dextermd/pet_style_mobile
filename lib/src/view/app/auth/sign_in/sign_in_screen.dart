import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_style_mobile/blocs/localization/localization_bloc.dart';
import 'package:pet_style_mobile/blocs/sign_in/sign_in_bloc.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/core/values/strings.dart';
import 'package:pet_style_mobile/gen/assets.gen.dart';
import 'package:pet_style_mobile/l10n/l10n.dart';
import 'package:pet_style_mobile/src/utils/app_utils.dart';
import 'package:pet_style_mobile/src/view/router/app_routes.dart';
import 'package:pet_style_mobile/src/view/widget/my_button.dart';
import 'package:pet_style_mobile/src/view/widget/my_text_field.dart';

import 'widgets/square_tile.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignIn = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String? _errorMsg;
  bool obscurePassword = true;
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          setState(() {
            signInRequired = true;
            context.goNamed(AppRoutes.splash);
          });
        } else if (state is SignInProcess) {
          setState(() {
            signInRequired = true;
          });
        } else if (state is SignInFailure) {
          setState(() {
            signInRequired = false;
            AppUtils.showToastError(context, '', state.message ?? '');
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: GestureDetector(
          onTap: () {
            _emailFocusNode.unfocus();
            _passwordFocusNode.unfocus();
          },
          child: SingleChildScrollView(
            child: SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10.h),
                          padding: EdgeInsets.only(left: 25.w, right: 25.w),
                          child: Form(
                            key: _formSignIn,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20.h),
                                Center(
                                  child: Lottie.asset('assets/lottie/frt.json',
                                      fit: BoxFit.contain, height: 150.h),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: MyTextField(
                                    controller: _emailController,
                                    focusNode: _emailFocusNode,
                                    hintText: 'Введите ваш email',
                                    obscureText: false,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: const Icon(
                                      CupertinoIcons.mail_solid,
                                      color: AppColors.primarySecondIcon,
                                    ),
                                    errorMsg: _errorMsg,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Пожалуйста, заполните это поле';
                                      } else if (!emailRexExp.hasMatch(val)) {
                                        return 'Неверный формат электронной почты';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: MyTextField(
                                    controller: _passwordController,
                                    focusNode: _passwordFocusNode,
                                    hintText: 'Введите ваш пароль',
                                    obscureText: obscurePassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    prefixIcon: const Icon(
                                      CupertinoIcons.lock_fill,
                                      color: AppColors.primarySecondIcon,
                                    ),
                                    errorMsg: _errorMsg,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Пожалуйста, заполните это поле';
                                      }
                                      return null;
                                    },
                                    suffixIcon: IconButton(
                                      color: AppColors.primarySecondIcon,
                                      onPressed: () {
                                        setState(() {
                                          obscurePassword = !obscurePassword;
                                          if (obscurePassword) {
                                            iconPassword =
                                                CupertinoIcons.eye_fill;
                                          } else {
                                            iconPassword =
                                                CupertinoIcons.eye_slash_fill;
                                          }
                                        });
                                      },
                                      icon: Icon(iconPassword),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Container(
                                  alignment: Alignment.topRight,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 25,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: const Text("Восстановить пароль?",
                                        style: TextStyle(
                                          color: AppColors.primarySecondText,
                                        )),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                !signInRequired
                                    ? MyButton(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        text: 'Войти',
                                        onPressed: () async {
                                          if (_formSignIn.currentState!
                                              .validate()) {
                                            context.read<SignInBloc>().add(
                                                  SignInRequired(
                                                      _emailController.text,
                                                      _passwordController.text),
                                                );
                                          } else {}
                                        },
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator()),
                                const SizedBox(height: 30),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 25.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          thickness: 0.5,
                                          color: AppColors.primaryLine,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          'Или войдите через',
                                          style: TextStyle(
                                              color:
                                                  AppColors.primarySecondText),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          thickness: 0.5,
                                          color: AppColors.primaryLine,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<SignInBloc>()
                                            .add(GoogleSignInRequired());
                                      },
                                      child: SquareTile(
                                        image: Assets.images.google
                                            .image(height: 40),
                                      ),
                                    ),
                                    const SizedBox(width: 25),
                                    SquareTile(
                                      image: Assets.icons.fb.svg(height: 50),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'У вас нет аккаунта?',
                                      style: TextStyle(
                                          color: AppColors.primarySecondText),
                                    ),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: () {
                                        context.goNamed('sign_up');
                                      },
                                      child: Text(
                                        'Зарегистрироваться',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppUtils.showLanguageDialog(context);
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        width: 120,
                        height: 40,
                        child: Row(
                          children: [
                            BlocBuilder<LocalizationBloc, LocalizationState>(
                              buildWhen: (previous, current) =>
                                  previous.selectedLanguage !=
                                  current.selectedLanguage,
                              builder: (context, state) {
                                return SvgPicture.asset(
                                  state.selectedLanguage.iconPath,
                                  width: 8.w,
                                  height: 8.h,
                                );
                              },
                            ),
                            const SizedBox(width: 5),
                            Text(
                              l10n.change_language,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
