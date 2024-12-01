import 'package:charify_front/core/theme/app_colors.dart';
import 'package:charify_front/core/ui/widgets/default_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ThankYouBottomSheet extends StatelessWidget {
  const ThankYouBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(CupertinoIcons.heart_fill,color: Colors.red,size: 50),
          const SizedBox(height: 12,),
          Text('Thank you for Your Donation!',style: Theme.of(context).textTheme.headlineSmall,),
          const SizedBox(height: 12,),
          DefaultButton(text: 'Close',onPressed: (){
            context.pop();
          },)
        ],
      ),
    );
  }
}
