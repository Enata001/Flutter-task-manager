import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/userdata.dart';
import 'package:task_manager/providers/auth_provider.dart';
import 'package:task_manager/services/auth_service.dart';
import 'package:task_manager/utils/extensions.dart';

import '../../../utils/dimensions.dart';
import '../../../utils/navigation.dart';
import 'celevated_button.dart';
import 'ctextfield.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late FocusNode firstFocus;
  late FocusNode secondFocus;

  get userProvider => context.read<AuthProvider>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    firstFocus = FocusNode();
    secondFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    firstFocus.dispose();
    secondFocus.dispose();
  }

  bool isNotVisible = true;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Hello, welcome back!",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: Dimensions.mediumSpace,
          ),
          Text(
            'Log in to continue',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          CTextField(
            hintText: 'Username',
            textInputType: TextInputType.text,
            controller: usernameController,
            validator: (value) => validateText(value),
            focusNode: firstFocus,
            inputAction: TextInputAction.next,
            onSubmitted: (e) async{
              firstFocus.nextFocus();
            },
          ),
          CTextField(
            hintText: 'Password',
            textInputType: TextInputType.text,
            isPassword: isNotVisible,
            controller: passwordController,
            icon: isNotVisible ? Icons.lock : Icons.lock_open_rounded,
            inputAction: TextInputAction.go,
            onSubmitted: (e) async => login(),
            action: () {
              isNotVisible = !isNotVisible;
              setState(() {});
            },
            validator: (value) => validateText(value),
            focusNode: secondFocus,
          ),
          const SizedBox(
            height: Dimensions.mediumSpace,
          ),
          CElevatedButton(
            title: isLoading ? 'Loading...' : 'Sign In',
            action: () async => login(),
          ),
        ],
      ),
    );
  }

  void login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final result = await AuthService().login(
          usernameController.text.trim(), passwordController.text.trim(),
          onFailure: () => showError(context));
      if (result != null) {
        await userProvider.saveUserinfo(user: Userdata.fromMap(result));
        Navigation.goTo(Navigation.home);
      } else {}
      setState(() {
        isLoading = false;
      });
    }
  }

  String? validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void showError(BuildContext context) {
    context.messenger(
      title: 'Error',
      description: 'Something went wrong. please try again',
      icon: Icons.error_outline,
    );
  }
}
