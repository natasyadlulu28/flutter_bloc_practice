import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_practice/ui/pages/pages.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_bloc_practice/bloc/textlabel_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'ui/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInPage());
  }
}


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BlocProvider<ChangeTextlBloc>(
//           create: (context) => ChangeTextBloc(ChangeTextState("Hi")),
//           child: HomePage()),
//     );
//   }
// }
