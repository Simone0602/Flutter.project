import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progetto/pages/login_page.dart';

class EnterPage extends StatelessWidget {
  const EnterPage({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {Get.to(LoginPage());});
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                        Text(
                          'Prova',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                    ]
                )
            )
        ]
      )
    );
  }
}