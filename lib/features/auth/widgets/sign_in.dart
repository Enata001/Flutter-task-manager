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

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  bool isNotVisible = true;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);
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
              hintText: 'username',
              textInputType: TextInputType.text,
              controller: usernameController,
              validator: (value) => validateText(value)),
          CTextField(
              hintText: 'Password',
              textInputType: TextInputType.text,
              isPassword: isNotVisible,
              controller: passwordController,
              icon: isNotVisible ? Icons.lock : Icons.lock_open_rounded,
              action: () {
                isNotVisible = !isNotVisible;
                setState(() {});
              },
              validator: (value) => validateText(value)),
          const SizedBox(
            height: Dimensions.mediumSpace,
          ),
          CElevatedButton(
            title: isLoading ? 'Loading...' : 'Sign In',
            action: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                });
                final result = await AuthService().login(
                    usernameController.text.trim(),
                    passwordController.text.trim(),
                    onFailure: () => showError(context));
                if (result != null) {
                  await userProvider.saveUserinfo(
                      user: Userdata.fromMap(result));
                  Navigation.goTo(Navigation.home);
                } else {}
                setState(() {
                  isLoading = false;
                });
              }
            },
          ),
        ],
      ),
    );
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
