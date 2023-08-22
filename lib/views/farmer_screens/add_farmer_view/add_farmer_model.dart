import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/constants.dart';
import 'package:sugar_mill_app/models/farmer.dart';

import 'package:sugar_mill_app/router.router.dart';
import 'package:sugar_mill_app/services/add_farmer_service.dart';

import '../../../models/bank_model.dart';
import '../../../widgets/cdate_custom.dart';

class FarmerViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final bankformKey = GlobalKey<FormState>();
  TextEditingController plantController = TextEditingController();
  TextEditingController supplierNameController = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  List<BankDetails> bankAccounts = [];
  final List<String> items = ['Farmer', 'Member'];
  final List<String> plantlist = ['Bedkihal', 'Nagpur'];
  final List<String> vendorGroupList = ['Cane'];
  List<String> villageList = [""];
  List<BankMaster> bankList = [];

  DateTime? selectedDate;
  Farmer farmerData = Farmer();
  late String accountNumber;
  late String branchifscCode = "";
  late String bankName;
  late String farmerId;
  late String branch = "";
  late String passbookattch = "";

  bool isEdit = false;

  final List<String> _selectedItems = [];

  List<String> get selectedItems => _selectedItems;

  initialise(BuildContext context, String farmerid) async {
    setBusy(true);
    villageList = await FarmerService().fetchVillages();
    bankList = await FarmerService().fetchBanks();
    Logger().i(bankList.toString());
    farmerId = farmerid;
    //setting aleardy available data
    if (farmerId != "") {
      isEdit = true;
      farmerData = await FarmerService().getFarmer(farmerid) ?? Farmer();
      notifyListeners();
      plantController.text = farmerData.branch ?? "";
      supplierNameController.text = farmerData.supplierName ?? "";
      aadharNumberController.text =
          _formatAadhar(farmerData.aadhaarNumber ?? "");
      panNumberController.text = _formatPanNumber(farmerData.panNumber ?? "");
      mobileNumberController.text = farmerData.mobileNumber ?? "";
      dobController.text = farmerData.dateOfBirth ?? "";
      ageController.text = farmerData.age ?? "";
      bankAccounts.addAll(farmerData.bankDetails?.toList() ?? []);
      if (farmerData.isFarmer == 1) {
        _selectedItems.add(items[0]);
      }
      if (farmerData.isMember == 1) {
        _selectedItems.add(items[1]);
      }
    }

    if (villageList.length == 1 && villageList[0] == "403") {
      if (context.mounted) {
        setBusy(false);
        Navigator.popAndPushNamed(context, Routes.loginViewScreen);
      }
    }
    farmerData.supplierGroup = "CANE";
    setBusy(false);
  }

  void onSavePressed(BuildContext context) async {
    if (farmerData.workflowState == "Approved") {
      Fluttertoast.showToast(msg: "Can not edit approved document!");
      return;
    }
    if (!villageList.contains(farmerData.village)) {
      Fluttertoast.showToast(
          msg: "Invalid Village", toastLength: Toast.LENGTH_LONG);
      return;
    }
    setBusy(true);
    if (formKey.currentState!.validate()) {
      // Fluttertoast.showToast(msg: "Farmer Added");
      await uploadFiles();
      farmerData.bankDetails = bankAccounts;
      Logger().i(farmerData.toJson());
      bool res = false;
      if (isEdit == true) {
        res = await FarmerService().updateFarmer(farmerData);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            setBusy(false);
            Navigator.pop(context);
          }
        }
      } else {
        res = await FarmerService().addFarmer(farmerData);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            setBusy(false);
            Navigator.pop(context);
          }
        }
      }
    }
    setBusy(false);
  }

////////////////////////////////// aadhar functions////////////////////////////////
  String? validateAadhar(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Aadhar card number';
    }

    if (value.replaceAll(' ', '').length != 12) {
      return 'Aadhar card number should be exactly 12 digits';
    }
    // Additional validation rules can be added if needed.
    return null;
  }

  void onAadharChanged(String value) {
    String formattedAadhar = _formatAadhar(value);
    int selectionIndex = aadharNumberController.selection.baseOffset +
        formattedAadhar.length -
        aadharNumberController.text.length;
    aadharNumberController.value = TextEditingValue(
      text: formattedAadhar,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
    farmerData.aadhaarNumber = aadharNumberController.text.replaceAll(" ", '');
  }

  String _formatAadhar(String value) {
    value = value.replaceAll(' ', ''); // Remove existing spaces
    if (value.length > 4) {
      value = '${value.substring(0, 4)} ${value.substring(4, value.length)}';
    }
    if (value.length > 9) {
      value = '${value.substring(0, 9)} ${value.substring(9, value.length)}';
    }
    return value;
  }

/////////////////////////////////////////////////////////////////////////////
//////////////////////////////////pan number////////////////////////////////
  String? validatePanNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter PAN number';
    }
    if (value.replaceAll(' ', '').length != 10) {
      return 'PAN number should be exactly 10 characters';
    }
    // Additional validation rules can be added if needed.
    return null;
  }

  void onPanNumberChanged(String value) {
    String formattedPanNumber = _formatPanNumber(value);
    panNumberController.value = TextEditingValue(
      text: formattedPanNumber,
      selection: TextSelection.collapsed(offset: formattedPanNumber.length),
    );
    farmerData.panNumber = panNumberController.text.replaceAll(" ", '');
  }

  String _formatPanNumber(String value) {
    value = value.replaceAll(' ', ''); // Remove existing spaces
    if (value.length > 5) {
      value = '${value.substring(0, 5)} ${value.substring(5, value.length)}';
    }
    return value;
  }

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// mobile number////////////////////////////////

  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    }
    if (value.replaceAll(" ", "").length != 10) {
      return 'Mobile number should be exactly 10 digits';
    }
    // Additional validation rules can be added if needed.
    return null;
  }

  void onMobileNumberChanged(String value) {
    String formattedMobileNumber = formatMobileNumber(value);
    mobileNumberController.value = TextEditingValue(
      text: formattedMobileNumber,
      selection: TextSelection.collapsed(offset: formattedMobileNumber.length),
    );
    farmerData.mobileNumber = mobileNumberController.text.replaceAll(" ", '');
  }

  String formatMobileNumber(String value) {
    value = value.replaceAll(' ', ''); // Remove existing spaces
    if (value.length > 3) {
      value = '${value.substring(0, 3)} ${value.substring(3, value.length)}';
    }
    if (value.length > 7) {
      value = '${value.substring(0, 7)} ${value.substring(7, value.length)}';
    }
    return value;
  }
  //////////////////////////////////////////////////////////////////////////

  ///////////////////////////////// /for dob////////////////////////////////
  bool isValidDateFormat(String input) {
    // Implement your validation logic here, for example using regular expressions
    // This is a simplified example; you might want to use a more robust validation approach
    RegExp dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    return dateRegExp.hasMatch(input);
  }

  String? validateDob(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Date of Birth';
    }
    if (errorMessage.isNotEmpty) {
      Text(
        errorMessage,
        style: TextStyle(color: Colors.red),
      );
    }
    return null;
  }

  void onDobChanged(String value) {
    String formattedDate = DateInputHelper.formatInput(value);
    bool isValidDate = DateInputHelper.isValidDate(formattedDate);
    dobController.value = dobController.value.copyWith(
      text: formattedDate,
      selection: TextSelection.collapsed(offset: formattedDate.length),
    );
    if (isValidDate) {
      errorMessage = '';
      farmerData.dateOfBirth = formattedDate;
      _calculateAge();
    } else {
      errorMessage = 'Invalid date';
    }
  }

  String errorMessage = '';

  // Future<void> selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate ?? DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //
  //   if (picked != null && picked != selectedDate) {
  //     selectedDate = picked;
  //     dobController.text = DateFormat('yyyy-MM-dd').format(picked);
  //     farmerData.dateOfBirth = dobController.text;
  //     _calculateAge();
  //   }
  // }

  void _calculateAge() {
    if (selectedDate != null) {
      DateTime currentDate = DateTime.now();
      int age = currentDate.year - selectedDate!.year;
      if (currentDate.month < selectedDate!.month ||
          (currentDate.month == selectedDate!.month &&
              currentDate.day < selectedDate!.day)) {
        age--;
      }

      ageController.value = TextEditingValue(
        text: age.toString(),
      );
      farmerData.age = age.toString();
      notifyListeners();
    } else {
      ageController.value = const TextEditingValue(
        text: "0",
      );
    }
  }

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// for gender //////////////////////////////////////////////////
  String? _selectedGender;
  final List<String> _genders = ['Male', 'Female', 'Other'];

  String? get selectedGender => _selectedGender;
  List<String> get genders => _genders;

  void setSelectedGender(String? gender) {
    _selectedGender = gender;
    farmerData.gender = _selectedGender;
    notifyListeners();
  }

  void setSelectedPlant(String? plant) {
    farmerData.branch = plant;
    notifyListeners();
  }

  String? selectedVendorGroup;

  void setSelectedVendorGroup(String? vender) {
    selectedVendorGroup = vender;
    farmerData.supplierGroup = vender;
    notifyListeners();
  }

  String? selectedVillage;
  void setSelectedVillage(String? village) {
    selectedVillage = village;
    farmerData.village = selectedVillage;
    notifyListeners();
  }

  void setSelectedBank(String? bank) {
    bankName = bank ?? "";
    final selectedRouteData =
        bankList.firstWhere((bankData) => bankData.bankName == bank);
    branchifscCode = selectedRouteData.ifscCode ?? "";
    branch = selectedRouteData.branch ?? "";
    Logger().i(branch);
    Logger().i(branchifscCode);
    notifyListeners();
  }

  String? selectedRole;

  void setSelectedRole(String? role) {
    selectedRole = role;
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////// for user role ////////////////////////////////
  final List<String> roles = ['Transporter', 'Harvester', 'Farmer', 'None'];
  // final List<String> roles = ['Transporter'];
  // String? _selectedRole;

  // String? get selectedRole => _selectedRole;

  // void setSelectedRole(String? role) {
  //   if (role != null) {
  //     _selectedRole = role;
  //     notifyListeners();
  //     // Do something with the selected role, like navigating to the next screen
  //     // Example:
  //     // _navigationService.navigateTo(NextScreenRoute, arguments: _selectedRole);
  //   }
  // }

  bool transporter = false;
  bool harvester = false;
  bool farmer = false;
  bool member = false;

  void setTransporter(bool value) {
    transporter = value;
    notifyListeners();
  }

  void setHarvester(bool value) {
    harvester = value;
    notifyListeners();
  }

  void setFarmer(bool value) {
    farmer = value;
    notifyListeners();
  }

  void setMember(bool value) {
    member = value;
    notifyListeners();
  }

  void toggleItem(String item) {
    if (_selectedItems.contains(item)) {
      _selectedItems.remove(item);
      // 'Transporter', 'Harvester', 'Farmer', 'Member'
      if (item == items[0]) {
        farmerData.isFarmer = 0;
      }
      if (item == items[1]) {
        farmerData.isMember = 0;
      }
    } else {
      _selectedItems.add(item);
      if (item == items[0]) {
        farmerData.isFarmer = 1;
      }
      if (item == items[1]) {
        farmerData.isMember = 1;
      }
    }

    notifyListeners();
  }
  ///////////////////////////////////////////////////////////////////////

  /////////////////////////////// for adhar upload//////////////////////

  // Variable to hold the selected PDF file
  Files files = Files();

  // Function to open file picker and select PDF file
  Future<void> selectPdf(String fileType, ImageSource source) async {
    try {
      final result = await ImagePicker().pickImage(source: source);
      if (result != null) {
        // print("SIZE BEFORE: ${result.files.single.size}");
        setBusy(true);
        File? compressedFile = await compressFile(fileFromXFile(result));
        // print("SIZE BEFORE: ${compressedFile?.lengthSync()}");
        files.setFile(fileType, compressedFile);
        setBusy(false);
        notifyListeners();
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error while picking an image or document: $e');
    }
  }

  // Function to upload the selected PDF file (Aadhar card)
  Future<void> uploadFiles() async {
    String aadharUrl = await FarmerService().uploadDocs(files.adharCard);
    if (aadharUrl == "" && isEdit == false) {
      Fluttertoast.showToast(msg: "Failed to upload Aadhar");
    }
    // String panUrl = await FarmerService().uploadDocs(files.panCard);
    // if (panUrl == "" && isEdit == false) {
    //   Fluttertoast.showToast(msg: "Failed to upload Pan");
    // }

    String letterUrl = await FarmerService().uploadDocs(files.consentLetter);
    if (letterUrl == "" && isEdit == false) {
      Fluttertoast.showToast(msg: "Failed to upload Letter");
    }

    farmerData.aadhaarCard =
        aadharUrl == "" ? farmerData.aadhaarCard : aadharUrl;
    // farmerData.panCard = panUrl == "" ? farmerData.panCard : panUrl;

    Logger().i(passbookattch);
    farmerData.consentLetter =
        letterUrl == "" ? farmerData.consentLetter : letterUrl;
  }

  Future<void> uploadpassbook() async {
    String bankUrl = await FarmerService().uploadDocs(files.bankPassbook);
    if (bankUrl == "" && isEdit == false) {
      Fluttertoast.showToast(msg: "Failed to upload Bank");
    }
    if (bankUrl.isNotEmpty) {
      passbookattch = bankUrl;
    }
    passbookattch = bankUrl.isNotEmpty ? bankUrl : passbookattch;
  }

  // Function to check if a PDF file is selected
  bool isFileSelected(String fileType) {
    return files.getFile(fileType) != null;
  }

  ////////////////// Adhar Upload End ///////////////////

  ////////////////// validators ////////////////////////////////////

  String? validatePlant(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Plant';
    }
    return null;
  }

  String? validateVandorGroup(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Vendor Group';
    }
    return null;
  }

  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Gender';
    }
    return null;
  }

  String? validateVillage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Village';
    }
    return null;
  }

  String? validateRole(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Role';
    }
    return null;
  }

  void validateForm(BuildContext context, int index) async {
    if (farmerData.workflowState == "Approved") {
      Fluttertoast.showToast(msg: "Can not edit Approved document");
      return;
    }
    final formState = bankformKey.currentState;
    if (formState!.validate()) {
      // Form is valid, submit it
      if (index == -1) {
        if (!isRoleAlreadyPresent(selectedRole ?? "")) {
          Fluttertoast.showToast(
              msg: "Account of selected role already exist",
              toastLength: Toast.LENGTH_LONG);
          return;
        }
      }
      await uploadpassbook();
      submitBankAccount(index);
      Navigator.pop(context);
    } else {
      // Form is invalid, show error messages
      Logger().i('Bank Form is invalid');
    }
  }

  void submitBankAccount(int index) {
    if (index != -1) {
      bankAccounts[index].farmer = selectedRole == "Farmer" ? 1 : 0;
      bankAccounts[index].harvester = selectedRole == "Harvester" ? 1 : 0;
      bankAccounts[index].transporter = selectedRole == "Transporter" ? 1 : 0;
      bankAccounts[index].bankName = bankName;
      bankAccounts[index].branchifscCode = branchifscCode;
      bankAccounts[index].accountNumber = accountNumber;
      bankAccounts[index].bankAndBranch = branch;
      if (passbookattch.isNotEmpty) {
        bankAccounts[index].bankPassbook = passbookattch;
      }
      notifyListeners();
      return;
    }
    bankAccounts.add(BankDetails(
        farmer: selectedRole == "Farmer" ? 1 : 0,
        harvester: selectedRole == "Harvester" ? 1 : 0,
        transporter: selectedRole == "Transporter" ? 1 : 0,
        bankName: bankName,
        branchifscCode: branchifscCode,
        accountNumber: accountNumber,
        bankAndBranch: branch,
        bankPassbook: passbookattch));
    notifyListeners();
  }

  void setValuesToBankVaribles(int index) {
    if (index != -1) {
      if (index >= bankAccounts.length) {
        return;
      }
      selectedRole = bankAccounts[index].farmer == 1
          ? "Farmer"
          : bankAccounts[index].harvester == 1
              ? "Harvester"
              : bankAccounts[index].transporter == 1
                  ? "Transporter"
                  : "None";

      bankName = bankAccounts[index].bankName!;
      branchifscCode = bankAccounts[index].branchifscCode!;
      accountNumber = bankAccounts[index].accountNumber!;
      branch = bankAccounts[index].bankAndBranch!;
      if (passbookattch.isNotEmpty) {
        passbookattch = bankAccounts[index].bankPassbook!;
      }
    }
    notifyListeners();
  }

  bool isRoleAlreadyPresent(String field) {
    for (var i in bankAccounts) {
      Logger().i(i.transporter);
      Logger().i(i.farmer);
      Logger().i(i.harvester);
      switch (field) {
        case 'Transporter':
          if (i.transporter == 1) return false;
          break;
        case 'Harvester':
          if (i.harvester == 1) return false;
          break;
        case 'Farmer':
          if (i.farmer == 1) return false;
          break;
      }
    }
    return true;
  }

  String? validateBankName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a bank name';
    }
    return null;
  }

  String? validateBranch(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a bank branch';
    }
    return null;
  }

  String? validateBranchIfscCode(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a branch IFSC code';
    }
    if (value.length != 11) {
      return 'The branch IFSC code must be 11 characters long';
    }
    return null;
  }

  String? validateAccountNumber(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an account number';
    }
    if (value.length < 10) {
      return 'The account number must be at least 10 characters long';
    }
    if (value.length > 20) {
      return 'The account number must be no more than 20 characters long';
    }
    return null;
  }

  void updateFarmerName(String value) {
    farmerData.supplierName = value.toUpperCase();
  }

  getVisibility() {
    return isEdit;
  }

  String? getFileFromFarmer(String filetype) {
    if (filetype == kAadharpdf) return farmerData.aadhaarCard;
    // if (filetype == kPanpdf) return farmerData.panCard;
    if (filetype == kBankpdf) return passbookattch;
    if (filetype == kConcentpdf) return farmerData.consentLetter;
    return null;
  }

  File? getFileFromFileType(String filetype) {
    if (filetype == kAadharpdf) return files.adharCard;
    // if (filetype == kPanpdf) return files.panCard;
    if (filetype == kBankpdf) return files.bankPassbook;
    if (filetype == kConcentpdf) return files.consentLetter;
    return null;
  }
}

class UppercaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}

class Files {
  File? adharCard;
  File? bankPassbook;
  // File? panCard;
  File? consentLetter;
  File? getFile(String fileType) {
    if (fileType == kAadharpdf) {
      return adharCard;
    }
    // if (fileType == kPanpdf) {
    //   return panCard;
    // }
    if (fileType == kBankpdf) {
      return bankPassbook;
    }
    if (fileType == kConcentpdf) {
      return consentLetter;
    }

    return null;
  }

  void setFile(String fileType, File? file) {
    if (fileType == kAadharpdf) {
      adharCard = file;
    }
    // if (fileType == kPanpdf) {
    //   panCard = file;
    // }
    if (fileType == kBankpdf) {
      bankPassbook = file;
    }
    if (fileType == kConcentpdf) {
      consentLetter = file;
    }
  }
}
