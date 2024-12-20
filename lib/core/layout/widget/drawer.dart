import 'package:flutter/material.dart';
import 'drawer_body.dart';
import 'drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.zero,
            curve: Curves.bounceIn,
            child: DrawerHeaderSection(),
          ),
          DrawerBody(
            title: 'iiiiiii',
            leadingIcon: Icons.business_center, // أيقونة الزراعة التعاقدية
            onTap: () {
            },
          ),


          const Spacer(),
          const Text('اصدار التطبيق 1.0.2'),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
