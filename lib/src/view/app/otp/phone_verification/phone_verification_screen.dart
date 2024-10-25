import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_style_mobile/blocs/appointment/appointment_bloc.dart';
import 'package:pet_style_mobile/blocs/otp/otp_bloc.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/utils/app_utils.dart';
import 'package:pet_style_mobile/src/view/app/menu/app_bar_back.dart';
import 'package:pet_style_mobile/src/view/router/app_routes.dart';
import 'package:pet_style_mobile/src/view/widget/my_button.dart';
import 'package:pet_style_mobile/src/view/widget/my_text_field.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formPhoneKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBack(
        onPressed: () {
          context.pop();
        },
      ),
      body: SafeArea(
        child: BlocListener<OtpBloc, OtpState>(
          listener: (context, state) {
            if (state is OtpSent) {
              context.pushNamed(AppRoutes.otpCode, extra: state.phone);
            } else if (state is OtpSentError) {
              AppUtils.showToastError(context, '', state.message);
            } else if (state is PhoneNumberUpdated) {
              context.read<AppointmentBloc>().add(AddPhoneNumberExistStateEvent());

            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Lottie.asset(
                  'assets/lottie/sms-send.json',
                  fit: BoxFit.contain,
                  height: 200,
                ),
                FadeInDown(
                  child: const Text(
                    'Верификация',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FadeInDown(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      'Нужно ввести номер телефона для продолжения, мы отправим вам код подтверждения',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FadeInDown(
                  child: Form(
                    key: _formPhoneKey,
                    child: MyTextField(
                      shouldShowCounter: true,
                      contentPadding: 15,
                      hintText: 'Номер телефона',
                      keyboardType: TextInputType.number,
                      controller: _phoneController,
                      maxLenght: 8,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Введите номер телефона';
                        }
                        if (value.length < 8) {
                          return 'Введите правильный номер телефона';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.startsWith('0')) {
                          setState(() {
                            _phoneController.text = value.substring(1);
                          });
                        }
                      },
                      obscureText: false,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 15,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.only(left: 15, right: 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/images/moldova.svg',
                              height: 15.0,
                              width: 15.0,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "+373 -",
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FadeInDown(
                  child: MyButton(
                    text: 'Продолжить',
                    onPressed: () {
                      if (_formPhoneKey.currentState!.validate()) {
                        context
                            .read<OtpBloc>()
                            .add(OtpSendEvent(_phoneController.text));
                      }
                    },
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
