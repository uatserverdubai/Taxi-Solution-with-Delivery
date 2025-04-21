// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../util/api-list.dart';
import '../../../../util/constant.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../data/api/server.dart';
import '../../../data/model/response/page_model.dart';
import '../../../data/model/response/profile_model.dart';
import '../../../data/repository/profile_repo.dart';
import '../../splash/controllers/splash_controller.dart';
import '../widget/image_size_checker.dart';

class ProfileController extends GetxController {
  SplashController splashController = Get.put(SplashController());
  ProfileData profileData = ProfileData();
  final box = GetStorage();
  bool loader = false;
  bool updateProfileLodear = false;
  bool changePasswordLodear = false;
  Server server = Server();
  String? imagePath;
  List<PageData> pageDataList = <PageData>[];
  File? file;
  final passwordVisible = true.obs;
  final newPasswordVisible = true.obs;
  final retypePasswordVisible = true.obs;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();
  @override
  void onInit() {
    if (box.read('isLogedIn') == true) {
      getProfileData();
    }
    getPageData();
    super.onInit();
  }

  getProfileData() async {
    loader = true;
    update();
    var responseData = await ProfileRepo.getProfile();
    if (responseData != null) {
      loader = false;

      update();
      profileData = responseData.data ?? ProfileData();
      update();
      firstNameController.text = profileData.firstName.toString();
      lastNameController.text = profileData.lastName.toString();
      emailController.text = profileData.email.toString();
      mobileController.text = profileData.phone.toString();
      update();
    }
  }

  getPageData() async {
    var pageData = await ProfileRepo.getPages();
    if (pageData.data!.isNotEmpty) {
      pageDataList = pageData.data!;
      update();
    }
  }

  updateUserProfile(context) async {
    updateProfileLodear = true;
    update();
    Map<String, String>? body = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'email': emailController.text,
      'phone': mobileController.text,
      'country_code': splashController.countryInfoData.callingCode!
    };
    String jsonBody = json.encode(body);

    await server
        .putRequest(
      endPoint: APIList.profile,
      body: jsonBody,
    )
        .then((response) async {
      if (response != null && response.statusCode == 200) {
        await getProfileData();
        updateProfileLodear = false;
        update();
        Get.back();
        customSnackbar("PROFILE_UPDATE".tr, 'PROFILE_UPDATE_SUCCESSFULLY'.tr,
            AppColor.success);
      } else {
        updateProfileLodear = false;
        update();
        final jsonResponse = json.decode(response.body);
        customSnackbar(
            "ERROR".tr, jsonResponse["message"].toString(), AppColor.error);
      }
    });
  }

  updateUserPassword() async {
    changePasswordLodear = true;
    update();
    Map<String, String>? body = {
      'old_password': oldPasswordController.text,
      'password': newPasswordController.text,
      'password_confirmation': retypePasswordController.text,
    };
    String jsonBody = json.encode(body);
    await server
        .putRequest(
      endPoint: APIList.changePassword,
      body: jsonBody,
    )
        .then((response) {
      if (response != null && response.statusCode == 200) {
        changePasswordLodear = false;
        getProfileData();
        update();
        oldPasswordController.clear();
        newPasswordController.clear();
        retypePasswordController.clear();
        Get.back();
        customSnackbar('CHANGE_PASSWORD'.tr, 'PASSWORD_UPDATE_SUCCESSFULLY'.tr,
            AppColor.success);
      } else if (response != null && response.statusCode == 422) {
        var message = jsonDecode(response.body);

        if (message['errors']['password'] != null) {
          customSnackbar('CHANGE_PASSWORD'.tr,
              message['errors']['password'][0].toString(), AppColor.error);
        }
        if (message['errors']['old_password'] != null) {
          customSnackbar('CHANGE_PASSWORD'.tr,
              message['errors']['old_password'][0].toString(), AppColor.error);
        }
        changePasswordLodear = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
      } else {
        changePasswordLodear = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
        customSnackbar('CHANGE_PASSWORD'.tr, 'PLEASE_ENTER_VALID_INPUT'.tr,
            AppColor.error);
      }
    });
  }

  Future getImageFromGallary() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    double imageSize = await ImageSize.getImageSize(image!);
    file = File(image.path);
    if (imageSize > 2) {
      customSnackbar(
          "ERROR".tr, "IMAGE_SHOULD_BE_LESS_THAN_2MB".tr, AppColor.error);
    } else {
      updateProfileImage(image.path);
    }
  }

  updateProfileImage(file) async {
    loader = true;
    update();
    await server
        .multipartRequest(APIList.changeProfileImage, file)
        .then((response) async {
      if (response != null) {
        loader = false;
        update();
        getProfileData();
        customSnackbar("SUCCESS".tr, "PROFILE_IMAGE_SAVED_SUCCESSFULLY".tr,
            AppColor.success);
        update();
      } else {
        loader = false;
        update();
        customSnackbar("ERROR".tr, "SOMETHING_WRONG".tr, AppColor.error);
      }
    });
  }
}
