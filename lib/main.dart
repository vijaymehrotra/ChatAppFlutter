// Copyright 2019 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xhat_app/chat_page.dart';
import 'package:xhat_app/counter_stateful_demo.dart';
import 'package:xhat_app/login_page.dart';
import 'package:xhat_app/services/auth_service.dart';
import 'package:xhat_app/utils/brand_color.dart';
// import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => AuthService(),
    child: ChatApp(),
  ));
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          canvasColor: Colors.transparent,
          primarySwatch: Colors.deepPurple,
          appBarTheme: AppBarTheme(
              foregroundColor: Colors.black, backgroundColor: Colors.blue)),
      title: "Chat App!!",
      home: FutureBuilder<bool>(
          future: context.read<AuthService>().isLoggedIn(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!) {
                return ChatPage();
              } else {
                return LoginPage();
              }
            }
            return CircularProgressIndicator();
          }),
      routes: {
        '/chat': (context) => ChatPage(),
      },
    );
  }
}
