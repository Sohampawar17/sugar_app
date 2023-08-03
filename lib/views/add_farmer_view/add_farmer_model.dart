import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/constants.dart';
import 'package:sugar_mill_app/models/farmer.dart';
import 'package:intl/intl.dart';
import 'package:sugar_mill_app/router.router.dart';
import 'package:sugar_mill_app/services/add_farmer_service.dart';

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

  final List<String> items = ['Transporter', 'Harvester', 'Farmer', 'Member'];
  final List<String> plantlist = ['Bedkihal', 'Nagpur'];
  final List<String> vendorGroupList = ['Cane'];
  List<String> villageList = ["AHERWADI", "BHAWAMWADI", "VASUD"];

  DateTime? selectedDate;
  FarmerData farmerData = FarmerData();

  late String accountNumber;

  late String branchifscCode;

  late String bankName;

  initialise(BuildContext context) async {
    setBusy(true);
    villageList = await AddFarmerService().fetchVillages();
    if (villageList.length == 1 && villageList[0] == "401") {
      if (context.mounted) {
        setBusy(false);
        Navigator.popAndPushNamed(context, Routes.loginViewScreen);
      }
    }
    farmerData.supplierGroup = "CANE";
    setBusy(false);
  }

  void onSavePressed(BuildContext context) async {
    setBusy(true);

    await uploadFiles();
    if (formKey.currentState!.validate()) {
      // Fluttertoast.showToast(msg: "Farmer Added");
      setBusy(true);
      farmerData.bankDetails = bankAccounts;
      bool res = await AddFarmerService().addFarmer(farmerData);
      if (res) {
        if (context.mounted) {
          setBusy(false);
          Navigator.pop(context);
        }
      }

      setBusy(false);
    }
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
    if (value.length != 12) {
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
  String? validateDob(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Date of Birth';
    }
    return null;
  }

  void onDobChanged(String value) {
    // You can use the value here if needed.
    // Since we are using a date picker to select DOB, the value will not change through regular typing.
    farmerData.dateOfBirth = value;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      farmerData.dateOfBirth = dobController.text;
      _calculateAge();
    }
  }

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

  final List<String> _selectedItems = [];

  List<String> get selectedItems => _selectedItems;

  void toggleItem(String item) {
    if (_selectedItems.contains(item)) {
      _selectedItems.remove(item);
      // 'Transporter', 'Harvester', 'Farmer', 'Member'
      if (item == items[0]) {
        farmerData.isTransporter = 0;
      }
      if (item == items[1]) {
        farmerData.isHarvester = 0;
      }
      if (item == items[2]) {
        farmerData.isFarmer = 0;
      }
      if (item == items[3]) {
        farmerData.isMember = 0;
      }
    } else {
      _selectedItems.add(item);
      if (item == items[0]) {
        farmerData.isTransporter = 1;
      }
      if (item == items[1]) {
        farmerData.isHarvester = 1;
      }
      if (item == items[2]) {
        farmerData.isFarmer = 1;
      }
      if (item == items[3]) {
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
  Future<void> selectPdf(String fileType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpeg', 'png'],
    );

    if (result != null) {
      // print("SIZE BEFORE: ${result.files.single.size}");
      setBusy(true);
      File? compressedFile =
          await compressFile(File(result.files.single.path ?? ""));
      // print("SIZE BEFORE: ${compressedFile?.lengthSync()}");
      files.setFile(fileType, compressedFile);
      setBusy(false);
      notifyListeners();
    }
  }

  // Function to upload the selected PDF file (Aadhar card)
  Future<void> uploadFiles() async {
    String aadharUrl =
        await AddFarmerService().uploadDocs(files.adharCard ?? File(""));
    if (aadharUrl == "") {
      Fluttertoast.showToast(msg: "Failed to upload Aadhar");
    }
    String panUrl =
        await AddFarmerService().uploadDocs(files.panCard ?? File(""));
    if (panUrl == "") {
      Fluttertoast.showToast(msg: "Failed to upload Aadhar");
    }
    String bankUrl =
        await AddFarmerService().uploadDocs(files.bankPassbook ?? File(""));
    if (bankUrl == "") {
      Fluttertoast.showToast(msg: "Failed to upload Aadhar");
    }
    String letterUrl =
        await AddFarmerService().uploadDocs(files.consentLetter ?? File(""));
    if (letterUrl == "") {
      Fluttertoast.showToast(msg: "Failed to upload Aadhar");
    }
    farmerData.aadhaarCard = aadharUrl;
    farmerData.panCard = panUrl;
    farmerData.bankPassbook = bankUrl;
    farmerData.consentLetter = letterUrl;
  }

  // Function to check if a PDF file is selected
  bool isFileSelected(String fileType) {
    return files.getFile(fileType) != null;
  }

  ////////////////// Adhar Upload End ///////////////////

  /////////////// Bank Account ///////////////////////////////

  List<FarmerDataBankDetails> bankAccounts = [];

  FarmerData? getFarmerData() {
    farmerData = FarmerData(
      supplierName: 'ABHAY PURANDAR KHOT ',
      supplierType: 'Individual',
      branch: 'Bedkihal',
      aadhaarNumber: '157855154445',
      panNumber: 'df4geh454b',
      mobileNumber: '4759456232',
      dateOfBirth: '1970-05-06',
      existingSupplierCode: '2',
      gender: 'Male',
      age: '53',
      country: 'India',
      supplierGroup: 'CANE',
      isTransporter: 0,
      isHarvester: 0,
      isFarmer: 1,
      isMember: 0,
      village: 'BEDKIHAL',
      circleOffice: 'BEDKIHAL',
      taluka: 'CHIKODI',
      state: 'Karnataka',
      aadhaarCard: '/files/quantbit-client.py',
      bankPassbook: '/files/final_rfid.py',
      panCard: '/files/quantbit-client.py',
      consentLetter: '/files/quantbit-client.py',
      bankDetails: [
        FarmerDataBankDetails(
          farmer: 1,
          harvester: 0,
          transporter: 0,
          bankName: '161930',
          branchifscCode: 'h5785jjjtj',
          accountNumber: '576576567575',
          parent: 'FA-1',
          parentfield: 'bank_details',
          parenttype: 'Farmer List',
          doctype: 'Bank Details',
        ),
      ],
    );
    return farmerData;
  }

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

  void validateForm(BuildContext context, int index) {
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
      notifyListeners();
      return;
    }
    bankAccounts.add(FarmerDataBankDetails(
      farmer: selectedRole == "Farmer" ? 1 : 0,
      harvester: selectedRole == "Harvester" ? 1 : 0,
      transporter: selectedRole == "Transporter" ? 1 : 0,
      bankName: bankName,
      branchifscCode: branchifscCode,
      accountNumber: accountNumber,
    ));
    notifyListeners();
  }

  void setValuesToBankVaribles(int index) {
    if (index != -1) {
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
  File? panCard;
  File? consentLetter;
  File? getFile(String fileType) {
    if (fileType == kAadharpdf) {
      return adharCard;
    }
    if (fileType == kPanpdf) {
      return panCard;
    }
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
    if (fileType == kPanpdf) {
      panCard = file;
    }
    if (fileType == kBankpdf) {
      bankPassbook = file;
    }
    if (fileType == kConcentpdf) {
      consentLetter = file;
    }
  }
}
