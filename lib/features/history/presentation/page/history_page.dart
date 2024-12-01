import 'package:charify_front/core/theme/app_colors.dart';
import 'package:charify_front/core/utils/date_utils.dart';
import 'package:charify_front/features/history/presentation/bloc/history_bloc.dart';
import 'package:charify_front/features/history/presentation/bloc/history_event.dart';
import 'package:charify_front/features/history/presentation/bloc/history_state.dart';
import 'package:charify_front/features/main/presentation/page/single_application_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  static const String path = '/history';

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener(){
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      context.read<HistoryBloc>().add(LoadDonationsEvent());
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'History',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(CupertinoIcons.back)),
          titleSpacing: 0,
        ),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            return SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        bool isSameDate = false;
                        final DateTime date = (state.donations ?? [])[index].date;
                        if (index == 0) {
                          isSameDate = false;
                        } else {
                          final DateTime prevDate =
                              (state.donations ?? [])[index - 1].date;
                          isSameDate = date.isSameDate(prevDate);
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isSameDate)
                              Text(DateFormat('dd MMM, yyyy').format(date),style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.text.withOpacity(0.7)
                              ),),
                            const SizedBox(
                              height: 12,
                            ),
                            InkWell(
                              onTap: (){
                                context.push(SingleApplicationPage.path(state.donations?[index].application?.id ?? ''));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          '${state.donations?[index].application?.title}',style: Theme.of(context).textTheme.bodyMedium,),
                                    ),
                                    const SizedBox(width: 16,),
                                    Text('\$${state.donations?[index].amount}')
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      itemCount: state.donations?.length ?? 0,
                      shrinkWrap: true,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
