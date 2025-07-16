class ChangePasswordModel {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordModel(
      {required this.currentPassword,
      required this.newPassword,
      required this.confirmPassword});

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
        currentPassword: json['currentPassword'],
        newPassword: json['newPassword'],
        confirmPassword: json['confirmPassword']);
  }

  Map<String, dynamic> toJson() => {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      };
}
