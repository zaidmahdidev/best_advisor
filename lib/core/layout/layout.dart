import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newproject/core/layout/widget/drawer.dart';
import 'package:newproject/core/utils/my_extentions.dart';
import 'package:newproject/features/chatgpt/presentation/page/chatgpt.dart';
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
    CartPage(),
    CartPage(),
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
                padding: const EdgeInsets.all(2),
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
  final List<String> images = [
    Images.logo,
    Images.logo,
    Images.logo,
    Images.logo,
  ];

  final List<String> inquiryTitles = [
    'حضانة',
    'إرث',
    'زواج',
    'زكاة',
    'استشارة 1',
    'استشارة 2',
    'استشارة 3',
    'استشارة 3',
    'استشارة 3',
    // يمكنك إضافة المزيد من العناوين
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: const EdgeInsets.only(right: 5),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(Images.logo),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Badge(
              label: Text('10'),
              backgroundColor: CupertinoColors.destructiveRed,
              child: Icon(Icons.notifications),
            ),
          ),
          IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: Icon(Icons.menu),
          ),
        ],
        title: Text('المستشار الأمثل'),
      ),
      body: ListView(
        children: [
          CarouselSlider(
            items: images.map((image) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
            ),
          ),
          _buildInquirySection(context, 'الاستفسارات', inquiryTitles),

          _buildInquirySection(context, 'الاستشارات', inquiryTitles),
        ],
      ),
    );
  }

  Widget _buildInquirySection(BuildContext context, String title, List<String> titles) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(padding: EdgeInsets.all(10),
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 1.3,
                        children: titles.map((title) {
                          return InquiryCard(title: title, onTap: () {
                            // Navigate to inquiry details
                          });
                        }).toList(),
                      ),
                      );
                    },
                  );
                },
                child: Text('عرض الكل'),
              ),
            ],
          ),
          // عرض 4 استفسارات فقط
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.3,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: titles.take(4).map((title) {
              return InquiryCard(title: title, onTap: () {
                // Navigate to inquiry details
              });
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class InquiryCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  InquiryCard({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      onTap: () => context.push(BotScreen()),
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Image.asset(Images.logo, width: double.infinity, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

