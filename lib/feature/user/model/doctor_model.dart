/// DoctorModel — maps the backend Doctor document.
///
/// Backend schema (Dental Clinic):
/// ```json
/// {
///   "_id": "...",
///   "name": "Dr. Ahmed Hassan",
///   "specialization": "Orthodontics",
///   "phone": "01012345678",
///   "email": "ahmed@clinic.com",
///   "avatarUrl": "https://...",
///   "rating": 4.8,
///   "workingHours": [
///     { "day": "Sunday", "from": "09:00", "to": "17:00" }
///   ],
///   "isAvailable": true,
///   "yearsOfExperience": 10,
///   "clinicAddress": "Cairo, Egypt"
/// }
/// ```
class DoctorModel {
  final String id;
  final String name;
  final String specialization;
  final String phone;
  final String email;
  final String avatarUrl;
  final double rating;
  final List<WorkingHour> workingHours;
  final bool isAvailable;
  final int yearsOfExperience;
  final String clinicAddress;

  const DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.phone,
    required this.email,
    required this.avatarUrl,
    required this.rating,
    required this.workingHours,
    required this.isAvailable,
    required this.yearsOfExperience,
    required this.clinicAddress,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        id: json['_id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        specialization: json['specialization'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        email: json['email'] as String? ?? '',
        avatarUrl: json['avatarUrl'] as String? ?? '',
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        workingHours: (json['workingHours'] as List<dynamic>? ?? [])
            .map((e) => WorkingHour.fromJson(e as Map<String, dynamic>))
            .toList(),
        isAvailable: json['isAvailable'] as bool? ?? false,
        yearsOfExperience: json['yearsOfExperience'] as int? ?? 0,
        clinicAddress: json['clinicAddress'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'specialization': specialization,
        'phone': phone,
        'email': email,
        'avatarUrl': avatarUrl,
        'rating': rating,
        'workingHours': workingHours.map((w) => w.toJson()).toList(),
        'isAvailable': isAvailable,
        'yearsOfExperience': yearsOfExperience,
        'clinicAddress': clinicAddress,
      };

  /// Returns a copy with optional field overrides.
  DoctorModel copyWith({
    String? id,
    String? name,
    String? specialization,
    String? phone,
    String? email,
    String? avatarUrl,
    double? rating,
    List<WorkingHour>? workingHours,
    bool? isAvailable,
    int? yearsOfExperience,
    String? clinicAddress,
  }) =>
      DoctorModel(
        id: id ?? this.id,
        name: name ?? this.name,
        specialization: specialization ?? this.specialization,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        rating: rating ?? this.rating,
        workingHours: workingHours ?? this.workingHours,
        isAvailable: isAvailable ?? this.isAvailable,
        yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
        clinicAddress: clinicAddress ?? this.clinicAddress,
      );
}

/// A single day-slot in a doctor's schedule.
class WorkingHour {
  final String day;
  final String from;
  final String to;

  const WorkingHour({
    required this.day,
    required this.from,
    required this.to,
  });

  factory WorkingHour.fromJson(Map<String, dynamic> json) => WorkingHour(
        day: json['day'] as String? ?? '',
        from: json['from'] as String? ?? '',
        to: json['to'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'day': day,
        'from': from,
        'to': to,
      };
}
