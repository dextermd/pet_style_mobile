import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/blocs/otp/otp_bloc.dart';
import 'package:pet_style_mobile/blocs/user/user_bloc.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/core/values/strings.dart';
import 'package:pet_style_mobile/src/data/model/update_user_request/update_user_request.dart';
import 'package:pet_style_mobile/src/data/model/user/user.dart';
import 'package:pet_style_mobile/src/utils/app_utils.dart';
import 'package:pet_style_mobile/src/view/app/menu/app_bar_back.dart';
import 'package:pet_style_mobile/src/view/router/app_routes.dart';
import 'package:pet_style_mobile/src/view/widget/my_button.dart';
import 'package:pet_style_mobile/src/view/widget/my_elevation_button.dart';
import 'package:pet_style_mobile/src/view/widget/my_text_field.dart';
import 'package:pet_style_mobile/src/view/widget/reusable_text.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formEditProfile = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  String? _errorMsg;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  bool signUpRequired = false;

  IconData iconPassword = CupertinoIcons.eye_fill;
  IconData iconConfirmPassword = CupertinoIcons.eye_fill;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is OtpSent) {
          final updateUser = User(
            name: _nameController.text,
            email: _emailController.text,
            phone: _phoneNumberController.text,
          );
          final newPassword = _passwordController.text;

          final updateRequest = UpdateUserRequest(
            updateUser: updateUser,
            newPassword: newPassword,
          );
          context.pushNamed(
            AppRoutes.verifyCode,
            extra: updateRequest,
          );
        } else if (state is OtpSentError) {
          AppUtils.showToastError(context, '', state.message);
        }
      },
      child: Scaffold(
        appBar: AppBarBack(
          onPressed: () {
            context.pop();
          },
          title: 'Редактировать профиль',
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: BlocBuilder<UserBloc, UserState>(
            buildWhen: (previous, current) {
              if (current is UserUpdated || current is UpdateUserDataError) {
                return false;
              }
              return true;
            },
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UserLoaded) {
                _nameController.text = state.user.name ?? '';
                _emailController.text = state.user.email ?? '';
                _phoneNumberController.text = state.user.phone ?? '';

                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: Form(
                            key: _formEditProfile,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const ReusableText(text: 'Name'),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: MyTextField(
                                    controller: _nameController,
                                    focusNode: _nameFocusNode,
                                    contentPadding: 12,
                                    hintText: 'Enter your name',
                                    obscureText: false,
                                    keyboardType: TextInputType.name,
                                    prefixIcon:
                                        const Icon(CupertinoIcons.person_fill),
                                    errorMsg: _errorMsg,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Please fill in this field';
                                      } else if (val.length > 30) {
                                        return 'Name to long';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 10),
                                const ReusableText(text: 'Email'),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: MyTextField(
                                    controller: _emailController,
                                    focusNode: _emailFocusNode,
                                    contentPadding: 12,
                                    hintText: 'Enter your email adress',
                                    obscureText: false,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon:
                                        const Icon(CupertinoIcons.mail_solid),
                                    errorMsg: _errorMsg,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Please fill in this firld';
                                      } else if (!emailRexExp.hasMatch(val)) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 10),
                                const ReusableText(text: 'Phone Number'),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: MyTextField(
                                    controller: _phoneNumberController,
                                    focusNode: _phoneNumberFocusNode,
                                    contentPadding: 12,
                                    hintText: 'Enter your phone number',
                                    obscureText: false,
                                    keyboardType: TextInputType.phone,
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 5),
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
                                    maxLenght: 8,
                                    errorMsg: _errorMsg,
                                    onChanged: (value) {
                                      if (value.startsWith('0')) {
                                        logDebug('Starts with 0');
                                        _phoneNumberController.value =
                                            _phoneNumberController.value
                                                .copyWith(
                                          text: value.substring(1),
                                          selection: TextSelection.collapsed(
                                            offset: value.length - 1,
                                          ),
                                        );
                                      }
                                    },
                                    validator: (val) {
                                      if (val!.isNotEmpty && val.length < 8) {
                                        return 'Please enter a valid phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 10),
                                if (state.user.provider == 'email')
                                  const ReusableText(text: 'New Password'),
                                if (state.user.provider == 'email')
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: MyTextField(
                                      controller: _passwordController,
                                      focusNode: _passwordFocusNode,
                                      contentPadding: 12,
                                      hintText: 'New Password',
                                      obscureText: obscurePassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      prefixIcon:
                                          const Icon(CupertinoIcons.lock_fill),
                                      errorMsg: _errorMsg,
                                      validator: (val) {
                                        if (!passwordRexExp.hasMatch(val!) &&
                                            val.isNotEmpty) {
                                          return 'Please enter a valid password';
                                        }

                                        return null;
                                      },
                                      suffixIcon: IconButton(
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
                                if (state.user.provider == 'email')
                                  SizedBox(height: 10),
                                if (state.user.provider == 'email')
                                  const ReusableText(
                                      text: 'Confirm New Password'),
                                if (state.user.provider == 'email')
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: MyTextField(
                                      controller: _confirmPasswordController,
                                      focusNode: _confirmPasswordFocusNode,
                                      contentPadding: 12,
                                      hintText: 'Confirm New Password',
                                      obscureText: obscureConfirmPassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      prefixIcon:
                                          const Icon(CupertinoIcons.lock_fill),
                                      errorMsg: _errorMsg,
                                      validator: (val) {
                                        if (!passwordRexExp.hasMatch(val!) &&
                                            val.isNotEmpty) {
                                          return 'Please enter a valid password';
                                        } else if (val !=
                                            _passwordController.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            obscureConfirmPassword =
                                                !obscureConfirmPassword;
                                            if (obscureConfirmPassword) {
                                              iconConfirmPassword =
                                                  CupertinoIcons.eye_fill;
                                            } else {
                                              iconConfirmPassword =
                                                  CupertinoIcons.eye_slash_fill;
                                            }
                                          });
                                        },
                                        icon: Icon(iconConfirmPassword),
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 50),
                                !signUpRequired
                                    ? MyElevatedButton(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        text: 'Сохранить',
                                        onPressed: () async {
                                          if (_formEditProfile.currentState!
                                              .validate()) {
                                            logDebug(state.user.provider);
                                            if ((state.user.phone == null ||
                                                    state.user.phone.isEmpty ||
                                                    state.user.phone == '' ||
                                                    state.user.phone !=
                                                        _phoneNumberController
                                                            .text) &&
                                                _phoneNumberController
                                                    .text.isNotEmpty) {
                                              context.read<OtpBloc>().add(
                                                  OtpSendEvent(
                                                      _phoneNumberController
                                                          .text));
                                              return;
                                            }

                                            final updateUser = User(
                                              name: _nameController.text,
                                              email: _emailController.text,
                                              phone:
                                                  _phoneNumberController.text,
                                            );
                                            context.read<UserBloc>().add(
                                                  UpdateUserDataEvent(
                                                    user: updateUser,
                                                    newPassword:
                                                        _passwordController
                                                            .text,
                                                  ),
                                                );
                                          }
                                        },
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryElement,
                                        ),
                                      ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
