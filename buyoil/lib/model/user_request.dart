class UserRequest {
  final String phoneNumber;
  final String rfidNumber;
  final String countryDialCode;
  final String machineID;

  UserRequest({
    required this.phoneNumber,
    required this.rfidNumber,
    required this.countryDialCode,
    required this.machineID,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'rfidNumber': rfidNumber,
      'countryDialCode': countryDialCode,
      'machineID': machineID,
    };
  }
}
