
import 'dart:core';
import '../ExportFiles/ExportFilesMust.dart';


class AppBarStyle extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? trailingAction;
  final String? text;
  final TextStyle? textStyle;

  AppBarStyle({Key? key,
    this.leading,
    this.trailingAction,
    this.text = "App Bar Style",
    this.textStyle = const TextStyle(color: Colors.red, fontSize: 16)
  }) : super(key: key);

  double heightAppBar = 54;

  @override
  Size get preferredSize => Size.fromHeight(heightAppBar);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorStyle.primaryF5F5F5,
      leadingWidth: 40,
      centerTitle: true,
      title: Text(
        text!,
        style: textStyle,
      ),
      actions: [
        if (trailingAction != null)
          Row(
            children: [
              trailingAction!,
            ],
          ),
        const SizedBox(width: 10),
      ],
    );
  }

}
