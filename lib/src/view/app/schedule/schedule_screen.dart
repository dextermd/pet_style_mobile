import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/blocs/schedule/schedule_bloc.dart';
import 'package:pet_style_mobile/core/helpers/date_time_helper.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/utils/app_utils.dart';
import 'package:pet_style_mobile/src/view/app/menu/app_bar_tabs.dart';
import 'package:pet_style_mobile/src/view/app/schedule/widgets/schedule_card.dart';
import 'package:pet_style_mobile/src/view/app/schedule/widgets/schedule_card_filtered.dart';
import 'package:pet_style_mobile/src/view/router/app_routes.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  Set<String> cancelingIds = {};
  Set<String> editingIds = {};

  @override
  void initState() {
    //context.read<ScheduleBloc>().add(ScheduleLoad());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBarTabs(
          title: 'Мои записи',
          bottomTabs: TabBar(
            unselectedLabelColor: AppColors.primaryHintText,
            labelColor: AppColors.primaryText.withOpacity(0.6),
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: Theme.of(context).textTheme.bodyLarge,
            labelPadding: const EdgeInsets.symmetric(horizontal: 10),
            dividerColor: AppColors.primaryElement,
            indicatorColor: AppColors.primaryElement,
            indicatorWeight: 3,
            tabs: [
              Tab(text: 'Текущие'),
              Tab(text: 'Завершенные'),
              Tab(text: 'Отмененные'),
            ],
          ),
        ),
        body: BlocListener<ScheduleBloc, ScheduleState>(
          listener: (context, state) {
            if (state is ScheduleCanceled) {
              context.read<ScheduleBloc>().add(ScheduleLoad());
              AppUtils.showToastSuccess(
                context,
                'Успешно',
                'Запись отменена',
              );
              Future.delayed(const Duration(seconds: 3), () {
                setState(() {
                  cancelingIds.clear();
                });
              });
            }
            if (state is ScheduleCancelError) {
              AppUtils.showToastError(
                context,
                'Ошибка',
                state.message,
              );
              Future.delayed(const Duration(seconds: 5), () {
                setState(() {
                  cancelingIds.remove(state.canceledId);
                });
              });
            }
            if (state is EditingNotAvailable) {
              AppUtils.showToastError(context, 'Ошибка',
                  'Редактирование записи возможно не позднее чем за 48 часов до начала приема. Для редактирования записи свяжитесь с грумером');
              Future.delayed(const Duration(seconds: 5), () {
                setState(() {
                  editingIds.clear();
                });
              });
            }
            if (state is EditingAvailable) {
              context.goNamed(
                AppRoutes.editSchedule,
                extra: state.appointment,
              );
              setState(() {
                editingIds.clear();
              });
            }
          },
          child: BlocBuilder<ScheduleBloc, ScheduleState>(
            buildWhen: (previous, current) {
              return current is ScheduleLoaded ||
                  current is ScheduleLoading ||
                  current is ScheduleCanceled ||
                  current is ScheduleError;
            },
            builder: (context, state) {
              return TabBarView(
                children: [
                  if (state is ScheduleLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (state is ScheduleLoaded)
                    RefreshIndicator(
                      onRefresh: () async {
                        final completer = Completer();
                        context
                            .read<ScheduleBloc>()
                            .add(ScheduleLoad(completer: completer));
                        return completer.future;
                      },
                      child: ListView.builder(
                        itemCount: state.active.length,
                        itemBuilder: (context, index) {
                          return ScheduleCard(
                            time: DateTimeHelper.getFormattedTime(
                                state.active[index].appointmentDate!),
                            date: DateTimeHelper.getFormattedDate(
                                state.active[index].appointmentDate!),
                            petName: state.active[index].pet?.name ?? '',
                            breed: state.active[index].pet?.breed ?? '',
                            onCanceled: cancelingIds
                                    .contains(state.active[index].id!)
                                ? null
                                : () {
                                    context.read<ScheduleBloc>().add(
                                          ScheduleCancelEvent(
                                              state.active[index].id!),
                                        );
                                    setState(() {
                                      cancelingIds.add(state.active[index].id!);
                                    });
                                  },
                            onEdit: editingIds.contains(state.active[index].id!)
                                ? null
                                : () {
                                    context.read<ScheduleBloc>().add(
                                          ScheduleEditEvent(
                                              state.active[index].id!),
                                        );
                                    setState(() {
                                      editingIds.add(state.active[index].id!);
                                    });
                                  },
                          );
                        },
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  if (state is ScheduleLoaded)
                    ListView.builder(
                      itemCount: state.completed.length,
                      itemBuilder: (context, index) {
                        return ScheduleCardFiltered(
                          time: DateTimeHelper.getFormattedTime(
                              state.completed[index].appointmentDate!),
                          date: DateTimeHelper.getFormattedDate(
                              state.completed[index].appointmentDate!),
                          petName: state.completed[index].pet?.name ?? '',
                          breed: state.completed[index].pet?.breed ?? '',
                        );
                      },
                    )
                  else
                    const SizedBox.shrink(),
                  if (state is ScheduleLoaded)
                    ListView.builder(
                      itemCount: state.canceled.length,
                      itemBuilder: (context, index) {
                        return ScheduleCardFiltered(
                          time: DateTimeHelper.getFormattedTime(
                              state.canceled[index].appointmentDate!),
                          date: DateTimeHelper.getFormattedDate(
                              state.canceled[index].appointmentDate!),
                          petName: state.canceled[index].pet?.name ?? '',
                          breed: state.canceled[index].pet?.breed ?? '',
                          isCancelled: state.canceled[index].status == 2,
                        );
                      },
                    )
                  else
                    const SizedBox.shrink(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
