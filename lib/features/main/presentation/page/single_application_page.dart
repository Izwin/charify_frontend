import 'package:cached_network_image/cached_network_image.dart';
import 'package:charify_front/core/di/get_it.dart';
import 'package:charify_front/core/theme/app_colors.dart';
import 'package:charify_front/core/ui/widgets/default_button.dart';
import 'package:charify_front/core/utils/date_utils.dart';
import 'package:charify_front/core/utils/int_utils.dart';
import 'package:charify_front/core/utils/url_utils.dart';
import 'package:charify_front/features/main/presentation/bloc/single_application_bloc.dart';
import 'package:charify_front/features/main/presentation/bloc/single_application_event.dart';
import 'package:charify_front/features/main/presentation/bloc/single_application_state.dart';
import 'package:charify_front/features/main/presentation/page/payment_page.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SingleApplicationPage extends StatefulWidget {
  final String applicationId;

  const SingleApplicationPage({super.key, required this.applicationId});

  static String path(String id) => '/application/$id';

  @override
  State<SingleApplicationPage> createState() => _SingleApplicationPageState();
}

class _SingleApplicationPageState extends State<SingleApplicationPage> {
  int currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<SingleApplicationBloc>()
        ..add(GetSingleApplicationEvent(applicationId: widget.applicationId)),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<SingleApplicationBloc, SingleApplicationState>(
            builder: (context, state) {
              if (state.status == SingleApplicationStatus.success) {
                return SizedBox.expand(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned.fill(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    height: 300,
                                    child: PageView(
                                      children: state.applicationEntity?.images
                                          .map((e) =>
                                          CachedNetworkImage(
                                            imageUrl:
                                            UrlUtils.buildImageUrl(
                                                e),
                                            fit: BoxFit.cover,
                                          ))
                                          .toList() ??
                                          [],
                                      onPageChanged: (page) {
                                        setState(() {
                                          currentImage = page;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: IconButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      icon: const Icon(CupertinoIcons.back),
                                      style: IconButton.styleFrom(
                                          backgroundColor: AppColors.surface),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              DotsIndicator(
                                dotsCount:
                                state.applicationEntity?.images.length ?? 0,
                                position: currentImage,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                '${state.applicationEntity
                                                    ?.title}',
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headlineMedium)),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          '${state.applicationEntity
                                              ?.donorCount}',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.text
                                                  .withOpacity(0.8)),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          CupertinoIcons.person_2_fill,
                                          size: 25,
                                          color:
                                          AppColors.text.withOpacity(0.8),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        '${state.applicationEntity
                                            ?.description}',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.text
                                                .withOpacity(0.8))),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    LinearProgressIndicator(
                                      color: AppColors.primary,
                                      backgroundColor: AppColors.onSurface,
                                      borderRadius: BorderRadius.circular(20),
                                      value: (state.applicationEntity
                                          ?.collectedPercentage ?? 0.0) / 100,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${state.applicationEntity
                                              ?.collectedAmount
                                              ?.formatNumber()}\$',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                              color: AppColors.text
                                                  .withOpacity(0.7)),
                                        ),
                                        Text(
                                          '${state.applicationEntity?.amount
                                              .formatNumber()}\$',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                              color: AppColors.text
                                                  .withOpacity(0.7)),
                                        ),
                                      ],
                                    ),
                                    if(state.applicationEntity?.userDonations
                                        .isNotEmpty ?? false) Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 12,),
                                        Text('My donations', style: Theme
                                            .of(context)
                                            .textTheme
                                            .headlineSmall,),
                                        const SizedBox(height: 8,),
                                        ListView.separated(
                                          physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var donation = state
                                                  .applicationEntity
                                                  ?.userDonations[index];
                                              return Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(DateFormat('dd MMM, yyyy').format(
                                                      donation?.date ??
                                                          DateTime.now()),style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: AppColors.text.withOpacity(0.8)
                                                  ),),
                                                  Text('\$${donation?.amount.toStringAsFixed(2)}')
                                                ],
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(height: 12,);
                                            },
                                            itemCount: state.applicationEntity
                                                ?.userDonations.length ?? 0,shrinkWrap: true,),
                                        const SizedBox(height: 120,),

                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                '${state.applicationEntity?.deadline
                                    .timeLeft()}',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                    color: AppColors.text
                                        .withOpacity(0.7),
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(height: 12,),
                            DefaultButton(
                              text: 'Donate',
                              onPressed: () {
                                context.push(
                                    PaymentPage.path(widget.applicationId))
                                    .then((v) {
                                  context.read<SingleApplicationBloc>().add(
                                      GetSingleApplicationEvent(
                                          applicationId: widget.applicationId));
                                });
                              },
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
          ),
        ),
      ),
    );
  }
}
