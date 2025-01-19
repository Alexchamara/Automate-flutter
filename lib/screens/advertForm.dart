import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:automate/providers/authProvider.dart';
import 'package:automate/models/user.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../controllers/listing_controller.dart';
import '../models/listing.dart';
import 'login.dart';

class CreateAdvertForm extends StatefulWidget {
  static final String id = 'CreateAdvertForm';

  const CreateAdvertForm({super.key});

  @override
  State<CreateAdvertForm> createState() => _CreateAdvertFormState();
}

class _CreateAdvertFormState extends State<CreateAdvertForm> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  String? _validationMessage;

  // Controllers for Advert Details
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();

  // Dropdown values for Vehicle Details
  String? _selectedBrand;
  String? _selectedModel;
  String? _selectedYear;
  String? _selectedCondition;
  String? _selectedEngine;
  String? _selectedColor;
  String? _selectedBodyType;
  String? _selectedGearBox;
  String? _selectedFuelType;

  // List to store uploaded images
  List<File> _uploadedImages = [];

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _uploadedImages.add(File(image.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _uploadedImages.removeAt(index);
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (!authProvider.authenticated()) {
        Navigator.pushNamed(context, LoginPage.id);
        return;
      }

      final listing = Listing(
        id: 0,
        advertId: 0,
        status: '',
        statusUpdatedAt: DateTime.now(),
        isActive: true,
        paymentStatus: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: authProvider.getUser().id,
        token: '',
        brand: _selectedBrand!,
        model: _selectedModel!,
        year: _selectedYear!,
        mileage: int.parse(_mileageController.text),
        condition: _selectedCondition!,
        color: _selectedColor!,
        engine: _selectedEngine!,
        bodyType: _selectedBodyType!,
        gearBox: _selectedGearBox!,
        fuelType: _selectedFuelType!,
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        location: _locationController.text,
        images: _uploadedImages,
      );

      try {
        await ListingController.createListing(context, listing);
        setState(() {
          _validationMessage = null; // Clear validation message on success
        });
      } catch (e) {
        setState(() {
          _validationMessage = 'Failed to create listing: ${e.toString()}';
        });
      }
    } else {
      setState(() {
        _validationMessage = 'Please fill out all required fields.';
      });
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Create Advert',
  //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  //       leading: IconButton(
  //         icon: const Icon(Icons.arrow_back),
  //         color: Colors.white,
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //       ),
  //     ),
  //     body: Form(
  //       key: _formKey,
  //       child: Stepper(
  //         currentStep: _currentStep,
  //         onStepContinue: () {
  //           if (_currentStep < 1) {
  //             setState(() {
  //               _currentStep += 1;
  //             });
  //           } else {
  //             if (_formKey.currentState!.validate()) {
  //               // Save the form
  //             }
  //           }
  //         },
  //         onStepCancel: () {
  //           if (_currentStep > 0) {
  //             setState(() {
  //               _currentStep -= 1;
  //             });
  //           }
  //         },
  //         steps: [
  //           Step(
  //             title: const Text('Vehicle Details'),
  //             content: Column(
  //               children: [
  //                 _buildDropdown(
  //                     'Vehicle Brand', _selectedBrand, ['Brand A', 'Brand B'],
  //                     (value) {
  //                   setState(() {
  //                     _selectedBrand = value;
  //                   });
  //                 }),
  //                 _buildDropdown(
  //                     'Model', _selectedModel, ['Model X', 'Model Y'], (value) {
  //                   setState(() {
  //                     _selectedModel = value;
  //                   });
  //                 }),
  //                 _buildDropdown(
  //                     'Year of Registration', _selectedYear, ['2020', '2021'],
  //                     (value) {
  //                   setState(() {
  //                     _selectedYear = value;
  //                   });
  //                 }),
  //                 TextFormField(
  //                   controller: _mileageController,
  //                   decoration:
  //                       const InputDecoration(labelText: 'Current Mileage'),
  //                   validator: (value) {
  //                     if (value == null || value.isEmpty) {
  //                       return 'Please enter the current mileage';
  //                     }
  //                     return null;
  //                   },
  //                 ),
  //                 _buildDropdown(
  //                     'Condition', _selectedCondition, ['New', 'Used'],
  //                     (value) {
  //                   setState(() {
  //                     _selectedCondition = value;
  //                   });
  //                 }),
  //                 _buildDropdown('Engine', _selectedEngine, ['1.4L', '2.0L'],
  //                     (value) {
  //                   setState(() {
  //                     _selectedEngine = value;
  //                   });
  //                 }),
  //                 _buildDropdown('Color', _selectedColor, ['Red', 'Blue'],
  //                     (value) {
  //                   setState(() {
  //                     _selectedColor = value;
  //                   });
  //                 }),
  //                 _buildDropdown(
  //                     'Body Type', _selectedBodyType, ['Sedan', 'SUV'],
  //                     (value) {
  //                   setState(() {
  //                     _selectedBodyType = value;
  //                   });
  //                 }),
  //                 _buildDropdown(
  //                     'Gear Box', _selectedGearBox, ['Automatic', 'Manual'],
  //                     (value) {
  //                   setState(() {
  //                     _selectedGearBox = value;
  //                   });
  //                 }),
  //                 _buildDropdown(
  //                     'Fuel Type', _selectedFuelType, ['Petrol', 'Diesel'],
  //                     (value) {
  //                   setState(() {
  //                     _selectedFuelType = value;
  //                   });
  //                 }),
  //               ],
  //             ),
  //             isActive: _currentStep >= 0,
  //             state: _currentStep > 0 ? StepState.complete : StepState.indexed,
  //           ),
  //           Step(
  //             title: const Text('Advert Details'),
  //             content: Column(
  //               children: [
  //                 ElevatedButton(
  //                   onPressed: _pickImage,
  //                   child: const Text('Upload Images'),
  //                 ),
  //                 Wrap(
  //                   children: _uploadedImages.map((image) {
  //                     int index = _uploadedImages.indexOf(image);
  //                     return Stack(
  //                       children: [
  //                         Image.file(image,
  //                             width: 100, height: 100, fit: BoxFit.cover),
  //                         Positioned(
  //                           right: 0,
  //                           child: IconButton(
  //                             icon: const Icon(Icons.remove_circle,
  //                                 color: Colors.red),
  //                             onPressed: () => _removeImage(index),
  //                           ),
  //                         ),
  //                       ],
  //                     );
  //                   }).toList(),
  //                 ),
  //                 TextFormField(
  //                   controller: _priceController,
  //                   decoration: const InputDecoration(labelText: 'Price'),
  //                   validator: (value) {
  //                     if (value == null || value.isEmpty) {
  //                       return 'Please enter the price';
  //                     }
  //                     return null;
  //                   },
  //                 ),
  //                 TextFormField(
  //                   controller: _descriptionController,
  //                   decoration: const InputDecoration(labelText: 'Description'),
  //                   validator: (value) {
  //                     if (value == null || value.isEmpty) {
  //                       return 'Please enter the description';
  //                     }
  //                     return null;
  //                   },
  //                 ),
  //                 TextFormField(
  //                   controller: _phoneController,
  //                   decoration:
  //                       const InputDecoration(labelText: 'Phone Number'),
  //                   validator: (value) {
  //                     if (value == null || value.isEmpty) {
  //                       return 'Please enter the phone number';
  //                     }
  //                     return null;
  //                   },
  //                 ),
  //                 TextFormField(
  //                   controller: _emailController,
  //                   decoration: const InputDecoration(labelText: 'Email'),
  //                   validator: (value) {
  //                     if (value == null || value.isEmpty) {
  //                       return 'Please enter the email';
  //                     }
  //                     return null;
  //                   },
  //                 ),
  //                 TextFormField(
  //                   controller: _locationController,
  //                   decoration: const InputDecoration(labelText: 'Location'),
  //                   validator: (value) {
  //                     if (value == null || value.isEmpty) {
  //                       return 'Please enter the location';
  //                     }
  //                     return null;
  //                   },
  //                 ),
  //               ],
  //             ),
  //             isActive: _currentStep >= 1,
  //             state: _currentStep > 1 ? StepState.complete : StepState.indexed,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Advert',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stepper(
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep < 2) {
                    setState(() {
                      _currentStep += 1;
                    });
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() {
                      _currentStep -= 1;
                    });
                  }
                },
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        if (_currentStep != 1)
                          ElevatedButton(
                            onPressed: details.onStepContinue,
                            child: const Text('Next'),
                          ),
                        const SizedBox(width: 8),
                        if (_currentStep != 0)
                          ElevatedButton(
                            onPressed: details.onStepCancel,
                            child: const Text('Back'),
                          ),
                      ],
                    ),
                  );
                },
                steps: [
                  Step(
                    title: Text("Step 1: Vehicle Details"),
                    content: Column(
                      children: [
                        _buildDropdown('Vehicle Brand', _selectedBrand,
                            ['Brand A', 'Brand B'], (value) {
                          setState(() {
                            _selectedBrand = value;
                          });
                        }),
                        _buildDropdown(
                            'Model', _selectedModel, ['Model X', 'Model Y'],
                            (value) {
                          setState(() {
                            _selectedModel = value;
                          });
                        }),
                        _buildDropdown('Year of Registration', _selectedYear,
                            ['2020', '2021'], (value) {
                          setState(() {
                            _selectedYear = value;
                          });
                        }),
                        TextFormField(
                          controller: _mileageController,
                          decoration: const InputDecoration(
                              labelText: 'Current Mileage'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the current mileage';
                            }
                            return null;
                          },
                        ),
                        _buildDropdown(
                            'Condition', _selectedCondition, ['New', 'Used'],
                            (value) {
                          setState(() {
                            _selectedCondition = value;
                          });
                        }),
                        _buildDropdown(
                            'Engine', _selectedEngine, ['1.4L', '2.0L'],
                            (value) {
                          setState(() {
                            _selectedEngine = value;
                          });
                        }),
                        _buildDropdown('Color', _selectedColor, ['Red', 'Blue'],
                            (value) {
                          setState(() {
                            _selectedColor = value;
                          });
                        }),
                        _buildDropdown(
                            'Body Type', _selectedBodyType, ['Sedan', 'SUV'],
                            (value) {
                          setState(() {
                            _selectedBodyType = value;
                          });
                        }),
                        _buildDropdown('Gear Box', _selectedGearBox,
                            ['Automatic', 'Manual'], (value) {
                          setState(() {
                            _selectedGearBox = value;
                          });
                        }),
                        _buildDropdown('Fuel Type', _selectedFuelType,
                            ['Petrol', 'Diesel'], (value) {
                          setState(() {
                            _selectedFuelType = value;
                          });
                        }),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: Text("Step 2: Contact Details"),
                    content: Column(
                      children: [
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: const Text('Upload Images'),
                        ),
                        Wrap(
                          children: _uploadedImages.map((image) {
                            int index = _uploadedImages.indexOf(image);
                            return Stack(
                              children: [
                                Image.file(image,
                                    width: 100, height: 100, fit: BoxFit.cover),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.remove_circle,
                                        color: Colors.red),
                                    onPressed: () => _removeImage(index),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                        TextFormField(
                          controller: _priceController,
                          decoration: const InputDecoration(labelText: 'Price'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the price';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _descriptionController,
                          decoration:
                              const InputDecoration(labelText: 'Description'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the description';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _phoneController,
                          decoration:
                              const InputDecoration(labelText: 'Phone Number'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the phone number';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _locationController,
                          decoration:
                              const InputDecoration(labelText: 'Location'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the location';
                            }
                            return null;
                          },
                        ),
                        if (_validationMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              _validationMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                    isActive: _currentStep >= 1,
                    state: _currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MaterialButton(
                  height: 50,
                  minWidth: double.infinity,
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    // Handle form submission logic
                    _submitForm();
                  },
                  child: Text(
                    'Submit',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items,
      ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      value: value,
      onChanged: onChanged,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}
