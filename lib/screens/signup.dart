import 'package:edemadetection/screens/dashboard.dart';
import 'package:edemadetection/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  Future<void> registerUser() async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    // Update the user's display name
    await userCredential.user?.updateDisplayName(usernameController.text);

    // Fetch the current user
    User? user = FirebaseAuth.instance.currentUser;

    print("=============== Registered Successfully ===================");
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
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print("=============== Catch ===================");
    print(e);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
        centerTitle: true,
        title: const Text("Signup", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: FractionallySizedBox(
               heightFactor: 1.0,
        child: Container(
          decoration:const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blueGrey, Colors.deepPurple], // Replace with your desired gradient colors
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
        controller: usernameController,
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
        registerUser();
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
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
)

              ),
            ),
          ),
        ),
      ),
    );
  }
}
