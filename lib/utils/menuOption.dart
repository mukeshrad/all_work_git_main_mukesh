import 'package:flutter/material.dart';

class MenuOption extends StatelessWidget {
  final String s;
  final VoidCallback onTap;
  final IconData iconData;
  final Color iconColor;
  final bool? showTrailIcon;
  final TextStyle? textStyle;
  const MenuOption(
      {Key? key,
      required this.s,
      required this.onTap,
      required this.iconData,
      required this.iconColor,
      this.showTrailIcon,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0.0, 5.0),
              blurRadius: 30.0,
            ),
          ],
        ),
        child: ListTile(
          tileColor: const Color(0xffFFFFFF),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
              side: BorderSide(width: 0.5, color: Colors.white)),
          leading: Icon(
            iconData,
            color: iconColor,
          ),
          title: Text(
            s,
            style: textStyle ??
                const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
          ),
          onTap: onTap,
          trailing: showTrailIcon == false || showTrailIcon == null
              ? null
              : const Icon(
                  Icons.verified_sharp,
                  color: Color(0xff05C46B),
                  size: 17.5,
                ),
        ),
      ),
    );
  }
}
