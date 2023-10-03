import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/constants.dart';
import 'package:sugar_mill_app/views/agriculture_screens/list_agri_view/list_agri_model.dart';
import 'package:sugar_mill_app/widgets/full_screen_loader.dart';

import '../../../router.router.dart';

class ListAgriScreen extends StatelessWidget {
  const ListAgriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListAgriModel>.reactive(
      viewModelBuilder: () => ListAgriModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const AutoSizeText('Agriculture Development List'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.addAgriScreen,
                    arguments: const AddAgriScreenArguments(agriId: ""),
                  );
                },
                child: const AutoSizeText('+Add Cane Development')),
          ],
        ),
        body: fullScreenLoader(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 100,
                    child: Row(
                      children: [
                        SizedBox(
                          width: getWidth(context) / 1.6,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    model.namecontroller.text = value;
                                    model.filterListByNameAndVillage(
                                        name: value);
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Plot No',
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.grey,
                child: const ListTile(
                  leading: SizedBox(
                    // width: getWidth(context) / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AutoSizeText(
                          'Village',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: Colors.white), // Set text color
                        ),
                        AutoSizeText(
                          'Area In Acres',
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 8,
                              color: Colors.white), // Set text color
                        ),
                      ],
                    ),
                  ),
                  title: AutoSizeText(
                    'Name',
                    style: TextStyle(
                        fontSize: 14, color: Colors.white), // Set text color
                  ),
                  subtitle: AutoSizeText(
                    'Plantation Date',
                    style: TextStyle(
                        fontSize: 14, color: Colors.white), // Set text color
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AutoSizeText(
                        'Crop Type',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white), // Set text color
                      ),
                      AutoSizeText(
                        'Crop Variety',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 8, color: Colors.white), // Set text color
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              model.agriList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: model.filteredagriList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                bottom: 16.0), // Add margin between containers

                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ListTile(
                                tileColor: const Color(0xFFD3E8FD),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    AutoSizeText(
                                      model.filteredagriList[index].cropType ??
                                          '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    AutoSizeText(
                                      model.filteredagriList[index]
                                              .cropVariety ??
                                          '',
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                                leading: SizedBox(
                                  width: getWidth(context) / 5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      AutoSizeText(
                                        model.filteredagriList[index].village ??
                                            '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      AutoSizeText(
                                        model.filteredagriList[index].area
                                            .toString(),
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                title: Text(
                                  model.filteredagriList[index].name.toString(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                                subtitle: Text(
                                  model.filteredagriList[index].date ?? '',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                onTap: () {
                                  // Handle row click here
                                  // _onRowClick(context, filteredList[index]);
                                  model.onRowClick(
                                      context, model.filteredagriList[index]);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                            "You haven't created a Agriculture development  yet"),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.addAgriScreen,
                                arguments:
                                    const AddAgriScreenArguments(agriId: ""),
                              );
                            },
                            child: const Text('Create a Cane Development')),
                      ],
                    )
            ],
          ),
          context: context,
          loader: model.isBusy,
        ),
      ),
    );
  }
}
