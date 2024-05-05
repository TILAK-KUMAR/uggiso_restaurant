import 'package:flutter/material.dart';
import 'package:uggiso_restaurant/base/common/utils/fonts.dart';

class ImageTitle extends StatelessWidget {
  final String image;
  final String title;

  const ImageTitle({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image,width: 10,height: 10,),
        SizedBox(width: 4,),
        Text(title,style: AppFonts.smallText,)
      ],
    );
  }
}
