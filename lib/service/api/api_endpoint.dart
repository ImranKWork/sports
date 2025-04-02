const String apiVersion = "/v2/";

abstract class Apis {
  static const String signUp = "signup";
  static const String countries = "countries";
  static const String state = "state";
  static const String speciality = "speciality";
  static const String register_doctor = "register";
  static const String patients_register = "patients-register";
  static const String doctor_login = "login";
  static const String forget_password = "forget-password";
  static const String userDetails = "user";
  static const String updateProfile = "update-profile";
  static const String doctorHome = "doctor/home";
  static const String isAvailable = "doctor/availability";
  static const String allRequest = "doctor/all-request";
  static const String allTodayAppointment = "doctor/all-todayappointment";
  static const String allNextAppointment = "doctor/all-nextappointment";
  static const String patientRequest = "doctor/patient-request";
  static const String patientProfile = "doctor/patient-profile";
  static const String patientBlock = "doctor/patient-block";
  static const String prescription = "doctor/prescription";
  static const String schedule = "doctor/schedule";
  static const String addBankAccount = "update-payment-setup";
  static const String agoraToken = "generate-agora-details";
  static const String logout = "logout";
}