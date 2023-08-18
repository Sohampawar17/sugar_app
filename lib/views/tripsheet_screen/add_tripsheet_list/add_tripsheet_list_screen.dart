import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/widgets/full_screen_loader.dart';

import '../../../constants.dart';
import 'add_tripsheet_list_model.dart';

class TripsheetMaster extends StatelessWidget {
  const TripsheetMaster({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListTripsheet>.reactive(
      viewModelBuilder: () => ListTripsheet(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Trip Sheet Master'),
        ),
        body: fullScreenLoader(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 150,
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: getWidth(context) / 4,
                                      child: TextField(
                                        // controller: model.villageController,
                                        onChanged: (value) {
                                          model.idcontroller.text = value;
                                          model.filterList(
                                              "name", int.parse(value));
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'ID',
                                          prefixIcon: Icon(Icons.search),
                                          // prefixIcon: Icon(Icons.search),
                                        ),
                                      ),
                                    ),
                                    // child: TextField(
                                    //   onChanged: (value) {
                                    //     model.idcontroller.text = value;
                                    //     model.filterList(
                                    //         "name", int.parse(value));
                                    //   },
                                    //   decoration: const InputDecoration(
                                    //       labelText: 'Id',
                                    //       icon: Icon(Icons.search)),
                                    // ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Expanded(
                                    child: TextField(
                                        // controller: model.villageController,
                                        onChanged: (value) {
                                          model.namecontroller.text = value;
                                          model.filterListByNameAndVillage(
                                              village: value);
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Village',
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  SizedBox(
                                    width: getWidth(context) / 4,
                                    child: TextField(
                                      // controller: model.villageController,
                                      onChanged: (value) {
                                        model.namecontroller.text = value;
                                        model.filterListByNameAndVillage(
                                            transName: value);
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Transporter',

                                        // prefixIcon: Icon(Icons.search),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      // controller: model.villageController,
                                      onChanged: (value) {
                                        model.namecontroller.text = value;
                                        model.filterListByNameAndVillage(
                                            season: value);
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Season',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const ListTile(
                  tileColor: Colors.black45,
                  trailing: AutoSizeText(
                    "Circle Office",
                    maxLines: 2,
                  ),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          'ID',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Expanded(
                        child: AutoSizeText(
                          'Village',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    'Transporter Name',
                    style: TextStyle(fontSize: 11),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        'Farmer Name',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: model.tripSheetFilter.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListTile(
                            tileColor: Color(0xFFD3E8FD),
                            trailing: AutoSizeText(
                              model.tripSheetFilter[index].circleOffice ?? '',
                              maxLines: 2,
                            ),
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: AutoSizeText(
                                    model.tripSheetFilter[index].name
                                        .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    model.tripSheetFilter[index].fieldVillage ??
                                        '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              model.tripSheetFilter[index].transporterName ??
                                  '',
                              style: TextStyle(fontSize: 11),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  model.tripSheetFilter[index].farmerName ?? '',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                            onTap: () {
                              model.onRowClick(
                                  context, model.tripSheetFilter[index]);
                            },
                          )
                          // ListTile(
                          //   // tileColor: model.getTileColor(
                          //   //     model.canefilterList[index].plantationStatus),
                          //   trailing: AutoSizeText(
                          //     model.canefilterList[index].area ?? '',
                          //     maxLines: 2,
                          //   ),
                          //   leading: SizedBox(
                          //     width: getWidth(context) / 5,
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //       children: [
                          //         AutoSizeText(
                          //           model.canefilterList[index].circleOffice ??
                          //               '',
                          //           maxLines: 1,
                          //           overflow: TextOverflow.ellipsis,
                          //         ),
                          //         AutoSizeText(
                          //           model.canefilterList[index]
                          //                   .plantationStatus ??
                          //               '',
                          //           maxLines: 2,
                          //           style: const TextStyle(
                          //             fontSize: 8,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          //   title: Text(
                          //     model.canefilterList[index].growerName ?? '',
                          //     style: const TextStyle(fontSize: 11),
                          //   ),
                          //   subtitle: Row(
                          //     children: [
                          //       Text(
                          //         model.canefilterList[index].name.toString(),
                          //         style: const TextStyle(fontSize: 8),
                          //       ),
                          //       const SizedBox(
                          //         width: 35,
                          //       ),
                          //       Text(
                          //         model.canefilterList[index]
                          //                 .plantattionRatooningDate ??
                          //             '',
                          //         style: const TextStyle(fontSize: 8),
                          //       ),
                          //     ],
                          //   ),
                          //   onTap: () {
                          //     // Handle row click here
                          //     // _onRowClick(context, filteredList[index]);
                          //     model.onRowClick(
                          //         context, model.canefilterList[index]);
                          //   },
                          // ),
                          );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.white, // Color of the line
                        thickness: 0, // Thickness of the line
                      );
                    },
                  ),
                ),
              ],
            ),
            loader: model.isBusy,
            context: context),
      ),
    );
  }
}
