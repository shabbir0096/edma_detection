class EdemaResult {
  String? id; // Document ID
  String userId;
  double result;
  String key;
  String resultImageUrl;
  // DateTime createdDate;
  // DateTime? modifiedDate;
  bool status;

  EdemaResult({
    this.id,
    required this.userId,
    required this.result,
    required this.key,
    required this.resultImageUrl,
    // required this.createdDate,
    // this.modifiedDate,
    required this.status,
  });

  factory EdemaResult.fromJson(Map<String, dynamic> json) {
    return EdemaResult(
      id: json['id'],
      userId: json['user_id'] ?? '',
      result: json['result'] ?? '',
      key: json['key'] ?? '',
      resultImageUrl: json['result_image_url'] ?? '',
      // createdDate: DateTime.parse(json['created_date'] ?? ''),
      // modifiedDate: json['modified_date'] != null
      //     ? DateTime.parse(json['modified_date'])
      //     : null,
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'result': result,
      'key': key,
      'result_image_url': resultImageUrl,
      // 'created_date': createdDate.toIso8601String(),
      // 'modified_date': modifiedDate?.toIso8601String(),
      'status': status,
    };
  }
}
