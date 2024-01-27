class Doctor {
  String docId;
  String docName;
  String designation;
  String hospitalName;
  String consultationTimings;
  String phoneNumber;
  String doctorImage;
  String specialty;

  Doctor({
    required this.docId,
    required this.docName,
    required this.designation,
    required this.hospitalName,
    required this.consultationTimings,
    required this.phoneNumber,
    required this.doctorImage,
    required this.specialty,
  });

  factory Doctor.fromFirestore(Map<String, dynamic> data) {
    return Doctor(
      docId: data['docId'] ?? '',
      docName: data['docName'] ?? '',
      designation: data['designation'] ?? '',
      hospitalName: data['hospitalName'] ?? '',
      consultationTimings: data['consultationTimings'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      doctorImage: data['doctorImage'] ?? '',
      specialty: data['specialty'] ?? '',
    );
  }
}
