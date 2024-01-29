import 'package:edemadetection/app/modules/doctors_page/views/doctors_page_view.dart';
import 'package:edemadetection/screens/detail_screen.dart/aboutUs.dart';
import 'package:edemadetection/screens/detail_screen.dart/edema.dart';
import 'package:edemadetection/screens/detail_screen.dart/result.dart';
import 'package:edemadetection/screens/feedback_page.dart';
import 'package:edemadetection/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detail_screen.dart/check_edema.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String userName = "Guest"; // Default value if user is not logged in
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    // Check if the user is logged in
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is signed in, update the displayed name
        setState(() {
          userName = user.displayName ?? "Guest";
        });
      } else {
        // User is signed out, reset the displayed name
        setState(() {
          userName = "Guest";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: Container(
        decoration: BoxDecoration(
          gradient:LinearGradient(
            colors: [Colors.white, Colors.grey[200]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            "Hi,",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "$userName",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                color: Colors.blue,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),

                    ],
                  ),
                  IconButton(
                    alignment: Alignment.topCenter,
                    icon:  Image.asset("assets/Images/logout_icon.png" ,),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                     Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context)=> const LoginView()
                      )
                      );
                      }
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GridDashboard()
          ],
        ),
      ),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String img;

  Items({
    required this.title,
    required this.subtitle,
    required this.img,
  });
}

class GridDashboard extends StatelessWidget {
  Items item1 = Items(
    title: "Check Edema",
    subtitle: "X-ray/MRI",
    img: "assets/Images/scan_icon.png",
  );

  Items item2 = Items(
    title: "Detection Results",
    subtitle: "Results of the edema detection",
    img: "assets/Images/detection_result_icon.png",
  );
  Items item3 = Items(
    title: "Doctors ",
    subtitle: "Book your appointment",
    img: "assets/Images/doctors.png",
  );
  Items item4 = Items(
    title: "About Edema",
    subtitle: "Causes, Symptoms, and potential treatments.",
    img: "assets/Images/about_disease_icon.png",
  );
  Items item5 = Items(
    title: "Feedbacks",
    subtitle: "Users to give feedback, report issues,",
    img: "assets/Images/feedback_icon.png",

  );
  Items item6 = Items(
    title: "About Us",
    subtitle: " information about our app",
    img: "assets/Images/about_us.png",
  );

  GridDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    return Flexible(
      child: GridView.count(
        childAspectRatio: 0.9,
        padding: const EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: List.generate(myList.length, (index) {
          Items data = myList[index];
          final LinearGradient gradient = _getGradient(index);

          return GestureDetector(
            onTap: () {
              _navigateToScreen(context, data);
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    data.img,
                    width: 60,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Center(
                    child: Text(
                      data.title,
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    data.subtitle,
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Items data) {
    final Map<Items, Widget> screenMap = {
      item1: const CheckEdema(),
      item2: DetectionsResult(),
      item3: const DoctorsPageView(),
      item4: Screen4(data),
      item5: const FeedbackPage(),
      item6: AboutUsPage(),
    };

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screenMap[data]!),
    );
  }
}

LinearGradient _getGradient(int index) {
  // Define your list of gradients
  final List<LinearGradient> gradients = [
    const LinearGradient(
      colors: [Colors.lightBlueAccent, Colors.blue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Colors.purpleAccent, Colors.deepPurple],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Colors.orangeAccent, Colors.deepOrange],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Colors.tealAccent, Colors.teal],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Colors.yellowAccent, Colors.amber],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Colors.redAccent, Colors.red],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    // Add more gradients as needed
  ];


  // Use modulo to repeat gradients if there are more containers than gradients
  return gradients[index % gradients.length];
}

class Data {
  final String img;
  final String title;
  final String subtitle;

  Data({required this.img, required this.title, required this.subtitle});
}


// Add more screens for other items
