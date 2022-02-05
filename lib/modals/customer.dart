import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum UserState{

  FirstTime,
  PhoneEntered,
  OTPVerified,
  PermissionGiven,
  CardActivated,
  LoggedIn
}

class ProfessionalDetails {
  String? occupationType;
  String? occupation;
  double? monthlyIncome;
  ProfessionalDetails({
    this.occupationType,
    this.occupation,
    this.monthlyIncome,
  });

  Map<String, dynamic> toMap() {
    return {
      'occupationType': occupationType,
      'occupation': occupation,
      'monthlyIncome': monthlyIncome,
    };
  }

  factory ProfessionalDetails.fromMap(Map<String, dynamic> map) {
    return ProfessionalDetails(
      occupationType: map['occupationType'],
      occupation: map['occupation'],
      monthlyIncome: map['monthlyIncome']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson(instance) =>  <String, dynamic>{
      'occupation_type': instance.occupationType,
      'occupation': instance.occupation,
      'monthly_income': instance.monthlyIncome,
    };

  factory ProfessionalDetails.fromJson(json) => ProfessionalDetails(
      occupationType: json['occupation_type'] as String?,
      occupation: json['occupation'] as String?,
      monthlyIncome: (json['monthly_income'] as num?)?.toDouble(),
    );

  @override
  String toString() => 'ProfessionalDetails(occupationType: $occupationType, occupation: $occupation, monthlyIncome: $monthlyIncome)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProfessionalDetails &&
      other.occupationType == occupationType &&
      other.occupation == occupation &&
      other.monthlyIncome == monthlyIncome;
  }

  @override
  int get hashCode => occupationType.hashCode ^ occupation.hashCode ^ monthlyIncome.hashCode;
}

class Customer with ChangeNotifier {
 String? primaryPhoneNumber = ""	;
 String? userId = "";
 String? customerName = "";
 String? clientId = "";
 String? clientCustomerId = "";
 String? email = "";
 String? currentAddress = "";
 Object? customerPreference;
 ProfessionalDetails? professionalInfo;
 Object? notificationPreference;
 bool? isVerified = false;
 List<UserState> doneStates = [];
 String? aadharNo = "";
 DateTime? dateOfBirth;
 String? gender;
 UserState? userState = UserState.FirstTime;

  Customer({
    this.primaryPhoneNumber,
    this.userId,
    this.customerName,
    this.clientId,
    this.clientCustomerId,
    this.email,
    this.currentAddress,
    this.professionalInfo,
    this.customerPreference,
    this.isVerified,
    this.userState,
    this.dateOfBirth,
    this.gender,
    this.notificationPreference,
  });

  void setPhone(String phone) {
    primaryPhoneNumber = phone;
    notifyListeners();
  }

  bool isPermissionGiven() {
    return doneStates.contains(UserState.PermissionGiven);
  }

  void setUserState(UserState s) {
    doneStates.add(s);
    userState = s;
    notifyListeners();
  }

  void setVerification(bool veri) {
    isVerified = veri;
    notifyListeners();
  }

 void setPersonalInfo({String? nm, DateTime? dateTime, String? gen, dynamic address, String? adh}){
    aadharNo = adh;
    customerName = nm;
    gender = gen;
    dateOfBirth = dateTime;
    currentAddress = address;

    notifyListeners();
 } 

  void setCustomer(json, UserState s) {
    primaryPhoneNumber = json['primary_phone_number'];
    customerName = json['customer_name'];
    clientId = json['client_id'];
    userId = json['_id'];
    clientCustomerId = json['id'];
    email = json['email'];
    currentAddress = json['current_address'];
    professionalInfo = json['professional_info'] == null
          ? null
          : ProfessionalDetails.fromJson(
              json['professional_info'] as Map<String, dynamic>);
    gender = json['gender'];
    dateOfBirth = json['dob'] == null ? null : DateTime.parse(json['dob'] as String);
    customerPreference = json['customer_preference'];
    notificationPreference = json['notification_preference'];          
    isVerified = json['is_verified'];
    userState = s;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'primaryPhoneNumber': primaryPhoneNumber,
      'userId': userId,
      'customerName': customerName,
      'clientId': clientId,
      'clientCustomerId': clientCustomerId,
      'email': email,
      'currentAddress': currentAddress,
      'professionalDetails': professionalInfo,
      'isVerified': isVerified,
      'customerPreferences': customerPreference,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'User(primaryPhoneNumber: $primaryPhoneNumber, userId: $userId, customerName: $customerName, clientId: $clientId, clientCustomerId: $clientCustomerId, email: $email, currentAddress: $currentAddress, professionalInfo: $professionalInfo, customerPreference: $customerPreference, gender: $gender, dob: $dateOfBirth, isVerified: $isVerified, notificationPreference: $notificationPreference)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Customer &&
      other.primaryPhoneNumber == primaryPhoneNumber &&
      other.userId == userId &&
      other.customerName == customerName &&
      other.clientId == clientId &&
      other.clientCustomerId == clientCustomerId &&
      other.email == email &&
      other.currentAddress == currentAddress &&
      other.professionalInfo == professionalInfo &&
      other.customerPreference == customerPreference &&
      other.dateOfBirth == dateOfBirth &&
      other.gender == gender &&
      other.isVerified == isVerified;

  }

  @override
  int get hashCode {
    return primaryPhoneNumber.hashCode ^
      userId.hashCode ^
      customerName.hashCode ^
      clientId.hashCode ^
      clientCustomerId.hashCode ^
      email.hashCode ^
      currentAddress.hashCode ^
      professionalInfo.hashCode ^
      customerPreference.hashCode ^
      gender.hashCode ^
      dateOfBirth.hashCode ^
      isVerified.hashCode;

  }
}
