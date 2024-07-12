import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: BloodDonorRegistrationForm(),
    theme: ThemeData(
      primaryColor: Color(0xFFD32F2F),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFC2185B)),
      scaffoldBackgroundColor: Color(0xFFFFEBEE),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Color(0xFFB71C1C)),
        bodyMedium: TextStyle(color: Color(0xFFB71C1C)),
      ),
    ),
  ));
}

class BloodDonorRegistrationForm extends StatefulWidget {
  @override
  _BloodDonorRegistrationFormState createState() =>
      _BloodDonorRegistrationFormState();
}

class _BloodDonorRegistrationFormState
    extends State<BloodDonorRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String? email,
      name,
      usn,
      age,
      gender,
      bloodGroup,
      mobileNumber,
      additionalMobileNumber,
      pinCode,
      donations,
      lastDonationDate,
      medicalCondition,
      drinkingSmoking,
      closeToNeedy,
      donationExperience;

  bool donatedPlatelets = false;
  DateTime? selectedDate;
  TextEditingController lastDonationDateController = TextEditingController();

  @override
  void dispose() {
    lastDonationDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Donor Registration'),
        backgroundColor: Color(0xFFD32F2F),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Email ID', (value) {
                return value!.isEmpty ? 'Please enter your email ID' : null;
              }, (value) {
                email = value;
              }),
              _buildTextField('Name of the donor', (value) {
                return value!.isEmpty ? 'Please enter your name' : null;
              }, (value) {
                name = value;
              }),
              _buildTextField('USN', (value) {
                return value!.isEmpty ? 'Please enter your USN' : null;
              }, (value) {
                usn = value;
              }),
              _buildTextField('Donor Age', (value) {
                return value!.isEmpty ? 'Please enter your age' : null;
              }, (value) {
                age = value;
              }, keyboardType: TextInputType.number),
              _buildGenderRadio(),
              _buildBloodGroupDropdown(),
              _buildTextField('Donor mobile number', (value) {
                return value!.isEmpty
                    ? 'Please enter your mobile number'
                    : null;
              }, (value) {
                mobileNumber = value;
              }, keyboardType: TextInputType.phone),
              _buildTextField('Donor Additional mobile number', (value) {
                return value!.isEmpty
                    ? 'Please enter an additional mobile number'
                    : null;
              }, (value) {
                additionalMobileNumber = value;
              }, keyboardType: TextInputType.phone),
              _buildTextField('Address Pin code', (value) {
                return value!.isEmpty ? 'Please enter your pin code' : null;
              }, (value) {
                pinCode = value;
              }, keyboardType: TextInputType.number),
              SwitchListTile(
                title: const Text('Have you donated platelets?'),
                value: donatedPlatelets,
                onChanged: (value) => setState(() => donatedPlatelets = value),
              ),
              _buildTextField('Number of donations', (value) {
                return value!.isEmpty
                    ? 'Please enter the number of donations'
                    : null;
              }, (value) {
                donations = value;
              }, keyboardType: TextInputType.number),
              _buildDateField(),
              _buildMedicalConditionRadio(),
              _buildDrinkingSmokingRadio(),
              _buildCloseToNeedyRadio(),
              _buildTextField('Share your blood donation experience', (value) {
                return value!.isEmpty ? 'Please share your experience' : null;
              }, (value) {
                donationExperience = value;
              }, maxLines: 3),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC62828), // Submit button color
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Handle the form submission here
                      _printFormData();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String? Function(String?) validator,
      void Function(String?) onSaved,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Color(0xFFB71C1C)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFC2185B)),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      onSaved: onSaved,
    );
  }

  Widget _buildGenderRadio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Donor Gender', style: TextStyle(color: Color(0xFFB71C1C))),
        ListTile(
          title: const Text('Male'),
          leading: Radio<String>(
            value: 'Male',
            groupValue: gender,
            onChanged: (value) => setState(() => gender = value),
          ),
        ),
        ListTile(
          title: const Text('Female'),
          leading: Radio<String>(
            value: 'Female',
            groupValue: gender,
            onChanged: (value) => setState(() => gender = value),
          ),
        ),
        ListTile(
          title: const Text('Non-binary'),
          leading: Radio<String>(
            value: 'Non-binary',
            groupValue: gender,
            onChanged: (value) => setState(() => gender = value),
          ),
        ),
      ],
    );
  }

  Widget _buildBloodGroupDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Donor Blood Group',
        labelStyle: TextStyle(color: Color(0xFFB71C1C)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFC2185B)),
        ),
      ),
      items: [
        DropdownMenuItem(value: 'A+', child: Text('A RhD positive (A+)')),
        DropdownMenuItem(value: 'A-', child: Text('A RhD negative (A-)')),
        DropdownMenuItem(value: 'B+', child: Text('B RhD positive (B+)')),
        DropdownMenuItem(value: 'B-', child: Text('B RhD negative (B-)')),
        DropdownMenuItem(value: 'O+', child: Text('O RhD positive (O+)')),
        DropdownMenuItem(value: 'O-', child: Text('O RhD negative (O-)')),
        DropdownMenuItem(value: 'AB+', child: Text('AB RhD positive (AB+)')),
        DropdownMenuItem(value: 'AB-', child: Text('AB RhD negative (AB-)')),
      ],
      onChanged: (value) => setState(() => bloodGroup = value),
      validator: (value) =>
          value == null ? 'Please select your blood group' : null,
      onSaved: (value) => bloodGroup = value,
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Last Date of Donation',
        labelStyle: TextStyle(color: Color(0xFFB71C1C)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFC2185B)),
        ),
      ),
      controller: lastDonationDateController,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (picked != null && picked != selectedDate) {
          setState(() {
            selectedDate = picked;
            lastDonationDate = "${picked.toLocal()}".split(' ')[0];
            lastDonationDateController.text = lastDonationDate!;
          });
        }
      },
      validator: (value) =>
          value!.isEmpty ? 'Please enter the last date of donation' : null,
      onSaved: (value) => lastDonationDate = value,
    );
  }

  Widget _buildMedicalConditionRadio() {
    return _buildYesNoRadio('Are you under any medical condition?',
        (value) => medicalCondition = value);
  }

  Widget _buildDrinkingSmokingRadio() {
    return _buildYesNoRadio(
        'Drinking and smoking?', (value) => drinkingSmoking = value);
  }

  Widget _buildCloseToNeedyRadio() {
    return _buildYesNoRadio('Will you donate blood if you stay close to needy?',
        (value) => closeToNeedy = value);
  }

  Widget _buildYesNoRadio(String question, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: TextStyle(color: Color(0xFFB71C1C))),
        ListTile(
          title: const Text('Yes'),
          leading: Radio<String>(
            value: 'Yes',
            groupValue: medicalCondition,
            onChanged: onChanged,
          ),
        ),
        ListTile(
          title: const Text('No'),
          leading: Radio<String>(
            value: 'No',
            groupValue: medicalCondition,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _printFormData() {
    print("Email: $email");
    print("Name: $name");
    print("USN: $usn");
    print("Age: $age");
    print("Gender: $gender");
    print("Blood Group: $bloodGroup");
    print("Mobile Number: $mobileNumber");
    print("Additional Mobile Number: $additionalMobileNumber");
    print("Pin Code: $pinCode");
    print("Donated Platelets: $donatedPlatelets");
    print("Number of Donations: $donations");
    print("Last Donation Date: $lastDonationDate");
    print("Medical Condition: $medicalCondition");
    print("Drinking and Smoking: $drinkingSmoking");
    print("Close to Needy: $closeToNeedy");
    print("Donation Experience: $donationExperience");
  }
}
