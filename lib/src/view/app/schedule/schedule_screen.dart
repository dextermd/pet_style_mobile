import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/view/app/menu/app_bar_tabs.dart';
import 'package:pet_style_mobile/src/view/app/schedule/widgets/schedule_card.dart';
import 'package:pet_style_mobile/src/view/app/schedule/widgets/schedule_card_filtered.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

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
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return const ScheduleCard(
                  time: '10:00',
                  date: '10.10.2021',
                  petName: 'Марс',
                  breed: 'Сиба-Ину',
                );
              },
            ),
            ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return const ScheduleCardFiltered(
                  time: '10:00',
                  date: '10.10.2021',
                  petName: 'Марс',
                  breed: 'Сиба-Ину',
                );
              },
            ),
            ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return const ScheduleCardFiltered(
                  isCancelled: true,
                  time: '10:00',
                  date: '10.10.2021',
                  petName: 'Марс',
                  breed: 'Сиба-Ину',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
