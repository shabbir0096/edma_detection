import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edemadetection/screens/dashboard.dart';
import 'package:flutter/material.dart';

import '../../app/models/edema_result_model.dart';

class DetectionsResult extends StatefulWidget {

  final String userId;
  DetectionsResult({super.key, required this.userId});

  @override
  State<DetectionsResult> createState() => _DetectionsResultState();
}

class _DetectionsResultState extends State<DetectionsResult> {

  late Future<List<EdemaResult>> data;
  @override
  void initState() {
    super.initState();
    data = getDataByUserId(widget.userId);
  }

  Future<List<EdemaResult>> getDataByUserId(String userId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('edema_results')
        .where('user_id', isEqualTo: userId)
        .get();

    List<EdemaResult> results = querySnapshot.docs
        .map((doc) => EdemaResult.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    print("result data is $results");
    return results;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edema Results'),
      ),
      body: FutureBuilder<List<EdemaResult>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var result = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      result.resultImageUrl.isNotEmpty
                          ? Image.network(
                        result.resultImageUrl,
                        fit: BoxFit.cover, // Adjust the fit based on your design
                        height: 200.0, // Set the desired height of the image
                      )
                          : Container(), // Empty container if no image
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Result: ${result.result}"),
                            SizedBox(height: 8.0),
                            Text("Key: ${result.key}"),
                            SizedBox(height: 8.0),
                          //  Text("Created Date: ${result.createdDate}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
