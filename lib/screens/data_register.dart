import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project2/logics/register/post.dart';
import '../datas/skill_list.dart';
// Imports all Widgets included in [multiselect] package
import 'package:multiselect/multiselect.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<String> selected = [];

  int activeStep = 0;
  int upperBound = 1;

  final fullname = TextEditingController();
  final descriptionInput = TextEditingController();
  final location = TextEditingController();
  final email = TextEditingController();

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  void _pickImage() async {
    try {
      final pickedfile = await _picker.pickImage(source: ImageSource.gallery);
      print(pickedfile!.path);
      setState(() {
        _imageFile = File(pickedfile.path);
        imagename = File(pickedfile.name);
      });
    } catch (e) {
      print(e);
    }
  }

  var imageUrl;
  var imagename;

  @override
  void dispose() {
    fullname.dispose();
    descriptionInput.dispose();
    location.dispose();
    email.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Column(
        children: [
          IconStepper(
            icons: [
              Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
              ),
              Icon(Icons.work, color: Colors.white),
            ],
            activeStep: activeStep,
            enableNextPreviousButtons: false,
            enableStepTapping: false,
            activeStepColor: Theme.of(context).primaryColor,
            activeStepBorderWidth: 2,
          ),
          Expanded(
            child: Column(
              children: [
                content(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [previousButton(), nextButton()],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget nextButton() {
    return activeStep < upperBound
        ? ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(20)),
            ),
            onPressed: () {
              // Increment activeStep, when the next button is tapped. However, check for upper bound.
              if (activeStep < upperBound) {
                setState(() {
                  activeStep++;
                });
              }
            },
            child: Text('Next'),
          )
        : ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(20)),
            ),
            onPressed: () {
              postRegiterData(fullname.text, descriptionInput.text,
                  location.text, email.text, selected, imageUrl, FirebaseAuth.instance.currentUser!.uid);
            },
            child: Text('Send Data'),
          );
  }

  Widget previousButton() {
    return activeStep != 0
        ? ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(20)),
            ),
            onPressed: () {
              // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
              if (activeStep > 0) {
                setState(() {
                  activeStep--;
                });
              }
            },
            child: Text('Previous'),
          )
        : Text(" ");
  }

  Widget content() {
    switch (activeStep) {
      case 0:
        return firstForm();
      case 1:
        return secondPage();
      default:
        return Text("You met some error");
    }
  }

  Widget firstForm() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: fullname,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Full Name"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
                controller: descriptionInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Job Description")),
                minLines: 5,
                maxLines: 50,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Description";
                  } else {
                    return null;
                  }
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: Icon(Icons.image),
                  onPressed: () {
                    _pickImage();
                  },
                ),
                _imageFile == null
                    ? Container(
                        child: Text("No image selected"),
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        child: Image.file(
                          _imageFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () async {
                        final _storage = FirebaseStorage.instance;
                        var snapshot = await _storage
                            .ref()
                            .child('profile_photo/$imagename')
                            .putFile(_imageFile!);

                        snapshot.ref
                            .getDownloadURL()
                            .then((value) => setState(() {
                                  imageUrl = value;
                                }));
                      },
                      child: Text("Upload")),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget secondPage() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: TextFormField(
            controller: email,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Email"),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Please enter Email";
              } else {
                return null;
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: TextFormField(
            controller: location,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Location"),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Please enter your location";
              } else {
                return null;
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: DropDownMultiSelect(
            onChanged: (List<String> x) {
              setState(() {
                selected = x;
              });
            },
            options: skills,
            selectedValues: selected,
            whenEmpty: 'Select your skills',
          ),
        ),
      ],
    );
  }
}
