import 'package:charify_front/core/ui/widgets/default_text_field.dart';
import 'package:charify_front/features/main/presentation/bloc/main_bloc.dart';
import 'package:charify_front/features/main/presentation/bloc/main_event.dart';
import 'package:charify_front/features/main/presentation/bloc/main_state.dart';
import 'package:charify_front/features/main/presentation/widget/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterControls extends StatelessWidget {
  const FilterControls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: DefaultTextField(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                onChanged: (value){
                  context.read<MainBloc>().add(SetSearchFilterEvent(search: value));
                },
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Badge(
              isLabelVisible: state.filterByCategory !=null || state.isUrgentFilter,
              padding: EdgeInsets.zero,
              smallSize: 8,
              child: IconButton(onPressed: () {
                showModalBottomSheet(context: context, builder: (context) {
                  return const FilterDialog();
                });
              }, icon: const Icon(Icons.filter_list_alt),padding: EdgeInsets.zero,style: IconButton.styleFrom(
                iconSize: 25,
                minimumSize: const Size(20, 20),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap
              ),),
            )
          ],
        );
      },
    );
  }
}
