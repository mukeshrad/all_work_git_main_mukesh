import 'package:flutter/material.dart';

class NewAppBar extends StatelessWidget {
  final String pageName;
  final Widget? prefix;
  const NewAppBar({
    Key? key,
    required this.pageName,
    this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            const SizedBox(
              width: 30.0,
            ),
            Text(
              pageName,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        prefix ?? Container(),
      ],
    );
  }
}
