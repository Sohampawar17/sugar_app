import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/constants.dart';
import 'package:sugar_mill_app/views/list_farmers_view/list_farmers_model.dart';
import 'package:sugar_mill_app/widgets/full_screen_loader.dart';

class ListFarmersScreen extends StatelessWidget {
  const ListFarmersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListFarmersModel>.reactive(
      viewModelBuilder: () => ListFarmersModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Farmers'),
        ),
        body: fullScreenLoader(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            model.nameController.text = value;
                            model.filterList(value, "supplier_name");
                          },
                          decoration: const InputDecoration(
                            labelText: 'Search by Name',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      // TextField(
                      //   // controller: _vendorIdController,
                      //   // onChanged: (value) {
                      //   //   _filterList(_nameController.text, value,
                      //   //       _villageController.text);
                      //   // },
                      //   decoration: InputDecoration(
                      //     labelText: 'Search by Vendor ID',
                      //     prefixIcon: Icon(Icons.search),
                      //   ),
                      // ),
                      // SizedBox(
                      //     width: getWidth(context) / 2,
                      //     child: Row(
                      //       children: [
                      SizedBox(
                        width: getWidth(context) / 2.3,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                // controller: model.villageController,
                                onChanged: (value) {
                                  model.villageController.text = value;
                                  model.filterList(value, "name");
                                },
                                decoration: InputDecoration(
                                  labelText: 'ID',
                                  // prefixIcon: Icon(Icons.search),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            Expanded(
                              child: TextField(
                                // controller: model.villageController,
                                onChanged: (value) {
                                  model.villageController.text = value;
                                  model.filterList(value, "village");
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Village',
                                  // prefixIcon: Icon(Icons.search),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      //         TextField(
                      //           // controller: model.villageController,
                      //           onChanged: (value) {
                      //             model.villageController.text = value;
                      //             model.filterList(value, "village");
                      //           },
                      //           decoration: const InputDecoration(
                      //             labelText: 'Search by Village',
                      //             prefixIcon: Icon(Icons.search),
                      //           ),
                      //         ),
                      //       ],
                      //     )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: model.filteredList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: SizedBox(
                        width: 120,
                        child: AutoSizeText(
                          model.filteredList[index].village ?? '',
                          maxLines: 2,
                        ),
                      ),
                      title: Text(
                        model.filteredList[index].supplierName ?? '',
                        style: const TextStyle(fontSize: 11),
                      ),
                      subtitle: Text(
                        model.filteredList[index].name ?? '',
                        style: const TextStyle(fontSize: 8),
                      ),
                      onTap: () {
                        // Handle row click here
                        // _onRowClick(context, filteredList[index]);
                        model.onRowClick(context, model.filteredList[index]);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
              ),
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
