import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pet_style_mobile/blocs/appointment/appointment_bloc.dart';
import 'package:pet_style_mobile/core/helpers/date_time_helper.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/secrets/app_secrets.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/data/model/pet/pet.dart';
import 'package:pet_style_mobile/src/view/app/menu/app_bar_back.dart';
import 'package:pet_style_mobile/src/view/widget/my_button.dart';
import 'package:pet_style_mobile/src/view/widget/t_rounded_image.dart';


class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final totalDays = 14;
  DateTime? _selectedDate;
  String? _selectedSlot;
  Pet? _selectedPet;

  @override
  void initState() {
    context.read<AppointmentBloc>().add(
          const AppointmentGetAvailableDaysOfWeekEvent('1'),
        );
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void _onPetSelected(Pet pet) {
    setState(() {
      _selectedPet == pet ? _selectedPet = null : _selectedPet = pet;
    });
  }

  void _onSlotSelected(String slot) {
    if (_selectedSlot == slot) {
      setState(() {
        _selectedSlot = null;
        _selectedPet = null;
      });
      return;
    }
    setState(() {
      if (!AppointmentState.timeSlotAppointment.availableTimeSlot!
          .contains(slot)) {
        return;
      }
      _selectedPet = null;
      _selectedSlot = slot;
      context.read<AppointmentBloc>().add(
            const AppointmentGetPetsProfleEvent(true),
          );
    });
  }

  void _onDateSelected(DateTime date) {
    if (_selectedDate == date) return;

    setState(() {
      _selectedDate = date;
      _selectedSlot = null;
      _selectedPet = null;
    });
    final justDate = DateTimeHelper.getFormattedDate(date);
    context.read<AppointmentBloc>().add(
          AppointmentGetAvailableTimeSlotsEvent(justDate, '1'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBack(
        onPressed: () {
          Navigator.of(context).pop();
        },
        title: 'Запись на прием',
      ),
      body: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Сегодня:',
                      ),
                      Text(
                        DateFormat.yMMMMd('ru').format(
                          DateTime.now(),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state is AppointmentAvailableDaysOfWeekError)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryElement,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                if (state is AppointmentAvailableDaysOfWeekLoading)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                if (AppointmentState.activeDates.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.date_range,
                          color: AppColors.primaryElement,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Выберите дату:',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryElement,
                                  ),
                        ),
                      ],
                    ),
                  ),
                if (AppointmentState.activeDates.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.containerColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: const EdgeInsets.only(left: 20),
                    child: DatePicker(
                      DateTime.now(),
                      height: 100,
                      width: 80,
                      selectionColor: AppColors.containerBorder,
                      activeDates: AppointmentState.activeDates,
                      daysCount: totalDays,
                      dateTextStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                      locale: 'ru-Ru',
                      onDateChange: _onDateSelected,
                    ),
                  ),
                if (state is AppointmentAvailableSlotsLoading)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                if (state is AppointmentAvailableSlotsError)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryElement,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                if (AppointmentState
                    .timeSlotAppointment.allTimeSlot!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.timer_sharp,
                          color: AppColors.primaryElement,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Выберите время:',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryElement,
                                  ),
                        ),
                      ],
                    ),
                  ),
                if (AppointmentState
                    .timeSlotAppointment.allTimeSlot!.isNotEmpty)
                  SizedBox(
                    height: 20 *
                        (AppointmentState.timeSlotAppointment.allTimeSlot!
                                        .length %
                                    2 ==
                                0
                            ? (AppointmentState
                                .timeSlotAppointment.allTimeSlot!.length
                                .toDouble())
                            : (AppointmentState
                                    .timeSlotAppointment.allTimeSlot!.length
                                    .toDouble()) +
                                1.0),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 30,
                      ),
                      itemCount: AppointmentState
                          .timeSlotAppointment.allTimeSlot!.length,
                      itemBuilder: (context, index) {
                        final slot = AppointmentState
                            .timeSlotAppointment.allTimeSlot![index];
                        final isSelected = _selectedSlot == slot;
                        final isBooked = !AppointmentState
                            .timeSlotAppointment.availableTimeSlot!
                            .contains(slot);
                        return GestureDetector(
                          onTap: () => _onSlotSelected(slot),
                          child: Container(
                            decoration: BoxDecoration(
                              border: isBooked
                                  ? Border.all(
                                      color: AppColors.containerBorder,
                                      width: 1,
                                    )
                                  : null,
                              color: isBooked
                                  ? AppColors.primaryTransparent
                                  : isSelected
                                      ? AppColors.containerBorder
                                      : AppColors.containerColor
                                          .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: isBooked
                                      ? AppColors.containerBorder
                                      : isSelected
                                          ? AppColors.whiteText
                                          : AppColors.primaryText,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  slot,
                                  style: TextStyle(
                                    color: isBooked
                                        ? AppColors.containerBorder
                                        : isSelected
                                            ? AppColors.whiteText
                                            : AppColors.primaryText,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (state is AppointmentPetsProfileError)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryElement,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                if (state is AppointmentPetsProfileLoading)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                if (_selectedSlot != null && AppointmentState.pets.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.pets_sharp,
                          color: AppColors.primaryElement,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Выберите питомца:',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryElement,
                                  ),
                        ),
                      ],
                    ),
                  ),
                if (_selectedSlot != null && AppointmentState.pets.isNotEmpty)
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: AppointmentState.pets.length,
                      itemBuilder: (context, index) {
                        final pet = AppointmentState.pets[index];
                        final isSelected = _selectedPet == pet;
                        return AppointmentState.pets[index].type == 'Dog'
                            ? GestureDetector(
                                onTap: () => _onPetSelected(pet),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  padding: const EdgeInsets.all(10),
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.containerBorder
                                        : AppColors.containerColor
                                            .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      TRoundedImage(
                                        width: 70,
                                        height: 70,
                                        imageUrl:
                                            '${AppSecrets.baseUrl}/${AppointmentState.pets[index].photo}',
                                        applyImageRadius: true,
                                        isNetworkImage: true,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        pet.name!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? AppColors.whiteText
                                              : AppColors.primaryText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox();
                      },
                    ),
                  ),
                const SizedBox(height: 25),
                if (_selectedSlot != null && _selectedPet != null)
                  MyButton(
                    onPressed: () {
                      logDebug('Selected pet: $_selectedPet');
                      logDebug('Selected slot: $_selectedSlot');
                    },
                    text: 'Записаться',
                    width: MediaQuery.of(context).size.width * 0.8,
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
