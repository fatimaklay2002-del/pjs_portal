class AddressEduInfo {
  final String originalCity;
  final String originalGovernorate;
  final String fullAddress;
  final String? spouseCity;
  final String? spouseGovernorate;
  final String? spouseAddress;
  final String universityName;
  final String major;
  final String qualification;
  final int graduationYear;

  const AddressEduInfo({
    required this.originalCity,
    required this.originalGovernorate,
    required this.fullAddress,
    this.spouseCity,
    this.spouseGovernorate,
    this.spouseAddress,
    required this.universityName,
    required this.major,
    required this.qualification,
    required this.graduationYear,
  });

  Map<String, dynamic> toJson() => {
        'original_city': originalCity,
        'original_governorate': originalGovernorate,
        'full_address': fullAddress,
        'spouse_city': spouseCity,
        'spouse_governorate': spouseGovernorate,
        'spouse_address': spouseAddress,
        'university_name': universityName,
        'major': major,
        'qualification': qualification,
        'graduation_year': graduationYear,
      };

  factory AddressEduInfo.fromJson(Map<String, dynamic> json) => AddressEduInfo(
        originalCity: json['original_city'] as String? ?? '',
        originalGovernorate: json['original_governorate'] as String? ?? '',
        fullAddress: json['full_address'] as String? ?? '',
        spouseCity: json['spouse_city'] as String?,
        spouseGovernorate: json['spouse_governorate'] as String?,
        spouseAddress: json['spouse_address'] as String?,
        universityName: json['university_name'] as String? ?? '',
        major: json['major'] as String? ?? '',
        qualification: json['qualification'] as String? ?? '',
        graduationYear: json['graduation_year'] as int? ?? 0,
      );
}
