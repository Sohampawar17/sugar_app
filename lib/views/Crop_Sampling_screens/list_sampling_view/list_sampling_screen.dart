import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../constants.dart';
import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';
import 'list_sampling_model.dart';

class ListSamplingScreen extends StatelessWidget {
  const ListSamplingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListSamplingModel>.reactive(
      viewModelBuilder: () => ListSamplingModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const AutoSizeText('Crop Sampling'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.addCropSamplingScreen,
                    arguments:
                        const AddCropSamplingScreenArguments(samplingId: ""),
                  );
                },
                child: const AutoSizeText('+Add Crop Sampling')),
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
                              SizedBox(
                                width: getWidth(context) / 4,
                                child: TextField(
                                  // controller: model.idcontroller,
                                  onChanged: (value) {
                                    model.idcontroller.text = value;
                                    model.filterList("name", int.parse(value));
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'ID',
                                    prefixIcon: Icon(Icons.search),
                                    // prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5.0),
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
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AutoSizeText(
                          'Season',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white), // Set text color to white
                        ),
                        AutoSizeText(
                          'Plant Name',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.white, // Set text color to white
                          ),
                        ),
                      ],
                    ),
                    leading: SizedBox(
                      // width: getWidth(context) / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AutoSizeText(
                            'Plot No.',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white), // Set text color to white
                          ),
                          AutoSizeText(
                            'Plantation Status',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white, // Set text color to white
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                      'Name',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white), // Set text color to white
                    ),
                    subtitle: Text(
                      'Form Number',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white), // Set text color to white
                    ),
                  )),
              const SizedBox(
                height: 25,
              ),
              model.samplingList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: model.filtersamplingList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                bottom: 16.0), // Add margin between containers

                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ListTile(
                                tileColor: model.getTileColor(model
                                    .filtersamplingList[index]
                                    .plantationStatus),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    AutoSizeText(
                                      model.filtersamplingList[index].season ??
                                          '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    AutoSizeText(
                                      model.filtersamplingList[index]
                                              .plantName ??
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
                                        model.filtersamplingList[index].id ??
                                            '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      AutoSizeText(
                                        model.filtersamplingList[index]
                                                .plantationStatus ??
                                            "",
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                title: Text(
                                  model.filtersamplingList[index].name
                                      .toString(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                                subtitle: Text(
                                  model.filtersamplingList[index].formNumber ??
                                      '',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                onTap: () {
                                  // Handle row click here
                                  // _onRowClick(context, filteredList[index]);
                                  model.onRowClick(
                                      context, model.filtersamplingList[index]);
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
                        const Text("You haven't created a Crop Sampling yet"),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.addCropSamplingScreen,
                                arguments: const AddCropSamplingScreenArguments(
                                    samplingId: ""),
                              );
                            },
                            child: const Text('Create a Crop Sampling')),
                      ],
                    )
            ],
          ),
          context: context,
          loader: model.isBusy,
        ),

        // body: fullScreenLoader(
        //   context: context,
        //   loader: model.isBusy,
        //   child: Column(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: TextField(
        //           onChanged: model.filterList,
        //           decoration: const InputDecoration(
        //             labelText: 'Search',
        //             prefixIcon: Icon(Icons.search),
        //           ),
        //         ),
        //       ),
        //       Expanded(
        //         child: ListView.separated(
        //           itemCount: model.filteredList.length,
        //           itemBuilder: (context, index) {
        //             return ListTile(
        //               leading: SizedBox(
        //                 width: 120,
        //                 child: AutoSizeText(
        //                   model.filteredList[index].village ?? '',
        //                   maxLines: 2,
        //                 ),
        //               ),
        //               title: Text(
        //                 model.filteredList[index].supplierName ?? '',
        //                 style: const TextStyle(fontSize: 11),
        //               ),
        //               subtitle: Text(
        //                 model.filteredList[index].name ?? '',
        //                 style: const TextStyle(fontSize: 8),
        //               ),
        //               onTap: () {
        //                 // Handle row click here
        //                 // _onRowClick(context, filteredList[index]);
        //                 model.onRowClick(context, model.filteredList[index]);
        //               },
        //             );
        //           },
        //           separatorBuilder: (context, index) {
        //             return const Divider();
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
