import 'package:appwritetest/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomBG extends StatelessWidget {
  const CustomBG({
    Key? key,
    required this.child,
    this.appBar = false,
    this.appBarTitle,
    this.actions,
    this.leading,
  }) : super(key: key);

  final Widget child;
  final bool appBar;
  final Widget? appBarTitle;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Cols.customBG,
      child: Column(
        children: [
          if (appBar)
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: appBarTitle,
              actions: actions,
              leading: leading,
            ),
          child,
        ],
      ),
    );
  }
}
