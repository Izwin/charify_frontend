import 'package:charify_front/features/main/presentation/bloc/main_bloc.dart';
import 'package:charify_front/features/main/presentation/bloc/main_state.dart';
import 'package:charify_front/features/main/presentation/widget/application_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationList extends StatelessWidget {
  const ApplicationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var application = (state.lastApplications ?? [])[index];
            return ApplicationWidget(applicationEntity: application);
          },
          separatorBuilder: (context,index) => const SizedBox(height: 16,),
          itemCount: state.lastApplications?.length ?? 0,
          shrinkWrap: true,
        );
      },
    );
  }
}
