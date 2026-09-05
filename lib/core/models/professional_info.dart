/// Maps to the `professional_info` jsonb column.
class ProfessionalInfo {
  final String mediaOrganization;
  final int workStartYear;
  final String jobType;
  final String workSystem;
  final String organizationAddress;
  final String organizationPhone;
  final String? prevJobTitle;
  final String? prevJobOrganization;
  final String? prevJobStartDate;
  final String? prevJobEndDate;

  const ProfessionalInfo({
    required this.mediaOrganization,
    required this.workStartYear,
    required this.jobType,
    required this.workSystem,
    required this.organizationAddress,
    required this.organizationPhone,
    this.prevJobTitle,
    this.prevJobOrganization,
    this.prevJobStartDate,
    this.prevJobEndDate,
  });

  Map<String, dynamic> toJson() => {
        'media_organization': mediaOrganization,
        'work_start_year': workStartYear,
        'job_type': jobType,
        'work_system': workSystem,
        'organization_address': organizationAddress,
        'organization_phone': organizationPhone,
        'prev_job_title': prevJobTitle,
        'prev_job_organization': prevJobOrganization,
        'prev_job_start_date': prevJobStartDate,
        'prev_job_end_date': prevJobEndDate,
      };

  factory ProfessionalInfo.fromJson(Map<String, dynamic> json) =>
      ProfessionalInfo(
        mediaOrganization: json['media_organization'] as String? ?? '',
        workStartYear: json['work_start_year'] as int? ?? 0,
        jobType: json['job_type'] as String? ?? '',
        workSystem: json['work_system'] as String? ?? '',
        organizationAddress: json['organization_address'] as String? ?? '',
        organizationPhone: json['organization_phone'] as String? ?? '',
        prevJobTitle: json['prev_job_title'] as String?,
        prevJobOrganization: json['prev_job_organization'] as String?,
        prevJobStartDate: json['prev_job_start_date'] as String?,
        prevJobEndDate: json['prev_job_end_date'] as String?,
      );
}
