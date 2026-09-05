class DocumentsUrls {
  final String? personalPhoto;
  final String? idPassportPhoto;
  final String? bankStatement;
  final String? universityDegree;
  final String? syndicateCard;
  final String? employmentContract;
  final String? mediaLicense;

  const DocumentsUrls({
    this.personalPhoto,
    this.idPassportPhoto,
    this.bankStatement,
    this.universityDegree,
    this.syndicateCard,
    this.employmentContract,
    this.mediaLicense,
  });

  factory DocumentsUrls.fromUploadMap(Map<String, String?> urls) =>
      DocumentsUrls(
        personalPhoto: urls['personal_photos'],
        idPassportPhoto: urls['id_photos'],
        bankStatement: urls['bank_statements'],
        universityDegree: urls['degrees'],
        syndicateCard: urls['syndicate_cards'],
        employmentContract: urls['contracts'],
        mediaLicense: urls['licenses'],
      );

  Map<String, dynamic> toJson() => {
    'personal_photo_url': personalPhoto,
    'id_passport_photo_url': idPassportPhoto,
    'bank_statement_url': bankStatement,
    'university_degree_url': universityDegree,
    'syndicate_card_url': syndicateCard,
    'employment_contract_url': employmentContract,
    'media_license_url': mediaLicense,
  };

  factory DocumentsUrls.fromJson(Map<String, dynamic> json) => DocumentsUrls(
    personalPhoto: json['personal_photo_url'] as String?,
    idPassportPhoto: json['id_passport_photo_url'] as String?,
    bankStatement: json['bank_statement_url'] as String?,
    universityDegree: json['university_degree_url'] as String?,
    syndicateCard: json['syndicate_card_url'] as String?,
    employmentContract: json['employment_contract_url'] as String?,
    mediaLicense: json['media_license_url'] as String?,
  );

  DocumentsUrls mergeUploads(Map<String, String?> uploaded) => DocumentsUrls(
    personalPhoto: uploaded['personal_photos'] ?? personalPhoto,
    idPassportPhoto: uploaded['id_photos'] ?? idPassportPhoto,
    bankStatement: uploaded['bank_statements'] ?? bankStatement,
    universityDegree: uploaded['degrees'] ?? universityDegree,
    syndicateCard: uploaded['syndicate_cards'] ?? syndicateCard,
    employmentContract: uploaded['contracts'] ?? employmentContract,
    mediaLicense: uploaded['licenses'] ?? mediaLicense,
  );
}
