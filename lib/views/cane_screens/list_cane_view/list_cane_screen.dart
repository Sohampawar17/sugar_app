import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/views/cane_screens/list_cane_view/list_cane_model.dart';
import 'package:sugar_mill_app/widgets/full_screen_loader.dart';

import '../../../constants.dart';
import '../../../router.router.dart';
import '../../../widgets/cdrop_down_widget.dart';

class ListCaneScreen extends StatelessWidget {
  const ListCaneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListCaneModel>.reactive(
      viewModelBuilder: () => ListCaneModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const AutoSizeText('Cane Master'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.addCaneScreen,
                      arguments: const AddCaneScreenArguments(caneId: ""),
                    );
                  },
                  child: const AutoSizeText('+Add Cane Master')),
            )
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
                        Expanded(
                          child: CdropDown(
                            dropdownButton: DropdownButtonFormField<String>(
                              isExpanded: true,
                              // Replace null with the selected value if needed
                              decoration: const InputDecoration(
                                labelText: 'Season',
                              ),
                              hint: const Text('Select Season'),
                              items: model.seasonlist.map((val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              }).toList(),
                              onChanged: (value) {
                                model.namecontroller.text = value ?? "";
                                model.filterListByNameAndVillage(
                                    village: value);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
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
                                    labelText: 'Name',
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              SizedBox(
                                width: getWidth(context) / 4,
                                child: TextField(
                                  // controller: model.villageController,
                                  onChanged: (value) {
                                    model.idcontroller.text = value;
                                    model.filterList("name", int.parse(value));
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'ID',

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
                    children: [
                      AutoSizeText(
                        'Village',
                        maxLines: 2,
                        style: TextStyle(color: Colors.white),
                      ),
                      AutoSizeText(
                        'Plantation Date',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AutoSizeText(
                        'Circle Office',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                      AutoSizeText(
                        'Plantation Status',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  title: AutoSizeText(
                    'Name',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: AutoSizeText(
                    'ID',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              model.caneList.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                        itemCount: model.canefilterList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ListTile(
                              tileColor: model.getTileColor(
                                  model.canefilterList[index].plantationStatus),
                              trailing: AutoSizeText(
                                model.canefilterList[index].area ?? '',
                                maxLines: 2,
                              ),
                              leading: SizedBox(
                                width: getWidth(context) / 5,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    AutoSizeText(
                                      model.canefilterList[index]
                                              .circleOffice ??
                                          '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    AutoSizeText(
                                      model.canefilterList[index]
                                              .plantationStatus ??
                                          '',
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              title: Text(
                                model.canefilterList[index].growerName ?? '',
                                style: const TextStyle(fontSize: 14),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    model.canefilterList[index].name.toString(),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(
                                    width: 35,
                                  ),
                                  Text(
                                    model.canefilterList[index]
                                            .plantattionRatooningDate ??
                                        '',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              onTap: () {
                                // Handle row click here
                                // _onRowClick(context, filteredList[index]);
                                model.onRowClick(
                                    context, model.canefilterList[index]);
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Colors.white, // Color of the line
                            thickness: 0, // Thickness of the line
                          );
                        },
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("You haven't created a Cane Master yet"),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.addCaneScreen,
                                arguments:
                                    const AddCaneScreenArguments(caneId: ""),
                              );
                            },
                            child: const Text('Create a  Cane Master')),
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
