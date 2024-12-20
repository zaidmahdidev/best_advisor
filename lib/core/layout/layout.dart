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
    HomeScreen(),
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
              icon: Icon(Icons.book),
              label: 'طلباتي',
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




class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('home'),);
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



