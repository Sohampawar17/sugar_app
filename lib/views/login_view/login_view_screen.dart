// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart'; // Import for handling gestures
// import 'package:stacked/stacked.dart';
// import 'package:sugar_mill_app/views/login_view/login_view_model.dart';
// import 'package:sugar_mill_app/widgets/full_screen_loader.dart';
//
// class LoginViewScreen extends StatefulWidget {
//   const LoginViewScreen({super.key});
//
//   @override
//   State<LoginViewScreen> createState() => _LoginViewScreenState();
// }
//
// class _LoginViewScreenState extends State<LoginViewScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<LoginViewModel>.reactive(
//       viewModelBuilder: () => LoginViewModel(),
//       onViewModelReady: (model) => model.initialise(),
//       builder: (context, model, child) => Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text('Login to App'),
//         ),
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color(0xFF536DFE), // Adjust color values as needed
//                 Color(0xFF26C6DA),
//               ],
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(
//                       16.0,
//                     ),
//                     child: Form(
//                       key: model.formGlobalKey,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Image.asset(
//                             'assets/logo.png', // Adjust the path to your logo image
//                             height: 100,
//                             width: 100,
//                           ),
//                           const SizedBox(height: 50.0),
//                           TextFormField(
//                             controller: model.usernameController,
//                             focusNode: model.focusNode,
//                             decoration: InputDecoration(
//                               labelText: 'Username',
//                               filled: true,
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               prefixIcon: Icon(
//                                   Icons.person), // Icon for the username field
//                             ),
//                             validator: (value) => model.validateUsername(value),
//                           ),
//                           const SizedBox(height: 16.0),
//                           TextFormField(
//                             controller: model.passwordController,
//                             obscureText: model.obscurePassword,
//                             decoration: InputDecoration(
//                               labelText: 'Password',
//                               filled: true,
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               prefixIcon: Icon(
//                                   Icons.lock), // Icon for the password field
//                               suffixIcon: InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     model.obscurePassword =
//                                         !model.obscurePassword;
//                                   });
//                                 },
//                                 child: Icon(
//                                   model.obscurePassword
//                                       ? Icons.visibility
//                                       : Icons.visibility_off,
//                                 ),
//                               ),
//                             ),
//                             validator: (value) => model.validatePassword(value),
//                           ),
//                           const SizedBox(height: 32.0),
//                           ElevatedButton(
//                             onPressed: () {
//                               FocusManager.instance.primaryFocus?.unfocus();
//                               if (model.formGlobalKey.currentState!
//                                   .validate()) {
//                                 model.formGlobalKey.currentState!.save();
//                                 model.loginwithUsernamePassword(context);
//                               }
//                             },
//                             child: const Text('Login'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors
//                     .transparent, // Transparent color to cover the background
//                 padding: const EdgeInsets.all(16.0),
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: RichText(
//                     text: TextSpan(
//                       text: 'Copyright © 2023 Your Company ',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                       ),
//                       children: [
//                         TextSpan(
//                           text: 'Visit our website',
//                           style: TextStyle(
//                             decoration: TextDecoration.underline,
//                             color: Colors.blue,
//                           ),
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () {
//                               // Navigate to the company website
//                               // Replace 'https://www.example.com' with the actual website URL
//                               // You can use the launch() function from the url_launcher package
//                             },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:url_launcher/url_launcher.dart';

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
            body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue, // Adjust color values as needed
                      Colors.lightBlueAccent,
                    ],
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: fullScreenLoader(
                          context: context,
                          loader: model.isloading,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 32.0),
                            child: Form(
                              key: model.formGlobalKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Icon(Icons.person, size: 100),
                                  const SizedBox(height: 50.0),
                                  TextFormField(
                                    controller: model.usernameController,
                                    focusNode: model.focusNode,
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      prefixIcon: Icon(Icons
                                          .person), // Icon for the username field
                                    ),
                                    validator: (value) =>
                                        model.validateUsername(value),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: model.passwordController,
                                    obscureText: model.obscurePassword,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      prefixIcon: Icon(Icons
                                          .lock), // Icon for the password field
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          setState(() {
                                            model.obscurePassword =
                                                !model.obscurePassword;
                                          });
                                        },
                                        child: Icon(
                                          model.obscurePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                    ),
                                    validator: (value) =>
                                        model.validatePassword(value),
                                  ),
                                  const SizedBox(height: 16.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      if (model.formGlobalKey.currentState!
                                          .validate()) {
                                        model.formGlobalKey.currentState!
                                            .save();
                                        model
                                            .loginwithUsernamePassword(context);
                                      }
                                    },
                                    child: const Text('Login'),
                                  ),
                                  const SizedBox(height: 16.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            const url =
                                'https://erpdata.in/'; // Replace with your actual website URL
                            if (await canLaunchUrl(url as Uri)) {
                              await launchUrl(url as Uri);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            'Developed By ©  QuantBit Technologies Pvt. Ltd ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ]))));
  }
}
