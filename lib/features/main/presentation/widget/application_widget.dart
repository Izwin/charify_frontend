import 'package:cached_network_image/cached_network_image.dart';
import 'package:charify_front/core/theme/app_colors.dart';
import 'package:charify_front/core/utils/date_utils.dart';
import 'package:charify_front/core/utils/url_utils.dart';
import 'package:charify_front/features/main/domain/entity/application_entity.dart';
import 'package:charify_front/features/main/presentation/page/single_application_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApplicationWidget extends StatelessWidget {
  final ApplicationEntity applicationEntity;
  final Function(ApplicationEntity)? onTap;

  const ApplicationWidget(
      {super.key, required this.applicationEntity, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: (){
          if(onTap!=null){
            onTap!.call(applicationEntity);
          }
          else{
            context.push(SingleApplicationPage.path(applicationEntity.id));
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: UrlUtils.buildImageUrl(applicationEntity.images.first),
                    height: 255,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
                if(applicationEntity.urgent)Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.surface,
                    ),
                    child: Text('Urgent',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.text
                    ),),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      Text(
                        applicationEntity.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const Spacer(),
                      Text('${applicationEntity.donorCount ?? 0}',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.text.withOpacity(0.7)
                      ),),
                      const SizedBox(width: 4,),
                      Icon(CupertinoIcons.person_2_fill,size: 20,color: AppColors.text.withOpacity(0.7),)
                    ],
                  ),
                  const SizedBox(height: 4,),
                  Text(applicationEntity.description,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.text.withOpacity(0.7),
                  ),maxLines: 2,overflow: TextOverflow.ellipsis,),
                  const SizedBox(height: 8,),
                  LinearProgressIndicator(
                    value: (applicationEntity.collectedPercentage  ?? 0.0)/ 100,
                    color: AppColors.primary,
                    backgroundColor: AppColors.onSurface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Text('${applicationEntity.amount}\$',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.text.withOpacity(0.7)
                      ),),
                      const Spacer(),
                      Text(applicationEntity.deadline.timeLeft(),style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.text.withOpacity(0.7)
                      ),),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
