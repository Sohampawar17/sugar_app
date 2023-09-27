import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/constants.dart';
import 'package:sugar_mill_app/views/home_view/home_view_model.dart';
import 'package:sugar_mill_app/widgets/full_screen_loader.dart';

import '../../router.router.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  // Helper function to create a button with an image and text
  Widget _buildImageButton({
    required String imagePath,
    required String buttonText,
    required Function onPressed,
  }) {
    return Material(
      color: Colors.white,
      elevation: 8,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () => onPressed(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ink.image(
              image: AssetImage(
                imagePath,
              ),
              height: 120,
              fit: BoxFit.fill,
              width: 300,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  buttonText,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final String employeeName = "John Doe";
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.greenAccent.shade200,
        appBar: AppBar(
          leading: const Icon(Icons.factory_outlined),
          title: const Text(
            'Venkateshwara Power Project',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => model.logout(context),
            ),
          ],
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(100.0), // Set the preferred height
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome, ${model.empname}",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome, $employeeName",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    showModalBottomSheet(
                      enableDrag: false,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Text(
                                  DateFormat('hh:mm:ss a')
                                      .format(DateTime.now()),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  DateFormat('dd MMM, yyyy')
                                      .format(DateTime.now()),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              MaterialButton(
                                onPressed: () {
                                  // Add your check-in logic here
                                  Navigator.of(context)
                                      .pop(); // Close the bottom sheet
                                },
                                minWidth: 150.0, // Set the custom width
                                height: 48.0, // Set the button height
                                color: Colors.green, // Set the button color
                                textColor: Colors.white, // Set the text color
                                child: Text(
                                  "Check In",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  minWidth: 200.0, // Set the custom width
                  height: 48.0, // Set the button height
                  color: Colors.green, // Set the button color
                  textColor: Colors.white, // Set the text color
                  child: const Text(
                    "Check In ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
        body: fullScreenLoader(
          loader: model.isBusy,
          context: context,
          child: SingleChildScrollView(
            child: Hero(
              tag: "TITLE",
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: getHeight(context) / 5,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildImageButton(
                              imagePath: 'assets/images/farmer.jpg',
                              buttonText: 'New Farmer',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.addFarmerScreen,
                                  arguments: const AddFarmerScreenArguments(
                                      farmerid: ""),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: _buildImageButton(
                              imagePath: 'assets/images/farmer_list.jpg',
                              buttonText: 'Farmer List',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.listFarmersScreen,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: getHeight(context) / 5,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildImageButton(
                              imagePath: 'assets/images/cane_registration.jpeg',
                              buttonText: 'New Cane Registration',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.addCaneScreen,
                                  arguments:
                                      const AddCaneScreenArguments(caneId: ""),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: _buildImageButton(
                              imagePath: 'assets/images/cane_list.jpg',
                              buttonText: 'Cane Master List',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.listCaneScreen,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: getHeight(context) / 5,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildImageButton(
                              imagePath: 'assets/images/agri_developement.jpg',
                              buttonText: 'New Cane Development',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.addAgriScreen,
                                  arguments:
                                      const AddAgriScreenArguments(agriId: ""),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: _buildImageButton(
                              imagePath: 'assets/images/agri_list.jpg',
                              buttonText: 'Agriculture Develop List',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.listAgriScreen,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: getHeight(context) / 5,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildImageButton(
                              imagePath: 'assets/images/crop_sampling.jpg',
                              buttonText: 'New Crop Sampling',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.addCropSamplingScreen,
                                  arguments:
                                      const AddCropSamplingScreenArguments(
                                          samplingId: ""),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: _buildImageButton(
                              imagePath: 'assets/images/crop_sample_list.jpg',
                              buttonText: 'Crop Sampling List',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.listSamplingScreen,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: getHeight(context) / 5,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildImageButton(
                              imagePath: 'assets/images/trip_sheet.webp',
                              buttonText: 'New Trip Sheet',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.addTripsheetScreen,
                                  arguments: const AddTripsheetScreenArguments(
                                      tripId: ""),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: _buildImageButton(
                              imagePath: 'assets/images/trip_list.jpg',
                              buttonText: 'Trip Sheet List',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.tripsheetMaster,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) => model.initialise(context),
    );
  }
}
