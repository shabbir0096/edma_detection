import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/doctors_page_controller.dart';
import '../model/doctors_model.dart';

class DoctorsPageView extends GetView<DoctorsPageController> {
  const DoctorsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
        centerTitle: true,
      ),
      body:ListView.builder(
          itemCount: controller.doctors.length,
          itemBuilder: (context, index) {
            return DoctorCard(doctor: controller.doctors[index]);
          },
      )
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDoctorImage(),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDoctorInfo(),
                  const SizedBox(height: 8),
                  Row(children: [
                    _buildContactButton(context),
                    const Spacer(),
                    _buildMessageButton(context),

                  ],)


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(doctor.docImage),
        ),

      ),

    );
  }

  Widget _buildDoctorInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          doctor.docName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text('Phone: ${doctor.phoneNumber}'),
        Text('Hospital: ${doctor.hospitalName}'),
        Text('Designation: ${doctor.designation}'),
        Text('Specialization: ${doctor.specialty}'),
        Text('Consultation Timings\n ${doctor.consultationTimings}'),
      ],
    );
  }

  Widget _buildContactButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _makePhoneCall(doctor.phoneNumber);
      },
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor, // You can customize the button color
      ),
      child: const Text('Contact' , style: TextStyle(color: Colors.white, fontSize: 12),),
    );

  }
  Widget _buildMessageButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _sendSMS(doctor.phoneNumber);
      },
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor, // You can customize the button color
      ),
      child: const Text('Message' , style: TextStyle(color: Colors.white, fontSize: 12),),
    );

  }
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  Future<void> _sendSMS(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}