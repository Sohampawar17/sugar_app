import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/views/home_view/home_view_model.dart';
import 'package:sugar_mill_app/widgets/full_screen_loader.dart';

import '../../router.router.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: fullScreenLoader(
          loader: model.isBusy,
          context: context,
          child: SingleChildScrollView(
            child: Center(
              child: Hero(
                tag: "TITLE",
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100.0,
                        ),
                        const Text('HOME'),
                        // Image.network(
                        //     'https://w.wallhaven.cc/full/ex/wallhaven-exwgmr.png'),
                        // const TextField(
                        //   decoration: InputDecoration(
                        //     labelText: 'Enter your name',
                        //   ),
                        // ),
                        // const TextField(
                        //   decoration: InputDecoration(
                        //     labelText: 'Enter your email address',
                        //     hintText: 'example@email.com',
                        //   ),
                        // ),
                        // const TextField(
                        //   decoration:
                        //       InputDecoration(labelText: 'Enter your password'),
                        // ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              model.getGeoLocation();
                            },
                            child: const Text("Fetch Location"),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.addFarmerScreen,
                                arguments: const AddFarmerScreenArguments(
                                    farmerid: ""),
                              );
                            },
                            child: const Text("Add new farmer"),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.listFarmersScreen,
                              );
                            },
                            child: const Text("List all farmer"),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.addCaneScreen,
                                arguments:
                                    const AddCaneScreenArguments(caneId: ""),
                              );
                            },
                            child: const Text("Add new cane registration"),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.listCaneScreen);
                            },
                            child: const Text("List Cane Master"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) => model.initialise(),
    );
  }
}
