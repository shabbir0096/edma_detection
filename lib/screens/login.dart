import 'package:edemadetection/screens/dashboard.dart';
import 'package:edemadetection/screens/signup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../app/widgets/snackbars.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var isPasswordVisible = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool isLoading = false;
  String error = '';
  String errorMessage = 'An error occurred during login.';

  String userName = "Guest"; // Declare userName at the class level
  void handleSignIn() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    login(email, password);
  }

  Future<UserCredential?> login(String email, String password) async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (kDebugMode) {
        print(userCredential.user!.displayName);
      }

      User? user = FirebaseAuth.instance.currentUser;

      // Update the user's display name
      await user?.updateDisplayName(usernameController.text);

      // Check if the user exists and has a display name
      if (user != null && user.displayName != null) {
        setState(() {
          userName = user.displayName!;
        });
      } else {
        // If the display name is null, use a default
        setState(() {
          userName = "Guest";
        });
      }
      emailController.clear();
      passwordController.clear();
      usernameController.clear();
      setState(() {
        isLoading = false;
      });
      showSnackBarSuccess("Success", "Logged Successful");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DashBoard(),
        ),
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        errorMessage = "User not found. Please check your email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Invalid password. Please try again.";
      } else {
        errorMessage = "Login failed. Please try again later.";
      }
      error = errorMessage;
      return null;
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      showSnackBarError("Message", e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        heightFactor: 1.0,
        alignment: Alignment.topCenter,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Images/login_bg.jpg'),
              // Replace with your image asset path
              fit: BoxFit
                  .cover, // You can choose different BoxFits based on your requirement
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
                        padding: EdgeInsets.all(100.0),
                        child: Image(
                          image: AssetImage('assets/Images/app_logo.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                            controller: emailController,
                            decoration:  const InputDecoration(
                              hintText: "Enter email address",
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
                                onPressed: (){
                                  if(isPasswordVisible == false){
                                    setState(() {
                                      isPasswordVisible = true;
                                    });
                                  }
                                  else{
                                    setState(() {
                                      isPasswordVisible = false;
                                    });
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
                                if (_formKey.currentState!.validate()) {
                                  handleSignIn();
                                } else {
                                  //  has validation errors, enable error borders
                                  _formKey.currentState!.validate();
                                }
                              },
                              child: const Text("Login"),
                            ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpView(),
                            ),
                          );
                        },
                        child: const Text(
                          "Don't have an account? Register here.",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
