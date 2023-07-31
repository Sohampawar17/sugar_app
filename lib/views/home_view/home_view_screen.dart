import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/views/home_view/home_view_model.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Hero(
            tag: "TITLE",
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Welcome to Flutter!'),
                    Image.network(
                        'https://w.wallhaven.cc/full/ex/wallhaven-exwgmr.png'),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter your name',
                      ),
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter your email address',
                        hintText: 'example@email.com',
                      ),
                    ),
                    const TextField(
                      decoration:
                          InputDecoration(labelText: 'Enter your password'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomePageModel(),
      onViewModelReady: (model) => model.initialise(),
    );
  }
}
