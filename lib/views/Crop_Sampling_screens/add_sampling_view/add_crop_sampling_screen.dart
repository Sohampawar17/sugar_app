import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/ctext_button.dart';
import '../../../widgets/full_screen_loader.dart';
import 'add_crop_sampling_model.dart';

class AddCropSamplingScreen extends StatelessWidget {
  final String samplingId;
  const AddCropSamplingScreen({super.key, required this.samplingId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddCropSmaplingModel>.reactive(
        viewModelBuilder: () => AddCropSmaplingModel(),
        onViewModelReady: (model) => model.initialise(context, samplingId),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: const Text('Crop Sampling'),
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
                                        subtitle: Text(routeData.growerName!),
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
                              initialValue: model.cropsamplingdata.brixBottom
                                      ?.toString() ??
                                  "",
                              decoration: const InputDecoration(
                                labelText: 'Brix Bottom',
                              ),
                              onChanged: model.setSelectedbrixbottm,
                              validator: model.validatebrixbottom,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextFormField(
                              key: Key(
                                  model.cropsamplingdata.brixMiddle.toString()),
                              initialValue: model.cropsamplingdata.brixMiddle
                                      ?.toString() ??
                                  "",
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
                                  model.cropsamplingdata.brixTop?.toString() ??
                                      "",
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
                              initialValue: model.cropsamplingdata.noOfPairs
                                      ?.toString() ??
                                  "",
                              decoration: const InputDecoration(
                                labelText: 'No. of  Pairs',
                              ),
                              onChanged: model.setSelectednoofpairs,
                              validator: model.validatenoofpairs,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Visibility(
                          visible: model.cropsamplingdata.id != null,
                          child: Column(
                            children: [
                              TextFormField(
                                key: Key(model.cropsamplingdata.growerCode ??
                                    "supplier"),
                                readOnly: true,
                                initialValue:
                                    model.cropsamplingdata.growerCode ?? "",
                                decoration: const InputDecoration(
                                  labelText: 'Grower Code',
                                ),
                                onChanged: model.setSelectedVendor,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                key: Key(model.cropsamplingdata.growerName ??
                                    "growerName"),
                                readOnly: true,
                                initialValue:
                                    model.cropsamplingdata.growerName ?? "",
                                decoration: const InputDecoration(
                                  labelText: 'Farmer Name',
                                ),
                                onChanged: model.setSelectedfarmername,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      key: Key(
                                          model.cropsamplingdata.plantName ??
                                              "branch"),
                                      readOnly: true,
                                      initialValue:
                                          model.cropsamplingdata.plantName ??
                                              "",
                                      decoration: const InputDecoration(
                                        labelText: 'Plant',
                                      ),
                                      onChanged: model.setSelectedPlantName,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      key: Key(model.cropsamplingdata.area ??
                                          "village"),
                                      readOnly: true,
                                      initialValue:
                                          model.cropsamplingdata.area ?? "",
                                      decoration: const InputDecoration(
                                        labelText: 'Village',
                                      ),
                                      onChanged: model.setSelectedvillage,
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
                                          model.cropsamplingdata.cropVariety ??
                                              "cropVariety"),
                                      readOnly: true,
                                      initialValue:
                                          model.cropsamplingdata.cropVariety ??
                                              "",
                                      decoration: const InputDecoration(
                                        labelText: 'Crop Variety',
                                      ),
                                      onChanged: model.setSelectedcropvariety,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      key: Key(
                                          model.cropsamplingdata.cropType ??
                                              "cropType"),
                                      readOnly: true,
                                      initialValue:
                                          model.cropsamplingdata.cropType ?? "",
                                      decoration: const InputDecoration(
                                        labelText: 'Crop Type',
                                      ),
                                      onChanged: model.setSelectedcroptype,
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
                                      key: Key(model.cropsamplingdata.area
                                          .toString()),
                                      readOnly: true,
                                      initialValue: model.cropsamplingdata.area
                                          .toString(),
                                      decoration: const InputDecoration(
                                        labelText: 'Soil Type',
                                      ),
                                      onChanged: model.setSelectedSoilType,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  // Expanded(
                                  //   child: TextFormField(
                                  //     controller: model.datecontroller,
                                  //     onTap: () => model.selectDate(context),
                                  //     decoration: const InputDecoration(
                                  //       labelText: 'Plantation Date',
                                  //       hintText: 'Select Plantation Date',
                                  //     ),
                                  //     // validator: model.validateplantationdate,
                                  //     onChanged: model.ondateChanged,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          )),
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
