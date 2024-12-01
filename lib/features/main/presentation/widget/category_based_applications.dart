import 'package:charify_front/core/theme/app_colors.dart';
import 'package:charify_front/features/main/presentation/bloc/main_bloc.dart';
import 'package:charify_front/features/main/presentation/bloc/main_event.dart';
import 'package:charify_front/features/main/presentation/bloc/main_state.dart';
import 'package:charify_front/features/main/presentation/widget/application_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBasedApplications extends StatelessWidget {
  const CategoryBasedApplications({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            var category = state.applicationsByCategory?.keys.elementAt(index);
            var applications = state.applicationsByCategory?[category];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${category?.name}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          context.read<MainBloc>().add(ToggleFilterByCategoryEvent(categoryEntity: category));
                        },
                        child: Text(
                          'All',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                  ],
                ),
                Text(
                  '${category?.description}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.text.withOpacity(0.7)),
                ),
                const SizedBox(
                  height: 12,
                ),
                ListView.separated(
                  itemBuilder: (context, index) {
                    var application = (applications ?? [])[index];
                    return ApplicationWidget(applicationEntity: application);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                  itemCount: applications?.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                )
              ],
            );
          },
          separatorBuilder: (context,index){
            return const SizedBox(height: 16,);
          },
          itemCount: state.applicationsByCategory?.keys.length ?? 0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        );
      },
    );
  }
}
