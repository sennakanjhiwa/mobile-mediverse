class Doctor {
  final String id;
  final String userId;
  final String name;
  final String specialization;
  final ContactInfo? contactInfo; // Nullable
  final DateTime createdAt;
  final DateTime updatedAt;

  Doctor({
    required this.id,
    required this.userId,
    required this.name,
    required this.specialization,
    this.contactInfo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
      contactInfo: json['contact_info'] != null
          ? ContactInfo.fromJson(json['contact_info'])
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class ContactInfo {
  final String email;
  final String phone;

  ContactInfo({
    required this.email,
    required this.phone,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      email: json['email'] as String,
      phone: json['phone'] as String,
    );
  }
}
