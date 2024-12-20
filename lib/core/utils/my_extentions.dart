import 'package:flutter/material.dart';


extension MediaQueryHelper on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.height;
}


extension IntExtension on int{
  int validate({int value =0}){
    return this ?? value;
  }
  Widget get SH => SizedBox(
    height: this?.toDouble(),
  );
  Widget get SW => SizedBox(
    width: this?.toDouble(),
  );
}
/////   how to use /////
//   5.SH,
//   5.SW,


//  //////////////////  navigator //////////////////////////
extension NavigatorHelper on BuildContext {
  // دفع صفحة جديدة إلى مكدس التنقل
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(builder: (context) => page),
    );
  }


  // استبدال الصفحة الحالية بصفحة جديدة
  Future<T?> pushReplacement<T, TO>(Widget page) {
    return Navigator.of(this).pushReplacement<T, TO>(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // دفع صفحة جديدة وإزالة جميع الصفحات السابقة حتى الصفحة المحددة
  Future<T?> pushAndRemoveUntil<T>(Widget page, RoutePredicate predicate) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (context) => page),
      predicate,
    );
  }

  // الرجوع إلى الصفحة السابقة
  void pop<T>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  // إغلاق جميع الصفحات حتى الصفحة المحددة
  void popUntil(RoutePredicate predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  // عرض صفحة محددة كنافذة حوارية
  Future<T?> showDialog<T>(Widget dialog) {
    return showGeneralDialog<T>(
      context: this,
      pageBuilder: (context, animation, secondaryAnimation) => dialog,
    );
  }
}

//  //////////////////  how to use  //////////////////////////
// context.push(NewPage());
//context.pushReplacement(NewPage());
//context.pushAndRemoveUntil(NewPage(), (route) => false); // لإزالة جميع الصفحات السابقة
//context.pop();
//context.pop();

//context.showDialog(AlertDialog(
//   title: Text('Dialog Title'),
//   content: Text('This is a dialog.'),
//   actions: <Widget>[
//     TextButton(
//       onPressed: () {
//         context.pop(); // لإغلاق النافذة الحوارية
//       },
//       child: Text('OK'),
//     ),
//   ],
// ));




/////////////////////////// Snackbar //////////////////////////////


extension SnackbarHelper on BuildContext {
  void showSnackbar(String message, {Duration duration = const Duration(seconds: 3)}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }
}

/////////////////////////// how to use //////////////////////////////
//context.showSnackbar('This is a snackbar message');





