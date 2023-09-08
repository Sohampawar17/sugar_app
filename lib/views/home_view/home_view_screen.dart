import 'package:flutter/material.dart';
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
              image: NetworkImage(
                imagePath,
              ),
              height: 180,
              fit: BoxFit.fill,
              width: 400,
            ),
            Text(
              buttonText,
              style: const TextStyle(fontSize: 25, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.factory_outlined),
          title: Text(
            'Venkateshwara Power Project',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => model.logout(context),
            ),
          ],
        ),
        body: fullScreenLoader(
          loader: model.isBusy,
          context: context,
          child: SingleChildScrollView(
            child: Center(
              child: Hero(
                tag: "TITLE",
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                  imagePath:
                                      'https://www.thestatesman.com/wp-content/uploads/2020/05/farmer.jpg',
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
                                width: 30.0,
                              ),
                              Expanded(
                                child: _buildImageButton(
                                  imagePath:
                                      'https://cdn4.vectorstock.com/i/1000x1000/93/58/sheet-text-icon-vector-45499358.jpg',
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
                          height: 10.0,
                        ),
                        SizedBox(
                          height: getHeight(context) / 5,
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildImageButton(
                                  imagePath:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSsj54U7Hm52ILH-WPkLLtkOjhQIQNkn59vhxvJOQSTiH8BofuFlz3_zbBQOfp8W6E8uI&usqp=CAU',
                                  buttonText: 'New Cane Registration',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.addCaneScreen,
                                      arguments: const AddCaneScreenArguments(
                                          caneId: ""),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 30.0,
                              ),
                              Expanded(
                                child: _buildImageButton(
                                  imagePath:
                                      'https://cdn4.vectorstock.com/i/1000x1000/93/58/sheet-text-icon-vector-45499358.jpg',
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
                          height: 10.0,
                        ),
                        SizedBox(
                          height: getHeight(context) / 5,
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildImageButton(
                                  imagePath:
                                      'https://agriculturedev.com/wp-content/uploads/2017/08/logo@2x.png',
                                  buttonText: 'New Agriculture Development',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.addAgriScreen,
                                      arguments: const AddAgriScreenArguments(
                                          agriId: ""),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 30.0,
                              ),
                              Expanded(
                                child: _buildImageButton(
                                  imagePath:
                                      'https://cdn4.vectorstock.com/i/1000x1000/93/58/sheet-text-icon-vector-45499358.jpg',
                                  buttonText: 'Agriculture List',
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
                          height: 10.0,
                        ),
                        SizedBox(
                          height: getHeight(context) / 5,
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildImageButton(
                                  imagePath:
                                      'https://storwukenticomedia.blob.core.windows.net/media/wfu/media/images/insightimages/winfieldunited_tissuetesting_april2019.jpg?ext=.jpg',
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
                                width: 30.0,
                              ),
                              Expanded(
                                child: _buildImageButton(
                                  imagePath:
                                      'https://cdn4.vectorstock.com/i/1000x1000/93/58/sheet-text-icon-vector-45499358.jpg',
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
                          height: 10.0,
                        ),
                        SizedBox(
                          height: getHeight(context) / 5,
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildImageButton(
                                  imagePath:
                                      'https://fl-i.thgim.com/public/other/nbe0q2/article37718586.ece/alternates/LANDSCAPE_1200/fl17sugarcane',
                                  buttonText: 'New Trip Sheet',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.addTripsheetScreen,
                                      arguments:
                                          const AddTripsheetScreenArguments(
                                              tripId: ""),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 30.0,
                              ),
                              Expanded(
                                child: _buildImageButton(
                                  imagePath:
                                      'https://cdn4.vectorstock.com/i/1000x1000/93/58/sheet-text-icon-vector-45499358.jpg',
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
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) => model.initialise(context),
    );
  }
}
