import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swagger/api.dart';

enum UserState {
  FirstTime,
  PhoneEntered,
  AadharVerified,
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

  Map<String, dynamic> toJson(instance) => <String, dynamic>{
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
  String toString() =>
      'ProfessionalDetails(occupationType: $occupationType, occupation: $occupation, monthlyIncome: $monthlyIncome)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfessionalDetails &&
        other.occupationType == occupationType &&
        other.occupation == occupation &&
        other.monthlyIncome == monthlyIncome;
  }

  @override
  int get hashCode =>
      occupationType.hashCode ^ occupation.hashCode ^ monthlyIncome.hashCode;
}

class FamilyDetails {
  String? fatherName;
  String? motherName;
  int? noOfKids;
  FamilyDetails({
    this.fatherName,
    this.motherName,
    this.noOfKids,
  });

  Map<String, dynamic> toMap() {
    return {
      'father_name': fatherName,
      'mother_name': motherName,
      'child_count': noOfKids,
    };
  }

  factory FamilyDetails.fromMap(Map<String, dynamic> map) {
    return FamilyDetails(
      fatherName: map['fatherName'],
      motherName: map['motherName'],
      noOfKids: map['noOfKids']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson(instance) => <String, dynamic>{
        'father_name': instance.fatherName,
        'mother_name': instance.motherName,
        'child_count': instance.noOfKids,
      };

  factory FamilyDetails.fromJson(json) => FamilyDetails(
        fatherName: json['father_name'] as String?,
        motherName: json['mother_name'] as String?,
        noOfKids: (json['child_count'] as num?)?.toInt(),
      );

  @override
  String toString() =>
      'FamilyDetails(fatherName: $fatherName, motherName: $motherName, noOfKids: $noOfKids)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FamilyDetails &&
        other.fatherName == fatherName &&
        other.motherName == motherName &&
        other.noOfKids == noOfKids;
  }

  @override
  int get hashCode =>
      fatherName.hashCode ^ motherName.hashCode ^ noOfKids.hashCode;
}

class Customer with ChangeNotifier {
  String? primaryPhoneNumber = "";
  String? userId = "";
  String? customerName = "";
  String? clientId = "";
  String? profileImage = "";
  String? martialStatus = "";
  FamilyInfo? familyDetails;
  String? email = "";
  CurrentAddress? currentAddress;
  Object? customerPreference;
  ProfessionalInfo? professionalInfo;
  NotificationPreference? notificationPreference;
  bool? isVerified = false;
  List<UserState> doneStates = [];
  String? aadharNo = "";
  DateTime? dateOfBirth;
  String? gender;
  UserState? userState = UserState.FirstTime;
  String? upiId;

  Customer({
    this.primaryPhoneNumber,
    this.upiId,
    this.userId,
    this.customerName,
    this.clientId,
    this.email,
    this.currentAddress,
    this.professionalInfo,
    this.customerPreference,
    this.isVerified,
    this.userState,
    this.dateOfBirth,
    this.gender,
    this.notificationPreference,
    this.profileImage,
    this.martialStatus,
    this.aadharNo,
    this.familyDetails,
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

  void setPersonalInfo(
      {String? nm,
      DateTime? dateTime,
      String? gen,
      // dynamic address,
      String? adh}) {
    aadharNo = adh;
    customerName = nm;
    gender = gen;
    dateOfBirth = dateTime;
    // currentAddress = address;

    notifyListeners();
  }

  void setCustomer(UserResponse user, UserState state) {
    print('Setting user in context: $user');
    primaryPhoneNumber = user.primaryPhoneNumber;
    customerName = user.customerName;
    clientId = user.clientId;
    userId = user.id;
    email = user.email;
    currentAddress = user.currentAddress;
    professionalInfo = user.professionalInfo;
    gender = user.gender;
    dateOfBirth = user.dob;
    customerPreference = user.customerPreference;
    notificationPreference = user.notificationPreference;
    isVerified = user.isVerified;
    userState = state;
    profileImage = user.profileImage;
    familyDetails = user.familyInfo;
    upiId = user.rzpVpa;
    notifyListeners();
  }

  void setProfilePhoto({required String imageLink}) {
    profileImage = imageLink;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'primaryPhoneNumber': primaryPhoneNumber,
      'userId': userId,
      'customerName': customerName,
      'clientId': clientId,
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
    return 'User(primaryPhoneNumber: $primaryPhoneNumber, userId: $userId, customerName: $customerName, clientId: $clientId, email: $email, currentAddress: $currentAddress, professionalInfo: $professionalInfo, customerPreference: $customerPreference, gender: $gender, dob: $dateOfBirth, isVerified: $isVerified, notificationPreference: $notificationPreference)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Customer &&
        other.primaryPhoneNumber == primaryPhoneNumber &&
        other.userId == userId &&
        other.customerName == customerName &&
        other.clientId == clientId &&
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
        email.hashCode ^
        currentAddress.hashCode ^
        professionalInfo.hashCode ^
        customerPreference.hashCode ^
        gender.hashCode ^
        dateOfBirth.hashCode ^
        isVerified.hashCode;
  }
}
