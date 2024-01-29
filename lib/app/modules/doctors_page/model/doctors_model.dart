class Doctor {
  String docId;
  String docName;
  String designation;
  String hospitalName;
  String consultationTimings;
  String phoneNumber;
  String docImage;
  String specialty;

  Doctor({
    required this.docId,
    required this.docName,
    required this.designation,
    required this.hospitalName,
    required this.consultationTimings,
    required this.phoneNumber,
    required this.docImage,
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
      docImage: data['docImage'] ?? '',
      specialty: data['specialty'] ?? '',
    );
  }
}
