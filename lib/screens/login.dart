import 'package:edemadetection/screens/dashboard.dart';
import 'package:edemadetection/screens/home.dart';
import 'package:edemadetection/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  String userName = "Guest"; // Declare userName at the class level

  Future<void> loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Fetch the current user
      User? user = FirebaseAuth.instance.currentUser;

      // Update the user's display name
      await user?.updateDisplayName(usernameController.text);

      // Check if the user exists and has a display name
      if (user != null && user.displayName != null) {
        setState(() {
          userName = user.displayName!;
        });
      } else {
        // If the display name is null, use a default value
        setState(() {
          userName = "Guest";
        });
      }

      // Clear the controllers
      emailController.clear();
      passwordController.clear();
      usernameController.clear();

      // Navigate to the dashboard
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DashBoard(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle authentication exceptions
      if (e.code == 'user-not-found') {
        showSnackbar('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackbar('Wrong password provided for that user.');
      }
    } catch (e) {
      print("Catch: $e");
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login Screen",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: FractionallySizedBox(
        heightFactor: 1.0,
        alignment: Alignment.topCenter,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blueGrey, Colors.deepPurple],
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 150, 20, 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: usernameController, // Add username field
                        decoration: const InputDecoration(
                          hintText: "Enter Username",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: "Enter Email",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          hintText: "Enter Password",
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        loginUser();
                      },
                      child: const Text("Login"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpView(),
                          ),
                        );
                      },
                      child: const Text(
                        "Don't have an account? Register here.",
                        style: TextStyle(
                          color: Colors.white,
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
    );
  }
}
