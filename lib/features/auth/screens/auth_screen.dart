import 'package:flutter/material.dart';
import 'package:task_manager/features/auth/widgets/sign_in.dart';
import 'package:task_manager/utils/dimensions.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05,
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/tasks-app.png',scale: 2,),
              const SizedBox(
                height: Dimensions.smallSpace,
              ),
              const SignIn(),
            ],
          ),
        ),
      ),
    );
  }
}
