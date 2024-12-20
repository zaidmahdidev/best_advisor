import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newproject/core/layout/widget/drawer.dart';
import '../utils/constant/images.dart';
import '../utils/constant/theme.dart';

class Layout extends StatefulWidget {
  final int _currentIndex;
  const Layout({super.key, int? currentIndex}) : _currentIndex = currentIndex ?? 0;


  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget._currentIndex;
  }

  final List<Widget> _page = [
    InquiryPage(),
    AllFavoritesPage(),
    CartPage(),
    OrderPage(),
  ];
  final List<String> title = [
    "الرئيسية",
    "الأمنيات",
    "سلة التسوق",
    "ملفي الشخصي",
  ];



  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentIndex == 0,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        setState(() {
          _currentIndex = 0;
        });
      },
      child: Scaffold(
        endDrawer: const CustomDrawer(),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MyTheme.primaryColor,
                  MyTheme.primaryColor.withOpacity(.5),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(right: 5),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    Images.logo,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // NotificationCubit.get(context).notificationModel = null;
                // NotificationCubit.get(context).notificationCurrentPage = 1;
                // NotificationCubit.get(context).getAllNotification();
                // context.push(NotificationPage());
              },
              icon: const Badge(
                label: Text('10'),
                backgroundColor: CupertinoColors.destructiveRed,
                child: Icon(Icons.notifications),
              ),
            ),
            Builder(
              builder: (context) {
                return IconButton(
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    icon: Icon(Icons.menu));
              },
            ),
          ],
          title: Text(title[_currentIndex]),
        ),
        body: _page[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          enableFeedback: true,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: MyTheme.primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'الأمنيات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'السلة',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'الإعدادات',
            ),
          ],
        ),
      ),
    );
  }
}





class InquiryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'استخدم الأقسام أدناه لطرح استفسارك',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              children: [
                InquiryCard(title: 'حضانة', icon: Icons.child_care, onTap: () {
                  // Navigate to حضانة inquiries
                }),
                InquiryCard(title: 'إرث', icon: Icons.account_balance, onTap: () {
                  // Navigate to إرث inquiries
                }),
                InquiryCard(title: 'زواج', icon: Icons.favorite, onTap: () {
                  // Navigate to زواج inquiries
                }),
                InquiryCard(title: 'زكاة', icon: Icons.attach_money, onTap: () {
                  // Navigate to زكاة inquiries
                }),
                InquiryCard(title: 'وصية', icon: Icons.gavel, onTap: () {
                  // Navigate to وصية inquiries
                }),
                InquiryCard(title: 'هبة', icon: Icons.card_giftcard, onTap: () {
                  // Navigate to هبة inquiries
                }),
                InquiryCard(title: 'مرور', icon: Icons.drive_eta, onTap: () {
                  // Navigate to مرور inquiries
                }),
              ],
            ),
          ),
        ],
      ),
    );

  }
}

class InquiryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  InquiryCard({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 8,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class AllFavoritesPage extends StatelessWidget {
  const AllFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


