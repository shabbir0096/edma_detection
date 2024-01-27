import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edemadetection/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/services/firebase_services.dart';
import '../app/widgets/snackbars.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isPasswordVisible = true;

  late var isLoading = false;
  String error = '';
  User? user = FirebaseAuth.instance.currentUser;

  void saveUserFeedbackFirestore(User? user) async {

    final commentValue = commentController.value.text.trim().toString();
    try {
      await FirebaseFirestore.instance.collection('feedback').doc().set({
        'user_id': user!.uid,
        'comment_value': commentValue,
        'user_email': user.email,
        'created_date': user.metadata.creationTime,
        'modified_date': '',
        'status': true,
      });
      showSnackBarSuccess(
        "Successfully Uploaded ","Thank you for your feedback.",
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DashBoard(),
        ),
      );
    } catch (e) {
      showSnackBarSuccess(
        "Error",
        e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        centerTitle: true,
      ),
      body: FractionallySizedBox(
        heightFactor: 1.0,
        child: Container(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                    padding:
                    const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10,  bottom: 30),
                          child: Image(
                            image: AssetImage('assets/Images/feedback_vector.jpg'),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                              initialValue: "${user?.email}",
                              readOnly: true,
                              decoration: const InputDecoration(
                                hintText: "Enter email",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email address';
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                              controller: commentController,
                              decoration: const InputDecoration(
                                hintText: "Enter your comment here",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your comment here';
                                }
                              }),
                        ),

                        Text(
                          " $error" , style: const TextStyle(color: Colors.red),
                        ),
                        isLoading
                            ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ))
                            : ElevatedButton(
                          onPressed: () {
                            error = '';
                            if (_formKey.currentState!.validate()) {
                              saveUserFeedbackFirestore(user);
                            } else {
                              //  has validation errors, enable error borders
                              _formKey.currentState!.validate();
                            }
                          },
                          child: const Text("Send" , ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
