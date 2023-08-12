import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/views/cane_screens/add_cane_view/add_cane_model.dart';

import '../../../widgets/cdrop_down_widget.dart';
import '../../../widgets/ctext_button.dart';
import '../../../widgets/full_screen_loader.dart';

class AddCaneScreen extends StatelessWidget {
  final String caneId;

  const AddCaneScreen({super.key, required this.caneId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CaneViewModel>.reactive(
        viewModelBuilder: () => CaneViewModel(),
        onViewModelReady: (model) => model.initialise(context, caneId),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Cane Registration'),
              ),
              body: fullScreenLoader(
                child: SingleChildScrollView(
                  child: Form(
                    key: model.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                //for plant
                                child: CdropDown(
                                  dropdownButton:
                                      DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    value: model.canedata.season,
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
                                    onChanged: (value) =>
                                        model.setSelectedSeason(value),
                                    validator: model.validateSeason,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                //for plant
                                child: CdropDown(
                                  dropdownButton:
                                      DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    value: model.canedata.plantName,
                                    // Replace null with the selected value if needed
                                    decoration: const InputDecoration(
                                      labelText: 'Plant',
                                    ),
                                    hint: const Text('Select Plant'),
                                    items: model.plantlist.map((val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (value) =>
                                        model.setSelectedPlant(value),
                                    validator: model.validatePlant,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(children: [
                            Expanded(
                              child: Autocomplete<String>(
                                key: Key(model.canedata.growerCode ?? "05"),
                                initialValue: TextEditingValue(
                                  text: model.canedata.growerCode ?? "",
                                ),
                                optionsBuilder:
                                    (TextEditingValue textEditingValue) {
                                  if (textEditingValue.text.isEmpty) {
                                    return const Iterable<String>.empty();
                                  }
                                  return model.farmerList
                                      .map((grower) => grower.name ?? "")
                                      .toList()
                                      .where((grower) => grower
                                          .toLowerCase()
                                          .contains(textEditingValue.text
                                              .toLowerCase()));
                                },
                                onSelected: model.setSelectedgrowercode,
                                fieldViewBuilder: (BuildContext context,
                                    TextEditingController textEditingController,
                                    FocusNode focusNode,
                                    VoidCallback onFieldSubmitted) {
                                  return TextFormField(
                                    // key: Key(model.farmerData.village ?? ""),
                                    // initialValue: model.farmerData.village,
                                    controller: textEditingController,
                                    focusNode: focusNode,
                                    decoration: const InputDecoration(
                                      labelText: 'Grower Code',
                                    ),
                                    onChanged: (String value) {},
                                    validator: model.validateGrowerCode,
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
                                        constraints: const BoxConstraints(
                                            maxHeight: 200),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: options.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final String option =
                                                options.elementAt(index);
                                            return GestureDetector(
                                              onTap: () {
                                                onSelected(option);
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
                            ),
                            Expanded(
                                //for plant
                                child: CdropDown(
                              dropdownButton: DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: model.canedata.plantationStatus,
                                decoration: const InputDecoration(
                                  labelText: 'Plantation Status',
                                ),
                                hint: const Text('Select Is Plantation Status'),
                                items: model.plantationStatus.map((val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                }).toList(),
                                onChanged: (value) =>
                                    model.setSelectedplantation(value),
                                validator: model.validatePlantationStatus,
                              ),
                            )),
                          ]),
                          TextFormField(
                              readOnly: true,
                              key: Key(model.canedata.growerName ?? "07"),
                              initialValue: model.canedata.growerName,
                              decoration: const InputDecoration(
                                  labelText: 'Grower Name'),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter a Grower Name'
                                  : null,
                              onChanged: model.setSelectedgrowername),
                          //mobile number
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  key: Key(model.canedata.formNumber ?? "04"),
                                  initialValue: model.canedata.formNumber,
                                  decoration: const InputDecoration(
                                      labelText: 'Form Number'),
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter a form  Number'
                                      : null,
                                  onChanged: model.setFormNumber,
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                //for plant
                                child: CdropDown(
                                  dropdownButton:
                                      DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    value: model.canedata.isKisanCard,
                                    // Replace null with the selected value if needed
                                    decoration: const InputDecoration(
                                      labelText: 'Is Kisan Card',
                                    ),
                                    hint: const Text('Select Is Kisan Card'),
                                    items: model.yesno.map((val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (value) =>
                                        model.setSelectedkisan(value),
                                    validator: model.validateKisanCard,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          model.isEdit
                              ? const Text(
                                  "Address",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              : Container(),
                          Autocomplete<String>(
                            key: Key(model.canedata.area ?? "03"),
                            initialValue: TextEditingValue(
                              text: model.canedata.area ?? "",
                            ),
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return const Iterable<String>.empty();
                              }
                              return model.villageList.where((area) => area
                                  .toLowerCase()
                                  .contains(
                                      textEditingValue.text.toLowerCase()));
                            },
                            onSelected: model.setSelectedVillage,
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController textEditingController,
                                FocusNode focusNode,
                                VoidCallback onFieldSubmitted) {
                              return TextFormField(
                                // key: Key(model.farmerData.village ?? ""),
                                // initialValue: model.farmerData.village,
                                controller: textEditingController,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                  labelText: 'Village',
                                ),
                                onChanged: (String value) {},
                                validator: model.validateVillage,
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
                                        return GestureDetector(
                                          onTap: () {
                                            onSelected(option);
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
                          Visibility(
                            visible: model.isEdit,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue: model.canedata.circleOffice,
                                    decoration: const InputDecoration(
                                      labelText: 'Circle Office',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: model.isEdit,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue: model.canedata.taluka,
                                    decoration: const InputDecoration(
                                        labelText: 'taluka'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue: model.canedata.state,
                                    decoration: const InputDecoration(
                                      labelText: 'State',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Autocomplete<String>(
                                  key: Key(model.canedata.route ?? "02"),
                                  initialValue: TextEditingValue(
                                    text: model.canedata.route ?? " ",
                                  ),
                                  optionsBuilder:
                                      (TextEditingValue textEditingValue) {
                                    if (textEditingValue.text.isEmpty) {
                                      return const Iterable<String>.empty();
                                    }
                                    return model.routeList
                                        .map((route) => route.route!)
                                        .toList()
                                        .where((route) => route
                                            .toLowerCase()
                                            .contains(textEditingValue.text
                                                .toLowerCase()));
                                  },
                                  onSelected: (String routeName) {
                                    // Find the corresponding route object
                                    final routeData = model.routeList
                                        .firstWhere(
                                            (route) => route.name == routeName);
                                    model.setselectedRoute(
                                        routeData.name); // Pass the route
                                  },
                                  fieldViewBuilder: (BuildContext context,
                                      TextEditingController
                                          textEditingController,
                                      FocusNode focusNode,
                                      VoidCallback onFieldSubmitted) {
                                    return TextFormField(
                                      controller: textEditingController,
                                      focusNode: focusNode,
                                      decoration: const InputDecoration(
                                        labelText: 'Route',
                                      ),
                                      onChanged: (String value) {},
                                      validator: model.validateRoute,
                                    );
                                  },
                                  optionsViewBuilder: (BuildContext context,
                                      AutocompleteOnSelected<String> onSelected,
                                      Iterable<String> options) {
                                    return Align(
                                      alignment: Alignment.topLeft,
                                      child: Material(
                                        elevation: 4.0,
                                        child: Container(
                                          constraints: const BoxConstraints(
                                            maxHeight: 200,
                                          ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: options.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final String option =
                                                  options.elementAt(index);
                                              // Find the corresponding route object
                                              final routeData = model.routeList
                                                  .firstWhere((route) =>
                                                      route.route == option);
                                              return GestureDetector(
                                                onTap: () {
                                                  onSelected(routeData
                                                      .name!); // Send the name as the selected route
                                                },
                                                child: ListTile(
                                                  title: Text(option),
                                                  // Display the corresponding name value
                                                  subtitle:
                                                      Text(routeData.name!),
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
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: TextFormField(
                                key: Key(model.canedata.routeKm.toString()),
                                readOnly: true,
                                decoration:
                                    const InputDecoration(labelText: 'KM'),
                                initialValue: model.canedata.routeKm.toString(),
                                onChanged: (newValue) {
                                  // Handle the newValue here, you can update the routeKm value
                                  // using the setroutekm function with the new value.
                                  double? parsedValue =
                                      double.tryParse(newValue) ?? 0;
                                  model.setroutekm(parsedValue);
                                },
                              )),
                            ],
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                    key: Key(
                                        model.canedata.surveyNumber ?? "01"),
                                    initialValue: model.canedata.surveyNumber,
                                    decoration: const InputDecoration(
                                        labelText: 'Survey Number'),
                                    validator: (value) => value!.isEmpty
                                        ? 'Please enter a Survey Number'
                                        : null,
                                    onChanged: model.setsurveyNumber),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: CdropDown(
                                  dropdownButton:
                                      DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    value: model.canedata.cropVariety,
                                    // Replace null with the selected value if needed
                                    decoration: const InputDecoration(
                                      labelText: 'Crop Variety',
                                    ),
                                    hint: const Text('Select Crop Variety'),
                                    items: model.canevarietyList.map((val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (value) =>
                                        model.setselectedcropVariety(value),
                                    validator: model.validateCropVariety,
                                    menuMaxHeight: 200,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CdropDown(
                                  dropdownButton:
                                      DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    value: model.canedata.plantationSystem,
                                    // Replace null with the selected value if needed
                                    decoration: const InputDecoration(
                                      labelText: 'Plantation System',
                                    ),
                                    hint:
                                        const Text('Select Plantation System'),
                                    items:
                                        model.plantationsystemList.map((val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (value) => model
                                        .setselectedPlantationSystem(value),
                                    validator: model.validatePlantationSystem,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: CdropDown(
                                  dropdownButton:
                                      DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    value: model.canedata.irrigationSource,
                                    // Replace null with the selected value if needed
                                    decoration: const InputDecoration(
                                      labelText: 'Irrigation Source',
                                    ),
                                    hint: const Text(
                                        'Select Is Irrigation Source'),
                                    items:
                                        model.irrigationSourceList.map((val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (value) => model
                                        .setSelectedirrigationsource(value),
                                    validator: model.validateirrigationSource,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CdropDown(
                                  dropdownButton:
                                      DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    value: model.canedata.soilType,
                                    // Replace null with the selected value if needed
                                    decoration: const InputDecoration(
                                      labelText: 'Soil Type',
                                    ),
                                    hint: const Text('Select Is Soil Type'),
                                    items: model.soilTypeList.map((val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (value) =>
                                        model.setSelectedSoilType(value),
                                    validator: model.validateSoilType,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: CdropDown(
                                  dropdownButton:
                                      DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    value: model.canedata.roadSide,
                                    // Replace null with the selected value if needed
                                    decoration: const InputDecoration(
                                      labelText: 'Road Side',
                                    ),
                                    hint: const Text('Select Is Road Side'),
                                    items: model.yesnoroadside.map((val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (value) =>
                                        model.setSelectedRoadSIde(value),
                                    validator: model.validateRoadSide,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CdropDown(
                                  dropdownButton:
                                      DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    value: model.canedata.cropType,
                                    // Replace null with the selected value if needed
                                    decoration: const InputDecoration(
                                      labelText: 'Crop Type',
                                    ),
                                    hint: const Text('Select Crop Type'),
                                    items: model.croptypeList.map((val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (value) =>
                                        model.setSelectedcroptype(value),
                                    validator: model.validateCropType,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextFormField(
                                  key: Key(model.canedata.areaAcrs.toString()),
                                  initialValue:
                                      model.canedata.areaAcrs.toString(),
                                  decoration: const InputDecoration(
                                    labelText: 'Area In Acrs',
                                  ),
                                  validator: model.validateAreaInAcrs,
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      model.setSelectedareainacrs(newValue);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: model.plantationdateController,
                                  onTap: () => model.selectDate(context),
                                  decoration: const InputDecoration(
                                    labelText: 'Plantation Date',
                                    hintText: 'Select Plantation Date',
                                  ),
                                  validator: model.validateplantationdate,
                                  onChanged: model.onplantationdateChanged,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: TextFormField(
                                  controller: model.baselDateController,
                                  onTap: () => model.selectBaselDate(context),
                                  decoration: const InputDecoration(
                                    labelText: 'Basel Date',
                                    hintText: 'Select Basel Date',
                                  ),
                                  onChanged: model.onBaseldateChanged,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: CdropDown(
                                  dropdownButton:
                                      DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    value: model.canedata.irrigationMethod,
                                    // Replace null with the selected value if needed
                                    decoration: const InputDecoration(
                                      labelText: 'Irrigation Method',
                                    ),
                                    hint:
                                        const Text('Select Irrigation Method'),
                                    items:
                                        model.irrigationmethodList.map((val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (value) => model
                                        .setSelectedirrigationmethod(value),
                                    validator: model.validateirrigationMethod,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: CdropDown(
                                  dropdownButton:
                                      DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    value: model.canedata.seedMaterial,
                                    // Replace null with the selected value if needed
                                    decoration: const InputDecoration(
                                      labelText: 'Seed Material',
                                    ),
                                    hint: const Text('Select Seed Material'),
                                    items: model.seedmaterialList.map((val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (value) =>
                                        model.setselectedSeedMaterial(value),
                                    validator: model.validateSeedMaterial,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CdropDown(
                                  dropdownButton:
                                      DropdownButtonFormField<String>(
                                    value: model.canedata.isMachine,
                                    // Replace null with the selected value if needed
                                    decoration: const InputDecoration(
                                      labelText: 'Is Machine',
                                    ),
                                    hint: const Text('Select Is Machine'),
                                    items: model.yesnomachine.map((val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (value) =>
                                        model.setSelectedisMachine(value),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: CdropDown(
                                  dropdownButton:
                                      DropdownButtonFormField<String>(
                                    value: model.canedata.seedType,
                                    // Replace null with the selected value if needed
                                    decoration: const InputDecoration(
                                      labelText: 'Seed Type',
                                    ),
                                    hint: const Text('Select Seed Type'),
                                    items: model.seedType.map((val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (value) =>
                                        model.setSelectedseedType(value),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: CdropDown(
                                  dropdownButton:
                                      DropdownButtonFormField<String>(
                                    value: model.canedata.developmentPlot,
                                    // Replace null with the selected value if needed
                                    decoration: const InputDecoration(
                                      labelText: 'Development Plot',
                                    ),
                                    hint: const Text('Select Development Plot'),
                                    items: model.yesno.map((val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (value) =>
                                        model.setSelectedDevelopmentplot(value),
                                  ),
                                ),
                              ),
                            ],
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
                        ],
                      ),
                    ),
                  ),
                ),
                loader: model.isBusy,
                context: context,
              ),
            ));
  }
}