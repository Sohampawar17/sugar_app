import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/views/agriculture_screens/add_agri_view/add_agri_model.dart';

import '../../../constants.dart';
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
                      Row(
                        children: [
                          Expanded(
                            child: CdropDown(
                              dropdownButton: DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: model.agridata.salesType,
                                // Replace null with the selected value if needed
                                decoration: const InputDecoration(
                                  labelText: 'Sales Type',
                                ),
                                hint: const Text('Select Sales type'),
                                items: model.saleslist.map((val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                }).toList(),
                                onChanged: (value) =>
                                    model.setSelectedSales(value),
                                validator: model.validateSalesType,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: CdropDown(
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
                                onChanged: (value) =>
                                    model.setSelectedSeason(value),
                                validator: model.validateSeason,
                              ),
                            ),
                          ),
                        ],
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
                                  keyboardType: TextInputType.number,
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
                              controller: model.developmentAreaController,
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
                              keyboardType: TextInputType.number,
                              controller: model.kmController,
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
                      if (model.agridata.salesType == "Fertilizer")
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
                      if (model.agridata.salesType == "Fertilizer")
                        ElevatedButton(
                            onPressed: () => model.mapJsonToTable(),
                            child: const Text('Update')),
                      if (model.agridata.salesType != "Fertilizer")
                        ElevatedButton(
                            onPressed: () =>
                                getAgricaultureDetails(context, model, -1),
                            child: const Text('Add Agriculture')),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const Text(
                        'Agriculture Development Item',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      (model.agricultureDevelopmentItem.isEmpty)
                          ? const SizedBox()
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columnSpacing: 30.0,
                                // ignore: deprecated_member_use
                                border: TableBorder.all(width: 1.0),
                                columns: [
                                  const DataColumn(
                                    label: Text('Item Name'),
                                  ),
                                  if (model.agridata.salesType == 'Fertilizer')
                                    const DataColumn(
                                      label: Text('Basel'),
                                    ),
                                  if (model.agridata.salesType == 'Fertilizer')
                                    const DataColumn(
                                      label: Text('Pre-Earthing'),
                                    ),
                                  if (model.agridata.salesType == 'Fertilizer')
                                    const DataColumn(
                                      label: Text('Earth'),
                                    ),
                                  if (model.agridata.salesType == 'Fertilizer')
                                    const DataColumn(
                                      label: Text('Rainy'),
                                    ),
                                  if (model.agridata.salesType == 'Fertilizer')
                                    const DataColumn(
                                      label: Text('Ratoon1'),
                                    ),
                                  if (model.agridata.salesType == 'Fertilizer')
                                    const DataColumn(
                                      label: Text('Ratoon2'),
                                    ),
                                  const DataColumn(
                                    label: Text('Total'),
                                  ),
                                  const DataColumn(
                                    label: Text('Delete'),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                  model.agricultureDevelopmentItem.length,
                                  // Replace 10 with the actual number of rows you want
                                  (int index) => DataRow(
                                    cells: [
                                      DataCell(Text(
                                        model.agricultureDevelopmentItem[index]
                                            .itemCode
                                            .toString(),
                                        maxLines: 3,
                                        textWidthBasis:
                                            TextWidthBasis.longestLine,
                                      )),
                                      if (model.agridata.salesType ==
                                          'Fertilizer')
                                        DataCell(
                                          TextField(
                                            controller: TextEditingController(
                                              text: model
                                                  .agricultureDevelopmentItem[
                                                      index]
                                                  .basel
                                                  .toString(),
                                            ),
                                            onChanged: (value) {
                                              model
                                                  .agricultureDevelopmentItem[
                                                      index]
                                                  .basel = double.parse(value);
                                            },
                                          ),
                                        ),
                                      if (model.agridata.salesType ==
                                          'Fertilizer')
                                        DataCell(
                                          TextField(
                                            controller: TextEditingController(
                                              text: model
                                                  .agricultureDevelopmentItem[
                                                      index]
                                                  .preEarthing
                                                  .toString(),
                                            ),
                                            onChanged: (value) {
                                              model
                                                      .agricultureDevelopmentItem[
                                                          index]
                                                      .preEarthing =
                                                  double.parse(value);
                                            },
                                          ),
                                        ),
                                      if (model.agridata.salesType ==
                                          'Fertilizer')
                                        DataCell(
                                          TextField(
                                            controller: TextEditingController(
                                              text: model
                                                  .agricultureDevelopmentItem[
                                                      index]
                                                  .earth
                                                  .toString(),
                                            ),
                                            onChanged: (value) {
                                              model
                                                  .agricultureDevelopmentItem[
                                                      index]
                                                  .earth = double.parse(value);
                                            },
                                          ),
                                        ),
                                      if (model.agridata.salesType ==
                                          'Fertilizer')
                                        DataCell(
                                          TextField(
                                            controller: TextEditingController(
                                              text: model
                                                  .agricultureDevelopmentItem[
                                                      index]
                                                  .rainy
                                                  .toString(),
                                            ),
                                            onChanged: (value) {
                                              model
                                                  .agricultureDevelopmentItem[
                                                      index]
                                                  .rainy = double.parse(value);
                                            },
                                          ),
                                        ),
                                      if (model.agridata.salesType ==
                                          'Fertilizer')
                                        DataCell(
                                          TextField(
                                            controller: TextEditingController(
                                              text: model
                                                  .agricultureDevelopmentItem[
                                                      index]
                                                  .ratoon1
                                                  .toString(),
                                            ),
                                            onChanged: (value) {
                                              model
                                                  .agricultureDevelopmentItem[
                                                      index]
                                                  .ratoon1 = double.parse(value);
                                            },
                                          ),
                                        ),
                                      if (model.agridata.salesType ==
                                          'Fertilizer')
                                        DataCell(
                                          TextField(
                                            controller: TextEditingController(
                                              text: model
                                                  .agricultureDevelopmentItem[
                                                      index]
                                                  .ratoon2
                                                  .toString(),
                                            ),
                                            onChanged: (value) {
                                              model
                                                  .agricultureDevelopmentItem[
                                                      index]
                                                  .ratoon2 = double.parse(value);
                                            },
                                          ),
                                        ),
                                      DataCell(Text(model
                                          .agricultureDevelopmentItem[index].qty
                                          .toString())),
                                      DataCell(IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Confirm Delete'),
                                                content: const Text(
                                                    'Are you sure you want to delete this bank account?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); // Close the confirmation dialog
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); // Close the confirmation dialog
                                                      model.deleteAgriAccount(
                                                          index); // Delete the entry
                                                    },
                                                    child: const Text('Delete'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.delete),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const Text(
                        'Grantors',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      (model.grantor.isEmpty)
                          ? const SizedBox()
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columnSpacing: 22.0,
                                border: TableBorder.all(width: 0.5),
                                // ignore: deprecated_member_use
                                dataRowHeight: 40.0,
                                columns: const [
                                  DataColumn(
                                    label: Text('Surety Code'),
                                  ),
                                  DataColumn(
                                    label: Text('Surety Name'),
                                  ),
                                  DataColumn(
                                    label: Text('Delete'),
                                    // Add a new DataColumn for the button
                                    numeric: false,
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                  model.grantor.length,
                                  // Replace 10 with the actual number of rows you want
                                  (int index) => DataRow(
                                    cells: [
                                      DataCell(Text(model
                                          .grantor[index].suretyCode
                                          .toString())),
                                      DataCell(Text(model
                                          .grantor[index].suretyName
                                          .toString())),
                                      DataCell(IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Confirm Delete'),
                                                content: const Text(
                                                    'Are you sure you want to delete this bank account?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); // Close the confirmation dialog
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); // Close the confirmation dialog
                                                      model.deleteBankAccount(
                                                          index); // Delete the entry
                                                    },
                                                    child: const Text('Delete'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.delete),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: () => getGrantorDetails(context, model, -1),
                        child: const Text('Add Grantors'),
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

  getGrantorDetails(BuildContext context, AgriViewModel model, int index) {
    if (index == -1) {
      model.resetBankVariables(); // Add this function to reset variables
    } else {
      model.setValuesToBankVaribles(index);
    }
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (BuildContext context,
                void Function(void Function()) setState) {
              return AlertDialog(
                title: const Text('Add Grantors'),
                content: SizedBox(
                  height: getHeight(context) / 6,
                  child: fullScreenLoader(
                    child: Form(
                      key: model.bankformKey,
                      child: Column(
                        children: [
                          Expanded(
                            child: Autocomplete<String>(
                              key: Key(index == -1
                                  ? ""
                                  : model.grantor[index].suretyCode ?? ""),
                              initialValue: TextEditingValue(
                                  text: index == -1
                                      ? ""
                                      : model.grantor[index].suretyCode ?? ""),
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<String>.empty();
                                }
                                return model.farmerList
                                    .map((bank) =>
                                        bank.existingSupplierCode ?? "")
                                    .toList()
                                    .where((bank) => bank
                                        .toLowerCase()
                                        .contains(textEditingValue.text
                                            .toLowerCase()));
                              },
                              onSelected: (String routeName) {
                                // Find the corresponding route object
                                final bankData = model.farmerList.firstWhere(
                                    (bank) =>
                                        bank.existingSupplierCode == routeName);
                                model.setSelectedgrantor(
                                    bankData.name); // Pass the route
                              },
                              fieldViewBuilder: (BuildContext context,
                                  TextEditingController textEditingController,
                                  FocusNode focusNode,
                                  VoidCallback onFieldSubmitted) {
                                return TextFormField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Surety Code',
                                  ),
                                  onChanged: (String value) {},
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
                                          final routeData = model.farmerList
                                              .firstWhere((route) =>
                                                  route.existingSupplierCode ==
                                                  option);
                                          return GestureDetector(
                                            onTap: () {
                                              onSelected(option);
                                            },
                                            child: ListTile(
                                              title: Text(option),
                                              subtitle:
                                                  Text(routeData.supplierName!),
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
                            child: TextFormField(
                              controller:
                                  TextEditingController(text: model.suretyname),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Surety Name',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    loader: model.isBusy,
                    context: context,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      model.validateForm(context, index);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            });
          },
        );
      },
    );
  }

  getAgricaultureDetails(BuildContext context, AgriViewModel model, int index) {
    if (index == -1) {
      model.resetAgriVariables(); // Add this function to reset variables
    } else {
      model.setValuesToAgriVaribles(index);
    }
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (BuildContext context,
                void Function(void Function()) setState) {
              return AlertDialog(
                title: const Text('Add Agricultural Development'),
                content: SizedBox(
                  height: getHeight(context) / 6,
                  child: fullScreenLoader(
                    child: Form(
                      key: model.agriformKey,
                      child: Column(
                        children: [
                          Expanded(
                            child: Autocomplete<String>(
                              key: Key(index == -1
                                  ? ""
                                  : model.agricultureDevelopmentItem[index]
                                          .itemCode ??
                                      ""),
                              initialValue: TextEditingValue(
                                  text: index == -1
                                      ? ""
                                      : model.agricultureDevelopmentItem[index]
                                              .itemCode ??
                                          ""),
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<String>.empty();
                                }
                                return model.itemList
                                    .map((bank) => bank.itemName ?? "")
                                    .toList()
                                    .where((bank) => bank
                                        .toLowerCase()
                                        .contains(textEditingValue.text
                                            .toLowerCase()));
                              },
                              onSelected: (String routeName) {
                                // Find the corresponding route object
                                final bankData = model.itemList.firstWhere(
                                    (bank) => bank.itemName == routeName);
                                model.setSelectedAgri(
                                    bankData.itemName); // Pass the route
                              },
                              fieldViewBuilder: (BuildContext context,
                                  TextEditingController textEditingController,
                                  FocusNode focusNode,
                                  VoidCallback onFieldSubmitted) {
                                return TextFormField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  decoration: const InputDecoration(
                                    labelText: 'Item Name',
                                  ),
                                  onChanged: (String value) {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some Item';
                                    }
                                    return null;
                                  },
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
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: model
                                  .totalController, // Use the controller here
                              decoration: const InputDecoration(
                                labelText: 'Total',
                              ),
                              onChanged: (newValue) {
                                double? parsedValue =
                                    double.tryParse(newValue) ?? 0;
                                model.setSelectedtotal(parsedValue);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some Total';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    loader: model.isBusy,
                    context: context,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      model.validateAgriForm(context, index);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            });
          },
        );
      },
    );
  }
}
