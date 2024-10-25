import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_style_mobile/blocs/pet_form/pet_form_bloc.dart';
import 'package:pet_style_mobile/blocs/user/user_bloc.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/data/model/pet/pet.dart';
import 'package:pet_style_mobile/src/view/app/menu/app_bar_back.dart';
import 'package:pet_style_mobile/src/view/widget/my_button.dart';
import 'package:pet_style_mobile/src/view/widget/my_radio_button.dart';
import 'package:pet_style_mobile/src/view/widget/my_text_field.dart';
import 'package:pet_style_mobile/src/view/widget/reusable_text.dart';
import 'package:pet_style_mobile/src/view/widget/searchable_dropdown.dart';
import 'package:pet_style_mobile/src/view/widget/toast.dart';
import 'package:searchfield/searchfield.dart';

class PetFormScreen extends StatefulWidget {
  final String? id;

  const PetFormScreen({
    super.key,
    this.id,
  });

  @override
  State<PetFormScreen> createState() => _PetFormScreenState();
}

class _PetFormScreenState extends State<PetFormScreen> {
  final _formSignUp = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _breadsController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _weightController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _breadsFocusNode = FocusNode();
  final _dateOfBirthFocusNode = FocusNode();
  final _weightFocusNode = FocusNode();

  final List<String> _genderOptions = ['Мальчик', 'Девочка'];
  final List<String> _typeOptions = ['Собака', 'Кошка'];
  final List<String> _behivatorOptions = ['Дружелюбный', 'Агрессивный'];

  final List<String> _genderValueOptions = ['Male', 'Female'];
  final List<String> _typeValueOptions = ['Dog', 'Cat'];
  final List<String> _behivatorValueOptions = ['Friendly', 'Aggressive'];

  String? _selectedGender = 'Male';
  String? _selectedType = 'Dog';
  String? _selectedBehovator = 'Friendly';
  String? _errorMsg;
  String? _serverImage;

  DateTime? _selectedDate;
  DateTime _initialDate = DateTime.now();

  bool petRequired = false;
  bool isDogBreeds = false;

  File? image;

  var suggestions = <SearchFieldListItem<String>>[];

  @override
  void initState() {
    super.initState();
    context.read<PetFormBloc>().add(LoadBreeds());
    if (widget.id != null) {
      editInitial();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _breadsController.dispose();
    _dateOfBirthController.dispose();
    _weightController.dispose();

    _nameFocusNode.dispose();
    _descFocusNode.dispose();
    _breadsFocusNode.dispose();
    _dateOfBirthFocusNode.dispose();
    _weightFocusNode.dispose();

    super.dispose();
  }

  void editInitial() {
    context.read<PetFormBloc>().add(LoadPet(widget.id!));
  }

  void selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBack(
        onPressed: () {
          context.pop();
        },
        title: widget.id == null ? 'Добавить питомца' : 'Редактировать питомца',
      ),
      body: GestureDetector(
        onTap: () {
          _nameFocusNode.unfocus();
          _descFocusNode.unfocus();
          _breadsFocusNode.unfocus();
          _dateOfBirthFocusNode.unfocus();
          _weightFocusNode.unfocus();
        },
        child: BlocListener<PetFormBloc, PetFormState>(
          listener: (context, state) {
            if (state is PetLoadError) {
              context.pop();
              toastError(msg: state.message);
            }
            if (state is PetLoaded) {
              final Pet pet = state.pet;
              _nameController.text = pet.name.toString();
              _descController.text = pet.description.toString();
              _breadsController.text = pet.breed.toString();
              _selectedGender = pet.gender.toString();
              _selectedType = pet.type.toString();
              _selectedBehovator = pet.behavior.toString();
              _initialDate = pet.birthDate!;
              _dateOfBirthController.text =
                  '${pet.birthDate.toString().substring(8, 10).toString().padLeft(2, '0')}.${pet.birthDate.toString().substring(5, 7).toString().padLeft(2, '0')}.${pet.birthDate.toString().substring(0, 4)}';
              _selectedDate = pet.birthDate;
              _weightController.text = pet.weight.toString();
              _serverImage = pet.photo;
              suggestions = _selectedType == _typeValueOptions[0]
                  ? PetFormState.dogBreedsL
                      .map(SearchFieldListItem<String>.new)
                      .toList()
                  : PetFormState.catBreedsL
                      .map(SearchFieldListItem<String>.new)
                      .toList();
            }
            if (state is PetCreateError) {
              toastError(msg: state.message);
              petRequired = false;
            }
            if (state is PetCreated) {
              petRequired = false;
              context.pop();
              context
                  .read<UserBloc>()
                  .add(const FetchUserData(completer: null));
            }
            if (state is PetUpdateError) {
              toastError(msg: state.message);
              petRequired = false;
            }
            if (state is PetUpdated) {
              petRequired = false;
              context.pop();
              context
                  .read<UserBloc>()
                  .add(const FetchUserData(completer: null));
            }
            if (state is PetDeleteError) {
              toastError(msg: state.message);
              petRequired = false;
            }
            if (state is PetDeleted) {
              petRequired = false;
              context.pop();
              context
                  .read<UserBloc>()
                  .add(const FetchUserData(completer: null));
            }
          },
          child: BlocBuilder<PetFormBloc, PetFormState>(
            builder: (context, state) {
              if (state is PetBreedsLoaded) {
                suggestions = _selectedType == _typeValueOptions[0]
                    ? state.dogBreeds
                        .map(SearchFieldListItem<String>.new)
                        .toList()
                    : state.catBreeds
                        .map(SearchFieldListItem<String>.new)
                        .toList();
              }
              if (state is PetLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is PetBreedsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 25.w, right: 25.w),
                        child: Form(
                          key: _formSignUp,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(child: ReusableText(text: 'Фото')),
                              InkWell(
                                onTap: () => selectImage(),
                                child: _serverImage == null && image == null
                                    ? Center(
                                        child: SizedBox(
                                          width: 125,
                                          height: 125,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(75),
                                            child: Image.asset(
                                              _selectedType ==
                                                      _typeValueOptions[0]
                                                  ? 'assets/images/dog_def.jpeg'
                                                  : 'assets/images/cat_def.jpeg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: SizedBox(
                                          width: 125,
                                          height: 125,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(75),
                                            child: image == null
                                                ? Image.network(
                                                    '${AppSecrets.baseUrl}/$_serverImage',
                                                    fit: BoxFit.cover,
                                                  )
                                                : CircleAvatar(
                                                    backgroundImage:
                                                        FileImage(image!),
                                                    radius: 50,
                                                  ),
                                          ),
                                        ),
                                      ),
                              ),
                              const ReusableText(text: 'Имя'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: MyTextField(
                                  controller: _nameController,
                                  focusNode: _nameFocusNode,
                                  contentPadding: 15,
                                  hintText: 'Введите имя вашего питомца',
                                  obscureText: false,
                                  keyboardType: TextInputType.name,
                                  prefixIcon: const Icon(
                                    Icons.pets,
                                    color: AppColors.primarySecondIcon,
                                  ),
                                  errorMsg: _errorMsg,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Пожалуйста, заполните это поле';
                                    } else if (val.length > 30) {
                                      return 'Имя не должно превышать 30 символов';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 10.h),
                              const ReusableText(text: 'Пол'),
                              Row(
                                children: [
                                  MyRadioButton(
                                    title: _typeOptions[0],
                                    value: _typeValueOptions[0],
                                    groupValue: _selectedType!,
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedType = val;
                                        _breadsController.clear();
                                        suggestions = _selectedType ==
                                                _typeValueOptions[0]
                                            ? PetFormState.dogBreedsL
                                                .map(SearchFieldListItem<String>
                                                    .new)
                                                .toList()
                                            : PetFormState.catBreedsL
                                                .map(SearchFieldListItem<String>
                                                    .new)
                                                .toList();
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  MyRadioButton(
                                    title: _typeOptions[1],
                                    value: _typeValueOptions[1],
                                    groupValue: _selectedType!,
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedType = val;
                                        _breadsController.clear();
                                        suggestions = _selectedType ==
                                                _typeValueOptions[0]
                                            ? PetFormState.dogBreedsL
                                                .map(SearchFieldListItem<String>
                                                    .new)
                                                .toList()
                                            : PetFormState.catBreedsL
                                                .map(SearchFieldListItem<String>
                                                    .new)
                                                .toList();
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              const ReusableText(text: 'Порода'),
                              SearchableDropdown(
                                suggestions: suggestions,
                                controller: _breadsController,
                                focusNode: _breadsFocusNode,
                                validator: (x) {
                                  if (x == null ||
                                      !suggestions
                                          .map((e) => e.searchKey)
                                          .contains(x)) {
                                    return 'Пожалуйста, выберите породу из списка';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10.h),
                              const ReusableText(text: 'Пол'),
                              Row(
                                children: [
                                  MyRadioButton(
                                    title: _genderOptions[0],
                                    value: _genderValueOptions[0],
                                    groupValue: _selectedGender!,
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedGender = val;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  MyRadioButton(
                                    title: _genderOptions[1],
                                    value: _genderValueOptions[1],
                                    groupValue: _selectedGender!,
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedGender = val;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Row(
                                children: [
                                  Expanded(
                                    child: ReusableText(text: 'Вес'),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: ReusableText(text: 'Дата рождения'),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: MyTextField(
                                      controller: _weightController,
                                      focusNode: _dateOfBirthFocusNode,
                                      contentPadding: 15,
                                      hintText: 'Введите вес питомца',
                                      obscureText: false,
                                      keyboardType: TextInputType.number,
                                      prefixIcon: const Icon(
                                        Icons.line_weight_sharp,
                                        color: AppColors.primarySecondIcon,
                                      ),
                                      errorMsg: _errorMsg,
                                      onTap: () async {},
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Пожалуйста, заполните это поле';
                                        } else if (int.parse(val) < 1) {
                                          return 'Вес не может быть меньше 1 кг';
                                        } else if (int.parse(val) > 35) {
                                          return 'Вес не может быть больше 35 кг';
                                        } else if (val.length > 3) {
                                          return 'Вес не может превышать 3 символа';
                                        } else if (val
                                            .contains(RegExp(r'[a-zA-Z]'))) {
                                          return 'Вес не может содержать буквы';
                                        } else if (val.contains(RegExp(
                                            r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]'))) {
                                          return 'Вес не может содержать спецсимволы';
                                        } else if (val
                                            .contains(RegExp(r'[. ,]'))) {
                                          return 'Вес не может содержать точки или запятые';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: MyTextField(
                                        controller: _dateOfBirthController,
                                        focusNode: _dateOfBirthFocusNode,
                                        contentPadding: 15,
                                        readOnly: true,
                                        hintText:
                                            'Выберите дату рождения питомца',
                                        obscureText: false,
                                        keyboardType: TextInputType.datetime,
                                        prefixIcon: const Icon(
                                          Icons.edit_calendar_rounded,
                                          color: AppColors.primarySecondIcon,
                                        ),
                                        errorMsg: _errorMsg,
                                        onTap: () async {
                                          final DateTime initialDate =
                                              DateTime.now();
                                          final DateTime? picked =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: _initialDate,
                                            firstDate:
                                                DateTime(initialDate.year - 25),
                                            lastDate: DateTime.now(),
                                            //locale: const Locale("ru", "RU"),
                                          );
                                          if (picked != null &&
                                              picked != DateTime.now()) {
                                            setState(() {
                                              _selectedDate = picked;
                                              _dateOfBirthController.text =
                                                  '${picked.toString().substring(8, 10).toString().padLeft(2, '0')}.${picked.toString().substring(5, 7).toString().padLeft(2, '0')}.${picked.toString().substring(0, 4)}';
                                            });
                                          }
                                        },
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return 'Пожалуйста, заполните это поле';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10.h),
                              const ReusableText(text: 'Характер'),
                              Row(
                                children: [
                                  MyRadioButton(
                                    title: _behivatorOptions[0],
                                    value: _behivatorValueOptions[0],
                                    groupValue: _selectedBehovator!,
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedBehovator = val;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  MyRadioButton(
                                    title: _behivatorOptions[1],
                                    value: _behivatorValueOptions[1],
                                    groupValue: _selectedBehovator!,
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedBehovator = val;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const ReusableText(
                                  text: 'Дополнительная информация'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: MyTextField(
                                  controller: _descController,
                                  focusNode: _descFocusNode,
                                  contentPadding: 15,
                                  minLines: 3,
                                  maxLines: 5,
                                  hintText:
                                      'Напиши какие-то особенности питомца или прошлые травмы',
                                  obscureText: false,
                                  keyboardType: TextInputType.multiline,
                                  prefixIcon: const Icon(
                                    Icons.description,
                                    color: AppColors.primarySecondIcon,
                                  ),
                                  errorMsg: _errorMsg,
                                ),
                              ),
                              const SizedBox(height: 20),
                              !petRequired
                                  ? widget.id == null
                                      ? MyButton(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          text: 'Добавить',
                                          onPressed: () async {
                                            if (_formSignUp.currentState!
                                                .validate()) {
                                              Pet newPet = Pet(
                                                name: _nameController.text,
                                                type: _selectedType,
                                                breed: _breadsController.text,
                                                description:
                                                    _descController.text,
                                                gender: _selectedGender,
                                                weight: int.parse(
                                                  _weightController.text,
                                                ),
                                                behavior: _selectedBehovator,
                                                birthDate: _selectedDate,
                                              );
                                              petRequired = true;
                                              context.read<PetFormBloc>().add(
                                                    CreatePet(
                                                      pet: newPet,
                                                      photo: image,
                                                    ),
                                                  );
                                            }
                                          },
                                        )
                                      : Row(
                                          children: [
                                            MyButton(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              text: 'Обновить',
                                              fontSize: 14,
                                              onPressed: () async {
                                                if (_formSignUp.currentState!
                                                    .validate()) {
                                                  Pet updatedPet = Pet(
                                                    id: widget.id!,
                                                    name: _nameController.text,
                                                    type: _selectedType,
                                                    breed:
                                                        _breadsController.text,
                                                    description:
                                                        _descController.text,
                                                    gender: _selectedGender,
                                                    weight: int.parse(
                                                      _weightController.text,
                                                    ),
                                                    behavior:
                                                        _selectedBehovator,
                                                    birthDate: _selectedDate,
                                                  );
                                                  petRequired = true;
                                                  context
                                                      .read<PetFormBloc>()
                                                      .add(
                                                        UpdatePet(
                                                          pet: updatedPet,
                                                          photo: image,
                                                        ),
                                                      );
                                                }
                                              },
                                            ),
                                            const SizedBox(width: 10),
                                            MyButton(
                                              color:
                                                  AppColors.primaryStatusError,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              text: 'Удалить',
                                              fontSize: 14,
                                              onPressed: () async {
                                                petRequired = true;
                                                context.read<PetFormBloc>().add(
                                                      DeletePet(widget.id!),
                                                    );
                                              },
                                            ),
                                          ],
                                        )
                                  : const Center(
                                      child: CircularProgressIndicator()),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
