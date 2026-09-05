/// Maps to the `personal_info` jsonb column.
class PersonalInfo {
  final String gender;
  final String maritalStatus;
  final String? alternativePhoneNumber;

  const PersonalInfo({
    required this.gender,
    required this.maritalStatus,
    this.alternativePhoneNumber,
  });

  Map<String, dynamic> toJson() => {
        'gender': gender,
        'marital_status': maritalStatus,
        'alternative_phone_number': alternativePhoneNumber,
      };

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
        gender: json['gender'] as String? ?? '',
        maritalStatus: json['marital_status'] as String? ?? '',
        alternativePhoneNumber: json['alternative_phone_number'] as String?,
      );
}
