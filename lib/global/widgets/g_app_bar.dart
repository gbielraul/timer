import 'package:flutter/material.dart';

class GAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GAppBar({
    Key? key,
    this.height = kToolbarHeight,
    required this.title,
    required this.leading,
    required this.actions,
  }) : super(key: key);

  final double height;
  final Widget title;
  final Widget leading;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading,
            title,
            ...actions,
          ],
        ),
      ),
    );
  }
}
