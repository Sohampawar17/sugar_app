import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/ctext_button.dart';
import '../../../widgets/full_screen_loader.dart';
import 'add_crop_sampling_model.dart';

class AddCropSamplingScreen extends StatelessWidget {
  const AddCropSamplingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddCropSmaplingModel>.reactive(
        viewModelBuilder: () => AddCropSmaplingModel(),
        onViewModelReady: (model) => model.initialise(context),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: const Text('Agriculture development'),
            ),
            body: fullScreenLoader(
              child: SingleChildScrollView(
                child: Form(
                  key: model.formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      Autocomplete<String>(
                        key: Key(model.cropsamplingdata.id ?? "id"),
                        initialValue: TextEditingValue(
                          text: model.cropsamplingdata.id ?? "",
                        ),
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          return model.plotList
                              .map((route) => route.name.toString())
                              .toList()
                              .where((route) => route.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase()));
                        },
                        onSelected: model.setSelectedplot,
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted) {
                          return TextFormField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                              labelText: 'Plot number',
                            ),
                            onChanged: (String value) {},
                            validator: model.validateplotNumber,
                          );
                        },
                        optionsViewBuilder: (BuildContext contpext,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              elevation: 4.0,
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxHeight: 200),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final String option =
                                        options.elementAt(index);
                                    final routeData = model.plotList.firstWhere(
                                        (route) =>
                                            route.name.toString() == option);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(routeData.name
                                            .toString()); // Send the name as the selected route
                                      },
                                      child: ListTile(
                                        title: Text(option),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        optionsMaxHeight: 200,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              key: Key(
                                  model.cropsamplingdata.brixBottom.toString()),
                              initialValue:
                                  model.cropsamplingdata.brixBottom.toString(),
                              decoration: const InputDecoration(
                                labelText: 'Brix Bottom',
                              ),
                              onChanged: model.setSelectedbrixbottm,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextFormField(
                              key: Key(
                                  model.cropsamplingdata.brixMiddle.toString()),
                              initialValue:
                                  model.cropsamplingdata.brixMiddle.toString(),
                              decoration: const InputDecoration(
                                labelText: 'Brix Middle',
                              ),
                              onChanged: model.setSelectedbrixmiddle,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              key: Key(
                                  model.cropsamplingdata.brixTop.toString()),
                              initialValue:
                                  model.cropsamplingdata.brixTop.toString(),
                              decoration: const InputDecoration(
                                labelText: 'Brix Top',
                              ),
                              onChanged: model.setSelectedbrixtop,
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: TextFormField(
                              key: Key(
                                  model.cropsamplingdata.noOfPairs.toString()),
                              initialValue:
                                  model.cropsamplingdata.noOfPairs.toString(),
                              decoration: const InputDecoration(
                                labelText: 'No. of  Pairs',
                              ),
                              onChanged: model.setSelectednoofpairs,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: TextFormField(
                      //         key: Key(
                      //             model.agridata.cropVariety ?? "cropVariety"),
                      //         readOnly: true,
                      //         initialValue: model.agridata.cropVariety ?? "",
                      //         decoration: const InputDecoration(
                      //           labelText: 'Crop Variety',
                      //         ),
                      //         onChanged: model.setSelectedcropvariety,
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 25,
                      //     ),
                      //     Expanded(
                      //       child: TextFormField(
                      //         key: Key(model.agridata.cropType ?? "cropType"),
                      //         readOnly: true,
                      //         initialValue: model.agridata.cropType ?? "",
                      //         decoration: const InputDecoration(
                      //           labelText: 'Crop Type',
                      //         ),
                      //         onChanged: model.setSelectedcroptype,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: TextFormField(
                      //         key: Key(model.agridata.area.toString()),
                      //         readOnly: true,
                      //         initialValue: model.agridata.area.toString(),
                      //         decoration: const InputDecoration(
                      //           labelText: 'Area in Acrs',
                      //         ),
                      //         onChanged: model.setSelectedAreaInAcrs,
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 25,
                      //     ),
                      //     Expanded(
                      //       child: TextFormField(
                      //         controller: model.datecontroller,
                      //         onTap: () => model.selectDate(context),
                      //         decoration: const InputDecoration(
                      //           labelText: 'Plantation Date',
                      //           hintText: 'Select Plantation Date',
                      //         ),
                      //         // validator: model.validateplantationdate,
                      //         onChanged: model.ondateChanged,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: TextFormField(
                      //         keyboardType: TextInputType.number,
                      //         key: Key(
                      //             model.agridata.developmentArea.toString()),
                      //         initialValue:
                      //             model.agridata.developmentArea.toString(),
                      //         decoration: const InputDecoration(
                      //           labelText: 'Developement Area',
                      //         ),
                      //         onChanged: model.setSelecteddevelopmentarea,
                      //         validator: model.validatedevelopmentArea,
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 25,
                      //     ),
                      //     Expanded(
                      //       child: TextFormField(
                      //         key: Key(model.agridata.route ?? "route"),
                      //         keyboardType: TextInputType.number,
                      //         initialValue: model.agridata.route ?? "",
                      //         decoration: const InputDecoration(
                      //           labelText: 'K.M.',
                      //         ),
                      //         onChanged: model.setSelectedkm,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      //
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CtextButton(
                            onPressed: () => model.onSavePressed(context),
                            text: 'Save',
                          ),
                          CtextButton(
                            text: 'Cancel',
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
              loader: model.isBusy,
              context: context,
            )));
  }
}
