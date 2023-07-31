import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/views/login_view/login_view_model.dart';
import 'package:sugar_mill_app/widgets/full_screen_loader.dart';

class LoginViewScreen extends StatefulWidget {
  const LoginViewScreen({super.key});

  @override
  State<LoginViewScreen> createState() => _LoginViewScreenState();
}

class _LoginViewScreenState extends State<LoginViewScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onViewModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Login to App'),
        ),
        body: fullScreenLoader(
          context: context,
          loader: model.isloading,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            child: Form(
              key: model.formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: model.usernameController,
                    focusNode: model.focusNode,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: (value) => model.validateUsername(value),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: model.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) => model.validatePassword(value),
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (model.formGlobalKey.currentState!.validate()) {
                        model.formGlobalKey.currentState!.save();
                        model.loginwithUsernamePassword(context);
                      }
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
