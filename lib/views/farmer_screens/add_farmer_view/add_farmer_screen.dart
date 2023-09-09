import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/constants.dart';
import 'package:sugar_mill_app/views/farmer_screens/add_farmer_view/add_farmer_model.dart';
import 'package:sugar_mill_app/widgets/cdrop_down_widget.dart';
import 'package:sugar_mill_app/widgets/ctext_button.dart';
import 'package:sugar_mill_app/widgets/full_screen_loader.dart';
import 'package:sugar_mill_app/widgets/view_docs_from_internet.dart';
import 'package:sugar_mill_app/widgets/view_image.dart';

class AddFarmerScreen extends StatelessWidget {
  final String farmerid;
  const AddFarmerScreen({super.key, required this.farmerid});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FarmerViewModel>.reactive(
      viewModelBuilder: () => FarmerViewModel(),
      onViewModelReady: (model) => model.initialise(context, farmerid),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: model.isEdit == true
              ? Text(model.farmerData.name ?? "")
              : const Text('Farmer Form'),
        ),
        body: fullScreenLoader(
          child: SingleChildScrollView(
            child: Form(
              key: model.formKey,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          //for plant
                          child: CdropDown(
                            dropdownButton: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: model.farmerData.branch,
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
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          //for vendergroup
                          child: CdropDown(
                            dropdownButton: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: "Cane",
                              hint: const Text('Select Vendor Group'),
                              decoration: const InputDecoration(
                                labelText: 'Vendor Group',
                              ),
                              onChanged: model.setSelectedVendorGroup,
                              items: model.vendorGroupList.map((val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              }).toList(),
                              validator: model.validateVandorGroup,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                        visible: model.isEdit == true,
                        child: model.farmerData.existingSupplierCode != null
                            ? TextFormField(
                                readOnly: true,
                                initialValue:
                                    model.farmerData.existingSupplierCode,
                                decoration: const InputDecoration(
                                    labelText: 'Vendor Code'),
                              )
                            : TextFormField(
                                readOnly: true,
                                initialValue:
                                    model.farmerData.name?.substring(3),
                                decoration: const InputDecoration(
                                    labelText: 'Vendor Code'),
                              )),
                    TextFormField(
                        key: Key(model.farmerData.supplierName ?? ""),
                        initialValue: model.farmerData.supplierName,
                        decoration:
                            const InputDecoration(labelText: 'Vendor Name'),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a Vendor name'
                            : null,
                        onChanged: model.updateFarmerName),

                    // //mobile number
                    // const Text(
                    //   "Address",
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w300,
                    //   ),
                    // ),

                    Row(
                      children: [
                        Expanded(
                          child: Autocomplete<String>(
                            key: Key(model.farmerData.village ?? "village"),
                            initialValue: TextEditingValue(
                              text: model.farmerData.village ?? "",
                            ),
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return const Iterable<String>.empty();
                              }
                              return model.villageList
                                  .map((route) => route.name!)
                                  .toList()
                                  .where((route) => route
                                      .toLowerCase()
                                      .contains(
                                          textEditingValue.text.toLowerCase()));
                            },
                            onSelected: (String routeName) {
                              // Find the corresponding route object
                              final routeData = model.villageList.firstWhere(
                                  (route) => route.name == routeName);
                              model.setSelectedVillage(
                                  routeData.name); // Pass the route
                            },
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
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            key: Key(model.farmerData.circleOffice ??
                                "circleoffice"),
                            readOnly: true,
                            initialValue: model.farmerData.circleOffice,
                            decoration: const InputDecoration(
                              labelText: 'Circle Office',
                            ),
                            // onChanged: model.setSelectedcircleoffice,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: model.isEdit,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              initialValue: model.farmerData.taluka,
                              decoration:
                                  const InputDecoration(labelText: 'Taluka'),
                            ),
                          ),
                          // const SizedBox(
                          //   width: 20.0,
                          // ),
                          // Expanded(
                          //   child: TextFormField(
                          //     readOnly: true,
                          //     initialValue: model.farmerData.state,
                          //     decoration: const InputDecoration(
                          //       labelText: 'State',
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    // Visibility(
                    //   visible: model.isEdit,
                    //   child: TextFormField(
                    //     readOnly: true,
                    //     initialValue: model.farmerData.pinCode,
                    //     decoration: const InputDecoration(
                    //       labelText: 'Pincode',
                    //     ),
                    //   ),
                    // ),

                    Row(children: [
                      Expanded(
                        child: TextFormField(
                          controller: model.mobileNumberController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Mobile Number',
                            hintText: 'Enter 10-digit mobile number',
                          ),
                          validator: model.validateMobileNumber,
                          onChanged: model.onMobileNumberChanged,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      model.isEdit == false
                          ? Expanded(
                              child: TextFormField(
                                key: Key(model.farmerData.taluka ?? "Taluka"),
                                readOnly: true,
                                initialValue: model.farmerData.taluka,
                                decoration: const InputDecoration(
                                  labelText: 'Taluka',
                                ),
                                // onChanged: model.setSelectedcircleoffice,
                              ),
                            )
                          : Expanded(
                              child: TextFormField(
                                controller: model.aadharNumberController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(12),
                                ],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Aadhar Card Number',
                                  hintText: 'Enter 12-digit Aadhar number',
                                ),
                                validator: model.validateAadhar,
                                onChanged: model.onAadharChanged,
                              ),
                            ),
                    ]),

                    Row(
                      children: [
                        //for aadhar card
                        Expanded(
                          child: Visibility(
                            visible: !model.isEdit,
                            child: TextFormField(
                              controller: model.aadharNumberController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(12),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Aadhar Card Number',
                                hintText: 'Enter 12-digit Aadhar number',
                              ),
                              validator: model.validateAadhar,
                              onChanged: model.onAadharChanged,
                            ),
                          ),
                        ),

                        // const SizedBox(
                        //   width: 20.0,
                        // ),
                        // //for pan card
                        // Expanded(
                        //   child: TextFormField(
                        //     controller: model.panNumberController,
                        //     inputFormatters: [
                        //       LengthLimitingTextInputFormatter(11),
                        //       UppercaseTextFormatter()
                        //     ],
                        //     keyboardType: TextInputType.text,
                        //     decoration: const InputDecoration(
                        //       labelText: 'PAN Number',
                        //       hintText: 'Enter 10-character PAN number',
                        //     ),
                        //     validator: model.validatePanNumber,
                        //     onChanged: model.onPanNumberChanged,
                        //   ),
                        // ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          //for dob
                          child: TextFormField(
                            controller: model.dobController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              labelText: 'Date of Birth',
                              hintText: 'DD-MM-YYYY',
                              errorText: model.errorMessage.isNotEmpty
                                  ? model.errorMessage
                                  : null,
                            ),
                            validator: model.validateDob,
                            onChanged: model.onDobChanged,
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            controller: model.ageController,
                            decoration: const InputDecoration(labelText: 'Age'),
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter an age' : null,
                            onChanged: (value) =>
                                model.farmerData.age = value.toString(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          //for gender
                          child: CdropDown(
                            dropdownButton: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: model.farmerData.gender,
                              decoration: const InputDecoration(
                                labelText: 'Gender',
                              ),
                              hint: const Text('Select Gender'),
                              items: model.genders.map((gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(gender),
                                );
                              }).toList(),
                              onChanged: (value) =>
                                  model.setSelectedGender(value),
                              validator: model.validateGender,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //roles of user
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

                    //Aadhar Card pdf
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //for adhar card
                        Expanded(
                          child: ElevatedButton(
                            // onPressed: () => model.selectPdf(kAadharpdf),
                            onPressed: () =>
                                pickDoc(kAadharpdf, context, model),
                            child: model.farmerData.aadhaarCard != null
                                ? Text(
                                    'Aadhar File: ${model.farmerData.aadhaarCard?.split("/").last}',
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : model.isFileSelected(kAadharpdf)
                                    ? Text(
                                        'Aadhar File: ${model.files.getFile(kAadharpdf)?.path.split("/").last}',
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : const Text('Attach Aadhar'),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),

                        //for pand card
                        // Expanded(
                        //   child: ElevatedButton(
                        //     onPressed: () => pickDoc(kPanpdf, context, model),
                        //     // model.selectPdf(kPanpdf, ImageSource.camera),
                        //     child: model.farmerData.panCard != null
                        //         ? Text(
                        //             'Pan File: ${model.farmerData.panCard?.split("/").last}',
                        //             overflow: TextOverflow.ellipsis,
                        //           )
                        //         : model.isFileSelected(kPanpdf)
                        //             ? Text(
                        //                 'Pan File: ${model.files.getFile(kPanpdf)?.path.split("/").last}',
                        //                 overflow: TextOverflow.ellipsis,
                        //               )
                        //             : const Text('Attach PAN'),
                        //   ),
                        // ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                pickDoc(kConcentpdf, context, model),
                            //  model.selectPdf( kConcentpdf, ImageSource.camera),
                            child: model.farmerData.consentLetter != null
                                ? Text(
                                    'Concent Letter File: ${model.farmerData.consentLetter?.split("/").last}',
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : model.isFileSelected(kConcentpdf)
                                    ? Text(
                                        'Concent Letter: ${model.files.getFile(kConcentpdf)?.path.split("/").last}',
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : const Text('Attach Letter'),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //for bank passbook card
                        // Expanded(
                        //   child: ElevatedButton(
                        //     onPressed: () => pickDoc(kBankpdf, context, model),
                        //     // model.selectPdf(kBankpdf, ImageSource.camera),
                        //     child: model.farmerData.bankPassbook != null
                        //         ? Text(
                        //             'Bank  File: ${model.farmerData.bankPassbook?.split("/").last}',
                        //             overflow: TextOverflow.ellipsis,
                        //           )
                        //         : model.isFileSelected(kBankpdf)
                        //             ? Text(
                        //                 'Bank Passbook: ${model.files.getFile(kBankpdf)?.path.split("/").last}',
                        //                 overflow: TextOverflow.ellipsis,
                        //               )
                        //             : const Text('Attach Passbook'),
                        //   ),
                        // ),
                        SizedBox(
                          width: 10.0,
                        ),

                        //for concent latter
                        // Expanded(
                        //   child: ElevatedButton(
                        //     onPressed: () =>
                        //         pickDoc(kConcentpdf, context, model),
                        //     //  model.selectPdf( kConcentpdf, ImageSource.camera),
                        //     child: model.farmerData.consentLetter != null
                        //         ? Text(
                        //             'Bank  File: ${model.farmerData.consentLetter?.split("/").last}',
                        //             overflow: TextOverflow.ellipsis,
                        //           )
                        //         : model.isFileSelected(kConcentpdf)
                        //             ? Text(
                        //                 'Concent Letter: ${model.files.getFile(kConcentpdf)?.path.split("/").last}',
                        //                 overflow: TextOverflow.ellipsis,
                        //               )
                        //             : const Text('Attach Letter'),
                        //   ),
                        // ),
                        SizedBox(width: 10),
                      ],
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),

                    (model.bankAccounts.isEmpty)
                        ? const SizedBox()
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              border: TableBorder.all(width: 0.5),
                              columnSpacing: 12.0,
                              // ignore: deprecated_member_use
                              dataRowHeight: 40.0,
                              columns: const [
                                DataColumn(
                                  label: Text('Far.'),
                                ),
                                DataColumn(
                                  label: Text('Har.'),
                                ),
                                DataColumn(
                                  label: Text('Trans.'),
                                ),
                                DataColumn(
                                  label: Text('B. Name'),
                                ),
                                DataColumn(
                                  label: Text('IFSC'),
                                ),
                                DataColumn(
                                  label: Text('Acc. Number'),
                                ),
                                DataColumn(
                                  label: Text('Bank Passbook'),
                                ),
                                DataColumn(
                                  label: Text('Action'),
                                  // Add a new DataColumn for the button
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Text('Delete'),
                                  // Add a new DataColumn for the button
                                  numeric: false,
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                model.bankAccounts.length,
                                // Replace 10 with the actual number of rows you want
                                (int index) => DataRow(
                                  cells: [
                                    DataCell(Checkbox(
                                      value:
                                          model.bankAccounts[index].farmer == 1,
                                      onChanged: (bool? newValue) {
                                        model.setRole("Farmer",
                                            (newValue == true ? 1 : 0) as bool);
                                      },
                                    )),
                                    DataCell(Checkbox(
                                      value:
                                          model.bankAccounts[index].harvester ==
                                              1,
                                      onChanged: (bool? newValue) {
                                        model.setRole("Harvester",
                                            (newValue == true ? 1 : 0) as bool);
                                      },
                                    )),
                                    DataCell(Checkbox(
                                      value: model.bankAccounts[index]
                                              .transporter ==
                                          1,
                                      onChanged: (bool? newValue) {
                                        model.setRole("Transporter",
                                            (newValue == true ? 1 : 0) as bool);
                                      },
                                    )),

                                    DataCell(Text(model
                                        .bankAccounts[index].bankName
                                        .toString())),
                                    DataCell(Text(model
                                        .bankAccounts[index].branchifscCode
                                        .toString())),
                                    DataCell(Text(model
                                        .bankAccounts[index].accountNumber
                                        .toString())),
                                    DataCell(TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ViewImageInternet(
                                                url: model.bankAccounts[index]
                                                        .bankPassbook ??
                                                    "",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(model
                                            .bankAccounts[index].bankPassbook
                                            .toString()))),
                                    // DataCell(Text(model
                                    //     .bankAccounts[index].
                                    //     .toString())),
                                    DataCell(
                                      SizedBox(
                                        height: 24.0,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            getBankDetails(
                                                context, model, index);
                                          },
                                          child: const Text('Edit'),
                                        ),
                                      ),
                                    ),
                                    DataCell(IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Confirm Delete'),
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
                      onPressed: () => getBankDetails(context, model, -1),
                      child: const Text('Add Bank Account'),
                    ),
                    const SizedBox(
                      height: 10.0,
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
          context: context,
          loader: model.isBusy,
        ),
      ),
    );
  }

  getBankDetails(BuildContext context, FarmerViewModel model, int index) {
    if (index == -1) {
      model.resetBankVariables(); // Add this function to reset variables
    } else {
      model.setValuesToBankVaribles(index);
    }
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (BuildContext context,
                void Function(void Function()) setState) {
              return SingleChildScrollView(
                child: AlertDialog(
                  title: const Text('Add Bank Account'),
                  content: SizedBox(
                    height: getHeight(context) / 1.5,
                    child: Form(
                      key: model.bankformKey,
                      child: Column(
                        children: [
                          CheckboxListTile(
                            title: const Text("Farmer"),
                            value: model.farmer,
                            onChanged: (bool? newValue) {
                              setState(() =>
                                  model.setRole("Farmer", newValue ?? false));
                            },
                          ),

                          CheckboxListTile(
                            title: const Text("Harvester"),
                            value: model.harvester,
                            onChanged: (bool? newValue) {
                              setState(() => model.setRole(
                                  "Harvester", newValue ?? false));
                            },
                          ),
                          CheckboxListTile(
                            title: const Text("Transporter"),
                            value: model.transporter,
                            onChanged: (bool? newValue) {
                              setState(() => model.setRole(
                                  "Transporter", newValue ?? false));
                            },
                          ),
                          Expanded(
                            child: Autocomplete<String>(
                              key: Key(index == -1
                                  ? ""
                                  : model.bankAccounts[index].bankName ?? ""),
                              initialValue: TextEditingValue(
                                  text: index == -1
                                      ? ""
                                      : model.bankAccounts[index].bankName ??
                                          ""),
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<String>.empty();
                                }
                                return model.bankList
                                    .map((bank) => bank.bankAndBranch ?? "")
                                    .toList()
                                    .where((bank) => bank
                                        .toLowerCase()
                                        .contains(textEditingValue.text
                                            .toLowerCase()));
                              },
                              onSelected: (String routeName) {
                                // Find the corresponding route object
                                final bankData = model.bankList.firstWhere(
                                    (bank) => bank.bankAndBranch == routeName);
                                model.setSelectedBank(
                                    bankData.bankAndBranch); // Pass the route
                              },
                              fieldViewBuilder: (BuildContext context,
                                  TextEditingController textEditingController,
                                  FocusNode focusNode,
                                  VoidCallback onFieldSubmitted) {
                                return TextFormField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  decoration: const InputDecoration(
                                    labelText: 'Bank',
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
                          // Expanded(
                          //   child: Autocomplete<String>(
                          //     key: Key(index == -1
                          //         ? ""
                          //         : model.bankAccounts[index].bankAndBranch ?? ""),
                          //     initialValue: TextEditingValue(
                          //         text: index == -1
                          //             ? ""
                          //             : model.bankAccounts[index].bankAndBranch ??
                          //                 ""),
                          //     optionsBuilder: (TextEditingValue textEditingValue) {
                          //       if (textEditingValue.text.isEmpty) {
                          //         return const Iterable<String>.empty();
                          //       }
                          //       return model.bankList
                          //           .map((bank) => bank.branch ?? "")
                          //           .toList()
                          //           .where((bank) => bank.toLowerCase().contains(
                          //               textEditingValue.text.toLowerCase()));
                          //     },
                          //     onSelected: (String routeName) {
                          //       // Find the corresponding route object
                          //       final bankData = model.bankList
                          //           .firstWhere((bank) => bank.branch == routeName);
                          //       model.setSelectedBranch(
                          //           bankData.branch); // Pass the route
                          //     },
                          //     fieldViewBuilder: (BuildContext context,
                          //         TextEditingController textEditingController,
                          //         FocusNode focusNode,
                          //         VoidCallback onFieldSubmitted) {
                          //       return TextFormField(
                          //         controller: textEditingController,
                          //         focusNode: focusNode,
                          //         decoration: const InputDecoration(
                          //           labelText: 'Branch',
                          //         ),
                          //         onChanged: (String value) {},
                          //       );
                          //     },
                          //     optionsViewBuilder: (BuildContext contpext,
                          //         AutocompleteOnSelected<String> onSelected,
                          //         Iterable<String> options) {
                          //       return Align(
                          //         alignment: Alignment.topLeft,
                          //         child: Material(
                          //           elevation: 4.0,
                          //           child: Container(
                          //             constraints:
                          //                 const BoxConstraints(maxHeight: 200),
                          //             child: ListView.builder(
                          //               shrinkWrap: true,
                          //               itemCount: options.length,
                          //               itemBuilder:
                          //                   (BuildContext context, int index) {
                          //                 final String option =
                          //                     options.elementAt(index);
                          //                 return GestureDetector(
                          //                   onTap: () {
                          //                     onSelected(option);
                          //                   },
                          //                   child: ListTile(
                          //                     title: Text(option),
                          //                   ),
                          //                 );
                          //               },
                          //             ),
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //     optionsMaxHeight: 200,
                          //   ),
                          // ),
                          Expanded(
                            child: TextFormField(
                              initialValue:
                                  index == -1 ? null : model.accountNumber,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                                UppercaseTextFormatter()
                              ],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Account Number',
                              ),
                              onChanged: (value) {
                                model.accountNumber = value;
                              },
                              validator: model.validateAccountNumber,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: TextEditingController(
                                  text: model.branchifscCode),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                                UppercaseTextFormatter(),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Branch IFSC Code',
                              ),
                              validator: model.validateBranchIfscCode,
                            ),
                          ),
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () =>
                                pickDocforpassbook(kBankpdf, context, model),
                            child: model.passbookattch != ""
                                ? Text(
                                    'Bank File: ${model.passbookattch.split("/").last}',
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : const Text('Attach Passbook'),
                          )),
                        ],
                      ),
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
                ),
              );
            });
          },
        );
      },
    );
  }

  void pickDoc(String filetype, BuildContext context, FarmerViewModel model) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick an image or document'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                model.selectPdf(filetype, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_copy),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                model.selectPdf(filetype, ImageSource.gallery);
              },
            ),
            if (model.files.getFile(filetype) != null ||
                (model.getFileFromFarmer(filetype) ?? "").isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog

                  if (model.files.getFile(filetype) != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ViewImage(
                          image: Image.file(
                            model.getFileFromFileType(filetype) ?? File(""),
                          ),
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ViewImageInternet(
                          url: model.getFileFromFarmer(filetype) ?? "",
                        ),
                      ),
                    );
                  }
                },
                child: const Text("View Uploaded File"),
              )
            else
              Container(),
          ],
        ),
      ),
    );
  }

  void pickDocforpassbook(
      String filetype, BuildContext context, FarmerViewModel model) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick an image or document'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                model.selectPdfpassbook(filetype, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_copy),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                model.selectPdfpassbook(filetype, ImageSource.gallery);
              },
            ),
            if (model.files.getBankPassbookFileByIndex(0) != null ||
                (model.getFileFromFarmer(filetype) ?? "").isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog

                  final bankPassbookFile =
                      model.files.getBankPassbookFileByIndex(0);
                  if (bankPassbookFile != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ViewImageInternet(
                          url: model.getFileFromFarmer(filetype) ?? "",
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ViewImageInternet(
                          url: model.getFileFromFarmer(filetype) ?? "",
                        ),
                      ),
                    );
                  }
                },
                child: const Text("View Uploaded File"),
              )
            else
              Container(),
          ],
        ),
      ),
    );
  }
}
