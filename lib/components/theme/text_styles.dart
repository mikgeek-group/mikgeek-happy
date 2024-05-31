import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimens.dart';

class TextStyles {

  static const TextStyle textSize12 = TextStyle(
    fontSize: Dimens.font_sp12,
  );

  static const TextStyle textSize14 = TextStyle(
    fontSize: Dimens.font_sp14,
  );
  static const TextStyle textPrimary12 = TextStyle(
      fontSize: Dimens.font_sp12,
      color: Colours.app_main
  );
  static const TextStyle textPrimary14 = TextStyle(
      fontSize: Dimens.font_sp14,
      color: Colours.app_main
  );
  static const TextStyle textPrimary16 = TextStyle(
      fontSize: Dimens.font_sp16,
      color: Colours.app_main
  );
  static const TextStyle textSize16 = TextStyle(
    fontSize: Dimens.font_sp16,
  );
  static const TextStyle textSize18 = TextStyle(
    fontSize: Dimens.font_sp18,
  );
  static const TextStyle textBold14 = TextStyle(
      fontSize: Dimens.font_sp14,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold16 = TextStyle(
      fontSize: Dimens.font_sp16,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold18 = TextStyle(
      fontSize: Dimens.font_sp18,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold20 = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold24 = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold26 = TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold
  );

  static const TextStyle textGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_gray,
  );
  static const TextStyle textDarkGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.dark_text_gray,
  );

  static const TextStyle textWhite14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.white,
  );

  static const TextStyle text = TextStyle(
      fontSize: Dimens.font_sp14,
      color: Colours.text,
      // https://github.com/flutter/flutter/issues/40248
      textBaseline: TextBaseline.alphabetic
  );
  static const TextStyle textDark = TextStyle(
      fontSize: Dimens.font_sp14,
      color: Colours.dark_text,
      textBaseline: TextBaseline.alphabetic
  );

  static const TextStyle textGray12 = TextStyle(
      fontSize: Dimens.font_sp12,
      color: Colours.text_gray,
      fontWeight: FontWeight.normal
  );
  static const TextStyle textDarkGray12 = TextStyle(
      fontSize: Dimens.font_sp12,
      color: Colours.dark_text_gray,
      fontWeight: FontWeight.normal
  );

  static const TextStyle textHint14 = TextStyle(
      fontSize: Dimens.font_sp14,
      color: Colours.dark_unselected_item_color
  );
}
