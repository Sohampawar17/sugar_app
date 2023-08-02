import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/constants.dart';
import 'package:sugar_mill_app/views/add_farmer_view/add_farmer_model.dart';
import 'package:sugar_mill_app/widgets/cdrop_down_widget.dart';
import 'package:sugar_mill_app/widgets/ctext_button.dart';
import 'package:sugar_mill_app/widgets/full_screen_loader.dart';

class AddFarmerScreen extends StatelessWidget {
  const AddFarmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FarmerViewModel>.reactive(
      viewModelBuilder: () => FarmerViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Farmer Form'),
        ),
        body: fullScreenLoader(
          child: SingleChildScrollView(
            child: Form(
              key: model.formKey,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    // TextFormField(
                    //   decoration: const InputDecoration(labelText: 'Plant'),
                    //   validator: (value) =>
                    //       value!.isEmpty ? 'Please enter a Plant' : null,
                    //   onChanged: (value) => model.farmerData!.branch = value,
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          //for plant
                          child: CdropDown(
                            dropdownButton: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: model
                                  .selectedPlant, // Replace null with the selected value if needed
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
                              value: model
                                  .selectedVendorGroup, // Replace null with the selected value if needed
                              hint: const Text('Select Vendor Group'),
                              decoration: const InputDecoration(
                                labelText: 'Vendro Group',
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

                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Vendor Name'),
                      validator: (value) => value!.isEmpty
                          ? 'Please enter a supplier name'
                          : null,
                      onChanged: (value) =>
                          model.farmerData!.supplierName = value,
                    ),

                    //for aadhar card
                    TextFormField(
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

                    //for pan card
                    TextFormField(
                      controller: model.panNumberController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        UppercaseTextFormatter()
                      ],
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'PAN Number',
                        hintText: 'Enter 10-character PAN number',
                      ),
                      validator: model.validatePanNumber,
                      onChanged: model.onPanNumberChanged,
                    ),

                    //mobile number
                    TextFormField(
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

                    Row(
                      children: [
                        Expanded(
                          //for dob
                          child: TextFormField(
                            controller: model.dobController,
                            onTap: () => model.selectDate(context),
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Date of Birth',
                              hintText: 'Select Date of Birth',
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
                            onChanged: (value) => model.farmerData!.age = value,
                          ),
                        ),
                      ],
                    ),

                    //supplier code
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Existing vendor Code'),
                      validator: (value) => value!.isEmpty
                          ? 'Please enter an existing suppliervendor code'
                          : null,
                      onChanged: (value) =>
                          model.farmerData!.existingSupplierCode = value,
                    ),

                    // //supplier group
                    // TextFormField(
                    //   decoration:
                    //       const InputDecoration(labelText: 'Vendor Group'),
                    //   validator: (value) =>
                    //       value!.isEmpty ? 'Please enter a vendor group' : null,
                    //   onChanged: (value) =>
                    //       model.farmerData!.supplierGroup = value,
                    // ),

                    //supplier village
                    // TextFormField(
                    //   decoration: const InputDecoration(labelText: 'Village'),
                    //   validator: (value) =>
                    //       value!.isEmpty ? 'Please enter a village' : null,
                    //   onChanged: (value) => model.farmerData!.village = value,
                    // ),

                    const SizedBox(
                      height: 10.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          //for gender
                          child: CdropDown(
                            dropdownButton: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: model.selectedGender,
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
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          //for role
                          child: CdropDown(
                            dropdownButton: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: model.selectedVillage,
                              decoration: const InputDecoration(
                                labelText: 'Village',
                              ),
                              hint: const Text('Select Village'),
                              onChanged: model.setSelectedVillage,
                              items: model.villageList.map((role) {
                                return DropdownMenuItem<String>(
                                  value: role,
                                  child: Text(role),
                                );
                              }).toList(),
                              validator: model.validateVillage,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //roles of user
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.center,
                      children: [
                        for (String item in model.items)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                            onPressed: () => model.selectPdf(kAadharpdf),
                            child: model.isFileSelected(kAadharpdf)
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
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => model.selectPdf(kPanpdf),
                            child: model.isFileSelected(kPanpdf)
                                ? Text(
                                    'Pan Card File: ${model.files.getFile(kPanpdf)?.path.split("/").last}',
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : const Text('Attach Pan'),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //for bank passbook card
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => model.selectPdf(kBankpdf),
                            child: model.isFileSelected(kBankpdf)
                                ? Text(
                                    'Bank Passbook File: ${model.files.getFile(kBankpdf)?.path.split("/").last}',
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : const Text('Attach Bank Passbook'),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),

                        //for concent latter
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => model.selectPdf(kConcentpdf),
                            child: model.isFileSelected(kConcentpdf)
                                ? Text(
                                    'Concent Letter File: ${model.files.getFile(kConcentpdf)?.path.split("/").last}',
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : const Text('Attch Concent Letter'),
                          ),
                        ),
                        const SizedBox(width: 10),
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
                              columnSpacing: 8.0,
                              // ignore: deprecated_member_use
                              dataRowHeight: 40.0,
                              columns: const [
                                DataColumn(
                                  label: Text('Far.'),
                                ),
                                DataColumn(
                                  label: Text('Trans.'),
                                ),
                                DataColumn(
                                  label: Text('Har.'),
                                ),
                                DataColumn(
                                  label: Text('Bank Name'),
                                ),
                                DataColumn(
                                  label: Text('Branch IFSC Code'),
                                ),
                                DataColumn(
                                  label: Text('Account Number'),
                                ),
                                DataColumn(
                                  label: Text(
                                      'Action'), // Add a new DataColumn for the button
                                  numeric: false,
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                model.bankAccounts
                                    .length, // Replace 10 with the actual number of rows you want
                                (int index) => DataRow(
                                  cells: [
                                    DataCell(Text(model
                                        .bankAccounts[index].farmer
                                        .toString())),
                                    DataCell(Text(model
                                        .bankAccounts[index].harvester
                                        .toString())),
                                    DataCell(Text(model
                                        .bankAccounts[index].transporter
                                        .toString())),
                                    DataCell(Text(model
                                        .bankAccounts[index].bankName
                                        .toString())),
                                    DataCell(Text(model
                                        .bankAccounts[index].branchifscCode
                                        .toString())),
                                    DataCell(Text(model
                                        .bankAccounts[index].accountNumber
                                        .toString())),
                                    DataCell(
                                      SizedBox(
                                        height: 24.0,
                                        width: 120,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            getBankDetails(
                                                context, model, index);
                                          },
                                          child: const Text('View/Edit'),
                                        ),
                                      ),
                                    ),
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
    model.setValuesToBankVaribles(index);
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Add Bank Account'),
              content: Form(
                key: model.bankformKey,
                child: Column(
                  children: [
                    CdropDown(
                      dropdownButton: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: model.selectedRole,
                        decoration: const InputDecoration(
                          labelText: 'Select Role',
                        ),
                        hint: const Text('Select Role'),
                        onChanged: model.setSelectedRole,
                        items: model.roles.map((role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        validator: model.validateRole,
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Bank Name',
                      ),
                      initialValue: index == -1 ? null : model.bankName,
                      onChanged: (value) {
                        model.bankName = value;
                      },
                      validator: model.validateBankName,
                    ),
                    TextFormField(
                        initialValue: index == -1 ? null : model.branchifscCode,
                        decoration: const InputDecoration(
                          labelText: 'Branch IFSC Code',
                        ),
                        onChanged: (value) {
                          model.branchifscCode = value;
                        },
                        validator: model.validateBranchIfscCode),
                    TextFormField(
                      initialValue: index == -1 ? null : model.accountNumber,
                      decoration: const InputDecoration(
                        labelText: 'Account Number',
                      ),
                      onChanged: (value) {
                        model.accountNumber = value;
                      },
                      validator: model.validateAccountNumber,
                    ),
                  ],
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
          },
        );
      },
    );
  }
}
