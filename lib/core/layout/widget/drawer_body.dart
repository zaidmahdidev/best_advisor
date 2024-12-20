import 'package:flutter/material.dart';

import '../../../../core/utils/constant/theme.dart';


class DrawerBody extends StatelessWidget {
  final Function onTap;
  final String title ;
  final IconData leadingIcon ;
  const DrawerBody({super.key, required this.onTap, required this.title, required this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(
        title,
        style: MyTheme.textStyle15,
      ),
      onTap: (){
        onTap();
      },
      trailing: Icon(Icons.keyboard_arrow_left),
    );
  }
}
