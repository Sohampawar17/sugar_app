import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/views/agriculture_screens/add_agri_view/add_agri_model.dart';

import '../../../widgets/cdrop_down_widget.dart';
import '../../../widgets/ctext_button.dart';
import '../../../widgets/full_screen_loader.dart';

class AddAgriScreen extends StatefulWidget {
  const AddAgriScreen({super.key});

  @override
  State<AddAgriScreen> createState() => _AddAgriScreenState();
}

class _AddAgriScreenState extends State<AddAgriScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AgriViewModel>.reactive(
        viewModelBuilder: () => AgriViewModel(),
        onViewModelReady: (model) => model.initialise(context),
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
                    child: Column(children: [
                      CdropDown(
                        dropdownButton: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: model.agridata.season,
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
                          onChanged: (value) => model.setSelectedSeason(value),
                          validator: model.validateSeason,
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Autocomplete<String>(
                        key: Key(model.agridata.caneRegistrationId ?? "01"),
                        initialValue: TextEditingValue(
                          text: model.agridata.caneRegistrationId ?? "",
                        ),
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          return model.canelistwithfilter
                              .map((caneRegistrationId) =>
                                  caneRegistrationId.vendorCode ?? "")
                              .toList()
                              .where((caneRegistrationId) => caneRegistrationId
                                  .toLowerCase()
                                  .contains(
                                      textEditingValue.text.toLowerCase()));
                        },
                        onSelected: (model.setPlotnumber),
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
                              labelText: 'Plot Number',
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
                      TextFormField(
                        readOnly: true,
                        initialValue: model.agridata.growerName,
                        decoration: const InputDecoration(
                          labelText: 'Farmer Name',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: model.agridata.branch,
                        decoration: const InputDecoration(
                          labelText: 'Plant',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: model.agridata.village,
                        decoration: const InputDecoration(
                          labelText: 'Village',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: model.agridata.cropVariety,
                        decoration: const InputDecoration(
                          labelText: 'Crop Variety',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: model.agridata.cropType,
                        decoration: const InputDecoration(
                          labelText: 'Crop Type',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: model.agridata.area.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Area in Acrs',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: model.agridata.date,
                        decoration: const InputDecoration(
                          labelText: 'Plantation Date',
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: model.agridata.supplier,
                        decoration: const InputDecoration(
                          labelText: 'Vendor',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CtextButton(
                            onPressed: () {},
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
