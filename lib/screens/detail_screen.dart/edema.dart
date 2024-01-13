import 'package:edemadetection/screens/dashboard.dart';
import 'package:flutter/material.dart';

class Screen4 extends StatelessWidget {
  final Items item;

  Screen4(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 96, 80, 117),
      appBar: AppBar(
        title: Center(child: Text(item.title)),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Overview of Edema",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "Edema is a medical condition characterized by the abnormal accumulation of fluid in body tissues, leading to swelling.This swelling is typically caused by the leakage of fluid from blood vessels into surrounding tissues.",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white)),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Causes of Edema",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "Common causes of edema include heart failure, kidney disease, liver disease, and certain medications. Injuries, inflammation, and conditions like venous insufficiency can also contribute to localized edema.",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white)),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Symptoms of Edema",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "Symptoms of edema may include swelling, puffiness, and changes in skin texture. The affected area might feel heavy or appear stretched, and pressing on the swollen area may leave a temporary indentation.",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white)),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Types of Edema",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "There are various types of edema, including peripheral edema (affecting the limbs), pulmonary edema (fluid in the lungs), and cerebral edema (fluid in the brain). Each type has specific causes and symptoms.",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white)),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Risk Factors",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "Risk factors for edema include age, pregnancy, obesity, a sedentary lifestyle, and certain medical conditions. Individuals with a history of deep vein thrombosis (DVT) or varicose veins may also be at a higher risk.",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white)),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Treatment Options",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "Treatment for edema depends on the underlying cause. It may include lifestyle changes such as reducing salt intake, medications like diuretics, compression therapy, and addressing the root cause of the condition. Severe cases may require surgical intervention.",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white)),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("When to Seek Medical Attention",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "It is important to seek medical attention if there is sudden or severe swelling, difficulty breathing, chest pain, or if the swelling is accompanied by other concerning symptoms. Prompt medical evaluation is crucial for an accurate diagnosis and appropriate treatment.",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
