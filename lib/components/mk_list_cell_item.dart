import 'package:flutter/material.dart';
import 'package:happyapp/components/theme/gaps.dart';
import 'package:happyapp/components/theme/text_styles.dart';
import 'package:happyapp/components/theme/theme.dart';


const _defaultExt = Text('');
const _rightIcon = Icon(
  Icons.arrow_forward_ios,
  size: 12,
);

const _textIcon = SizedBox.shrink();

class MkListCellItem extends StatelessWidget {
  const MkListCellItem({
    Key? key,
    this.height = 46,
    this.extOnTap,
    this.ext = _defaultExt,
    this.rightIcon = _rightIcon,
    this.textIcon = _textIcon,
    required this.value,
    required this.press,
  }) : super(key: key);

  final Widget ext;
  final String value;
  final VoidCallback press;
  final Widget rightIcon;
  final Widget textIcon;
  final double height;
  final Function? extOnTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: new Border(
            bottom: BorderSide(color: Colors.black.withOpacity(0.03), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildTextIcon(),
            Gaps.hGap10,
            Text(value, style: TextStyles.textSize14),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => {
                  if(extOnTap != null){
                    extOnTap!()
                  }else {
                    press()
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ext,
                  ],
                ),
              ),
            ),
            SizedBox(width: MkTheme.iDefaultPadding / 2),
            Padding(padding: EdgeInsets.only(right: 10),child: rightIcon,)
          ],
        ),
      ),
    );
  }

  buildTextIcon() {
    if (textIcon == _textIcon) {
      return textIcon;
    } else {
      return Padding(
          padding: EdgeInsets.only(left: MkTheme.iDefaultPadding / 2),
          child: textIcon);
    }
  }
}
