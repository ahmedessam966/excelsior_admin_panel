class StaffModel {
  final String staffID;
  final String name;
  final String email;
  final String department;
  final String phone;
  final String gender;
  final String dob;
  final String position;
  final num salary;
  final String pidNumber;
  final int privilegeLevel;
  final String? profileImage;

  StaffModel(
      {required this.staffID,
      required this.name,
      required this.email,
      required this.department,
      required this.phone,
      required this.gender,
      required this.dob,
      required this.position,
      required this.salary,
      required this.pidNumber,
      required this.privilegeLevel,
      this.profileImage});
}
