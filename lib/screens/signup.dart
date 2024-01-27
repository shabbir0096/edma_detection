import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edemadetection/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app/widgets/snackbars.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isPasswordVisible = true;

  late var isLoading = false;
  String error = '';

  // Future<void> registerUser() async {
  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //
  //     // Update the user's display name
  //     await userCredential.user?.updateDisplayName(usernameController.text);
  //
  //     // Fetch the current user
  //     User? user = FirebaseAuth.instance.currentUser;
  //
  //     emailController.clear();
  //     passwordController.clear();
  //     usernameController.clear();
  //
  //     // Navigate to the dashboard
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => const DashBoard(),
  //       ),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print("=============== Catch ===================");
  //     print(e);
  //   }
  // }

  bool isNameValid(String name) {
    const pattern = r'^[a-zA-Z ]+$';
    final regex = RegExp(pattern);
    return regex.hasMatch(name);
  }

  void handleSignup() {
    final email = emailController.value.text.trim();
    final password = passwordController.value.text.trim();
    registerUser(email, password);
  }

  void registerUser(String email, String password) async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      saveUserDataToFirestore(user);

      setState(() {
        isLoading = false;
      });
      showSnackBarSuccess("Successful", "Your account has been registered.");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginView(),
        ),
      );

    } catch (e) {
      setState(() {
        isLoading = false;
      });
      String errorMessage = 'An error occurred during registration.';

      if (e is FirebaseAuthException) {
        errorMessage = _getFirebaseAuthErrorMessage(e.code);
      }
      setState(() {
        error = errorMessage;
      });
    }
  }

  void saveUserDataToFirestore(User? user) async {
    final username = usernameController.value.text.trim().toString();
    try {
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'user_id': user!.uid,
        'user_username': username,
        'user_email': user.email,
        'profile_url': '',
        'created_date': user.metadata.creationTime,
        'modified_date': '',
        'status': true,
      });
    } catch (e) {
      showSnackBarSuccess(
        "Error",
        e.toString(),
      );
    }
  }

  String _getFirebaseAuthErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      default:
        return 'An unknown error occurred.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        heightFactor: 1.0,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Images/login_bg.jpg'),
              // Replace with your image asset path
              fit: BoxFit
                  .cover, // You can choose different BoxFit values based on your requirement
            ),
          ),
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
                              left: 100.0, right: 100, top: 100, bottom: 30),
                          child: Image(
                            image: AssetImage('assets/Images/app_logo.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            controller: usernameController,
                            decoration: const InputDecoration(
                              hintText: "Enter username",
                            ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter username';
                                }
                              }
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                              controller: emailController,
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
                            controller: passwordController,
                            obscureText: isPasswordVisible,
                            decoration:  InputDecoration(
                              hintText: "Enter password",
                              suffixIcon: IconButton(
                                onPressed: () => {
                                  if(isPasswordVisible == false){
                                    setState(() {
                                      isPasswordVisible = true;
                                    })
                                  }
                                  else{
                                    setState(() {
                                      isPasswordVisible = false;
                                    })
                                  }
                                },
                                icon: isPasswordVisible
                                    ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black,
                                )
                                    : const Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
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
                                    handleSignup();
                                  } else {
                                    //  has validation errors, enable error borders
                                    _formKey.currentState!.validate();
                                  }
                                },
                                child: const Text("Register"),
                              ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginView(),
                              ),
                            );
                          },
                          child: const Text(
                            "Do you already have an account? Login here.",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
