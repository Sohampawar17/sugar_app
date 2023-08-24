import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/views/agriculture_screens/add_agri_view/add_agri_model.dart';

import '../../../widgets/cdrop_down_widget.dart';
import '../../../widgets/ctext_button.dart';
import '../../../widgets/full_screen_loader.dart';

class AddAgriScreen extends StatelessWidget {
  final String agriId;
  const AddAgriScreen({super.key, required this.agriId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AgriViewModel>.reactive(
        viewModelBuilder: () => AgriViewModel(),
        onViewModelReady: (model) => model.initialise(context, agriId),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: model.isEdit == true
                  ? Text(model.agridata.name ?? "")
                  : const Text('Agriculture development'),
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
                      Row(
                        children: [
                          Expanded(
                            child: Autocomplete<String>(
                              key: Key(model.agridata.caneRegistrationId ??
                                  "registrationid"),
                              initialValue: TextEditingValue(
                                text: model.agridata.caneRegistrationId ?? "",
                              ),
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<String>.empty();
                                }
                                return model.canelistwithfilter
                                    .map((route) => route.name.toString())
                                    .toList()
                                    .where((route) => route
                                        .toLowerCase()
                                        .contains(textEditingValue.text
                                            .toLowerCase()));
                              },
                              onSelected: model.setPlotnumber,
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
                                          final routeData = model
                                              .canelistwithfilter
                                              .firstWhere((route) =>
                                                  route.name.toString() ==
                                                  option);
                                          return GestureDetector(
                                            onTap: () {
                                              onSelected(routeData.name
                                                  .toString()); // Send the name as the selected route
                                            },
                                            child: ListTile(
                                              title: Text(option),
                                              subtitle:
                                                  Text(routeData.growerName!),
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
                            width: 25,
                          ),
                          Expanded(
                            child: TextFormField(
                              key: Key(model.agridata.supplier ?? "supplier"),
                              readOnly: true,
                              initialValue: model.agridata.supplier ?? "",
                              decoration: const InputDecoration(
                                labelText: 'Vendor Code',
                              ),
                              onChanged: model.setSelectedVendor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        key: Key(model.agridata.growerName ?? "growerName"),
                        readOnly: true,
                        initialValue: model.agridata.growerName ?? "",
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
                              key: Key(model.agridata.branch ?? "branch"),
                              readOnly: true,
                              initialValue: model.agridata.branch ?? "",
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
                              key: Key(model.agridata.village ?? "village"),
                              readOnly: true,
                              initialValue: model.agridata.village ?? "",
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
                                  model.agridata.cropVariety ?? "cropVariety"),
                              readOnly: true,
                              initialValue: model.agridata.cropVariety ?? "",
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
                              key: Key(model.agridata.cropType ?? "cropType"),
                              readOnly: true,
                              initialValue: model.agridata.cropType ?? "",
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
                              key: Key(model.agridata.area.toString()),
                              readOnly: true,
                              initialValue:
                                  model.agridata.area?.toString() ?? "",
                              decoration: const InputDecoration(
                                labelText: 'Area in Acrs',
                              ),
                              onChanged: model.setSelectedAreaInAcrs,
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: model.datecontroller,
                              onTap: () => model.selectDate(context),
                              decoration: const InputDecoration(
                                labelText: 'Plantation Date',
                                hintText: 'Select Plantation Date',
                              ),
                              // validator: model.validateplantationdate,
                              onChanged: model.ondateChanged,
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
                              keyboardType: TextInputType.number,
                              key: Key(
                                  model.agridata.developmentArea.toString()),
                              initialValue:
                                  model.agridata.developmentArea?.toString() ??
                                      "",
                              decoration: const InputDecoration(
                                labelText: 'Developement Area',
                              ),
                              onChanged: model.setSelecteddevelopmentarea,
                              validator: model.validatedevelopmentArea,
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: TextFormField(
                              key: Key(model.agridata.route ?? "route"),
                              keyboardType: TextInputType.number,
                              initialValue: model.agridata.route ?? "",
                              decoration: const InputDecoration(
                                labelText: 'K.M.',
                              ),
                              onChanged: model.setSelectedkm,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Wrap(
                        spacing: 4.0,
                        runSpacing: 3.0,
                        alignment: WrapAlignment.center,
                        children: [
                          for (String item in model.items)
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: model.selectedItems.contains(item),
                                    onChanged: (_) => model.toggleItem(item),
                                  ),
                                  Text(item),
                                ],
                              ),
                            ),
                        ],
                      ),
                      (model.agricultureDevelopmentItem.isEmpty)
                          ? const SizedBox()
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columnSpacing: 30.0,
                                // ignore: deprecated_member_use
                                dataRowHeight: 40.0,
                                columns: const [
                                  DataColumn(
                                    label: Text('Item Name'),
                                  ),
                                  DataColumn(
                                    label: Text('Basel'),
                                  ),
                                  DataColumn(
                                    label: Text('Pre-Earthing'),
                                  ),
                                  DataColumn(
                                    label: Text('Earth'),
                                  ),
                                  DataColumn(
                                    label: Text('Rainy'),
                                  ),
                                  DataColumn(
                                    label: Text('Ratoon1'),
                                  ),
                                  DataColumn(
                                    label: Text('Ratoon2'),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                  model.agricultureDevelopmentItem.length,
                                  // Replace 10 with the actual number of rows you want
                                  (int index) => DataRow(
                                    cells: [
                                      DataCell(Text(model
                                          .agricultureDevelopmentItem[index]
                                          .itemCode
                                          .toString())),
                                      DataCell(Text(model
                                          .agricultureDevelopmentItem[index]
                                          .basel
                                          .toString())),
                                      DataCell(Text(model
                                          .agricultureDevelopmentItem[index]
                                          .preEarthing
                                          .toString())),
                                      DataCell(Text(model
                                          .agricultureDevelopmentItem[index]
                                          .earth
                                          .toString())),
                                      DataCell(Text(model
                                          .agricultureDevelopmentItem[index]
                                          .rainy
                                          .toString())),
                                      DataCell(Text(model
                                          .agricultureDevelopmentItem[index]
                                          .ratoon1
                                          .toString())),
                                      DataCell(Text(model
                                          .agricultureDevelopmentItem[index]
                                          .ratoon2
                                          .toString())),
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
