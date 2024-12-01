import 'package:charify_front/core/theme/app_colors.dart';
import 'package:charify_front/core/ui/widgets/default_checkbox.dart';
import 'package:charify_front/features/main/presentation/bloc/main_bloc.dart';
import 'package:charify_front/features/main/presentation/bloc/main_event.dart';
import 'package:charify_front/features/main/presentation/bloc/main_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Filter',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            context.read<MainBloc>().add(ClearFiltersEvent());
                          },
                          child: Text(
                            'Clear',
                            style: Theme.of(context).textTheme.headlineSmall,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      var category = state.categories?[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('${category?.name}'),
                        trailing: DefaultCheckbox(
                            value: state.filterByCategory == category,
                            onChanged: (value) {
                              context.read<MainBloc>().add(
                                  ToggleFilterByCategoryEvent(
                                      categoryEntity: category));
                            }),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      );
                    },
                    itemCount: state.categories?.length ?? 0,
                    shrinkWrap: true,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Urgent'),
                    trailing: CupertinoSwitch(
                      value: state.isUrgentFilter,
                      onChanged: (v) {
                        context
                            .read<MainBloc>()
                            .add(SetIsUrgentFilterEvent(isUrgent: v));
                      },
                      activeColor: AppColors.text,
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
