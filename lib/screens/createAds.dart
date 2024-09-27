import 'package:flutter/material.dart';

class CreateAds extends StatefulWidget {
  static final String id = 'CreateAds';

  const CreateAds({super.key});

  @override
  State<CreateAds> createState() => _CreateAdsState();
}

class _CreateAdsState extends State<CreateAds> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Ads',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? const CreateAdsPortrait()
              : const CreateAdsLandscape();
        },
      ),
    ));
  }
}

// CreateAdsPortrait widget
class CreateAdsPortrait extends StatelessWidget {
  const CreateAdsPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Center(
              child: Column(
                children: [
                  // CreateAdsForm
                  CreateAdsForm(
                    optionText: 'Title',
                    optionHidenText: 'Enter the title of the ad',
                  ),
                  DropDown(
                    optionText: 'Category',
                    optionHidenText: 'Select the category of the ad',
                    options: ['Cars', 'Electronics', 'Fashion', 'Home & Garden', 'Jobs', 'Property', 'Services'],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CreateAdsLandscape widget
class CreateAdsLandscape extends StatelessWidget {
  const CreateAdsLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Center(
              child: Column(
                children: [
                  // CreateAdsForm
                  CreateAdsForm(
                    optionText: 'Title',
                    optionHidenText: 'Enter the title of the ad',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CreateAds Form
class CreateAdsForm extends StatefulWidget {
  final String optionText;
  final String optionHidenText;

  const CreateAdsForm({super.key, required this.optionText, required this.optionHidenText});

  @override
  State<CreateAdsForm> createState() => _CreateAdsFormState();
}

class _CreateAdsFormState extends State<CreateAdsForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Title
          TextFormField(
            decoration: InputDecoration(
              labelText: widget.optionText,
              hintText: widget.optionHidenText,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required.';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),
          // TextFormField
        ],
      ),
    );
  }
}

//drop down
class DropDown extends StatefulWidget {
  final String optionText;
  final String optionHidenText;
  final List<String> options;

  const DropDown({super.key, required this.optionText, required this.optionHidenText, required this.options});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Title
          DropdownButtonFormField<String>(
            value: dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down_sharp),
            iconSize: 24,
            elevation: 16,
            style:  TextStyle(color: Theme.of(context).primaryColor),
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: widget.options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          // TextFormField
        ],
      ),
    );
  }
}