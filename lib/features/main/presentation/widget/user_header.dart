import 'package:charify_front/core/theme/app_colors.dart';
import 'package:charify_front/core/ui/widgets/default_button.dart';
import 'package:charify_front/features/auth/presentation/bloc/user_bloc.dart';
import 'package:charify_front/features/auth/presentation/bloc/user_event.dart';
import 'package:charify_front/features/auth/presentation/bloc/user_state.dart';
import 'package:charify_front/features/history/presentation/page/history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Hello, ${state.userEntity?.displayName}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.surface,
                      ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    context.read<UserBloc>().add(LogoutEvent());
                  },
                  icon: const Icon(Icons.logout),
                  color: AppColors.surface,
                )
              ],
            ),
            Text(
              'Projects supported: ${state.userEntity?.projectsSupported ?? 0}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.surface,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'You`ve donated: ${state.userEntity?.totalDonated ?? 0}\$',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.surface,
                  ),

            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 120,
              child: DefaultButton(
                text: 'History',
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                backgroundColor: AppColors.secondary,
                onPressed: (){
                  context.push(HistoryPage.path);
                },
                textColor: AppColors.text,
              ),
            )
          ],
        );
      },
    );
  }
}
