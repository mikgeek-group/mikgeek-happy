import 'package:flutter/material.dart';
import 'package:happyapp/components/theme/gaps.dart';
import 'package:happyapp/components/theme/text_styles.dart';
import 'package:happyapp/components/theme/theme.dart';


class MkTitle extends StatelessWidget {
  const MkTitle({super.key, required this.title});
  
  final String title;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: MkTheme.iBorderRadius
          ),
        ),
        Gaps.hGap8,
        Text(title,style: TextStyles.textBold16,)
      ],
    );
  }
}
