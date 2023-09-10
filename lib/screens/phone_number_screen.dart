import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../database_manager/data_base_helper.dart';
import 'next_screen.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  String _errorMessage = '';
  bool _submitButtonEnabled = false;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    final result = await InternetConnectionChecker().hasConnection;
    setState(() {
      _isConnected = result == true;
      if (!_isConnected) {
        _errorMessage = 'Please check your internet connection';
      }
    });
  }

  void validatePhoneNumber(String value) {
    setState(() {
      _errorMessage = value.length != 10 ? 'Phone number must be 10 digits' : '';
      _submitButtonEnabled = _isConnected && _errorMessage.isEmpty;
    });
  }

  void submitPhoneNumber() async {
    final phoneNumber = _phoneNumberController.text.trim();
    
    await _databaseHelper.insertPhoneNumber(phoneNumber);


    //we used PageRouteBuilder because we need to add a simple fade transition in switching the page 
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context,animation,secondaryAnimation){
          return FadeTransition(
                      opacity: animation,
                      child: NextScreen(
                        phoneNumber: _phoneNumberController.text,
                      ),
                    );
                  },
        // builder: (context) => NextScreen(phoneNumber: phoneNumber),
      ),
    );
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number App'),  
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
                onChanged: validatePhoneNumber,
                decoration: InputDecoration(
                  hintText: 'Enter a 10-digits number',
                  labelText: 'Enter phone number',
                  errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitButtonEnabled ? submitPhoneNumber : null,
                style: ElevatedButton.styleFrom(
    primary: Theme.of(context).primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    textStyle: TextStyle(fontSize: 18),
  ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
    );
  }
}
