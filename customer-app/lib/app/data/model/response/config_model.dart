// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) =>
    ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  ConfigData? data;

  ConfigModel({
    this.data,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        data: json["data"] == null ? null : ConfigData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class ConfigData {
  final String? companyName;
  final String? companyEmail;
  final String? companyPhone;
  final String? companyAddress;
  final String? companyCountryCode;
  final int? siteDefaultBranch;
  final int? siteDefaultLanguage;
  final String? siteAndroidAppLink;
  final String? siteIosAppLink;
  final String? siteCopyright;
  final int? siteCurrencyPosition;
  final String? siteDigitAfterDecimalPoint;
  final String? siteDefaultCurrencySymbol;
  final int? sitePhoneVerification;
  final int? siteLanguageSwitch;
  final int? siteOnlinePaymentGateway;
  final int? siteGuestLogin;
  final String? themeLogo;
  final String? themeFooterLogo;
  final String? themeFaviconLogo;
  final String? otpType;
  final String? otpDigitLimit;
  final String? otpExpireTime;
  final String? socialMediaFacebook;
  final String? socialMediaInstagram;
  final String? socialMediaTwitter;
  final String? socialMediaYoutube;
  final String? orderSetupFoodPreparationTime;
  final int? orderSetupTakeaway;
  final int? orderSetupDelivery;
  final String? orderSetupFreeDeliveryKilometer;
  final String? orderSetupBasicDeliveryCharge;
  final String? orderSetupChargePerKilo;
  final int? cookiesDetailsPageId;
  final String? cookiesSummary;
  final String? notificationFcmApiKey;
  final String? notificationFcmAuthDomain;
  final String? notificationFcmProjectId;
  final String? notificationFcmStorageBucket;
  final String? notificationFcmMessagingSenderId;
  final String? notificationFcmAppId;
  final String? notificationFcmPublicVapidKey;
  final String? notificationFcmMeasurementId;
  final String? notificationAudio;
  final String? imageCart;
  final String? imageConfirm;
  final String? imageVag;
  final String? imageNonVag;
  final String? imageAppStore;
  final String? imagePlayStore;
  final String? imageOrderTrack;
  final String? imageOrderPlaced;
  final String? imageOrderComplete;
  final String? imageOrderDelivered;
  final String? imageOrderPreparing;
  final String? imageOrderOutForDelivery;
  final String? imageOrderRejected;
  final String? imageOrderCanceled;
  final String? imageOrderReturned;
  final String? imageFourZeroFourPage;
  final String? imageFourZeroThreePage;
  ConfigData({
    this.companyName,
    this.companyEmail,
    this.companyPhone,
    this.companyAddress,
    this.companyCountryCode,
    this.siteDefaultBranch,
    this.siteDefaultLanguage,
    this.siteAndroidAppLink,
    this.siteIosAppLink,
    this.siteCopyright,
    this.siteCurrencyPosition,
    this.siteDigitAfterDecimalPoint,
    this.siteDefaultCurrencySymbol,
    this.sitePhoneVerification,
    this.siteLanguageSwitch,
    this.siteOnlinePaymentGateway,
    this.siteGuestLogin,
    this.themeLogo,
    this.themeFooterLogo,
    this.themeFaviconLogo,
    this.otpType,
    this.otpDigitLimit,
    this.otpExpireTime,
    this.socialMediaFacebook,
    this.socialMediaInstagram,
    this.socialMediaTwitter,
    this.socialMediaYoutube,
    this.orderSetupFoodPreparationTime,
    this.orderSetupTakeaway,
    this.orderSetupDelivery,
    this.orderSetupFreeDeliveryKilometer,
    this.orderSetupBasicDeliveryCharge,
    this.orderSetupChargePerKilo,
    this.cookiesDetailsPageId,
    this.cookiesSummary,
    this.notificationFcmApiKey,
    this.notificationFcmAuthDomain,
    this.notificationFcmProjectId,
    this.notificationFcmStorageBucket,
    this.notificationFcmMessagingSenderId,
    this.notificationFcmAppId,
    this.notificationFcmPublicVapidKey,
    this.notificationFcmMeasurementId,
    this.notificationAudio,
    this.imageCart,
    this.imageConfirm,
    this.imageVag,
    this.imageNonVag,
    this.imageAppStore,
    this.imagePlayStore,
    this.imageOrderTrack,
    this.imageOrderPlaced,
    this.imageOrderComplete,
    this.imageOrderDelivered,
    this.imageOrderPreparing,
    this.imageOrderOutForDelivery,
    this.imageOrderRejected,
    this.imageOrderCanceled,
    this.imageOrderReturned,
    this.imageFourZeroFourPage,
    this.imageFourZeroThreePage,
  });

  factory ConfigData.fromJson(Map<String, dynamic> json) => ConfigData(
        companyName: json["company_name"],
        companyEmail: json["company_email"],
        companyPhone: json["company_phone"],
        companyAddress: json["company_address"],
        companyCountryCode: json["company_country_code"],
        siteDefaultBranch: json["site_default_branch"],
        siteDefaultLanguage: json["site_default_language"],
        siteAndroidAppLink: json["site_android_app_link"],
        siteIosAppLink: json["site_ios_app_link"],
        siteCopyright: json["site_copyright"],
        siteCurrencyPosition: json["site_currency_position"],
        siteDigitAfterDecimalPoint: json["site_digit_after_decimal_point"],
        siteDefaultCurrencySymbol: json["site_default_currency_symbol"],
        sitePhoneVerification: json["site_phone_verification"],
        siteLanguageSwitch: json["site_language_switch"],
        siteOnlinePaymentGateway: json["site_online_payment_gateway"],
        siteGuestLogin: json["site_guest_login"],
        themeLogo: json["theme_logo"],
        themeFooterLogo: json["theme_footer_logo"],
        themeFaviconLogo: json["theme_favicon_logo"],
        otpType: json["otp_type"],
        otpDigitLimit: json["otp_digit_limit"],
        otpExpireTime: json["otp_expire_time"],
        socialMediaFacebook: json["social_media_facebook"],
        socialMediaInstagram: json["social_media_instagram"],
        socialMediaTwitter: json["social_media_twitter"],
        socialMediaYoutube: json["social_media_youtube"],
        orderSetupFoodPreparationTime:
            json["order_setup_food_preparation_time"],
        orderSetupTakeaway: json["order_setup_takeaway"],
        orderSetupDelivery: json["order_setup_delivery"],
        orderSetupFreeDeliveryKilometer:
            json["order_setup_free_delivery_kilometer"],
        orderSetupBasicDeliveryCharge:
            json["order_setup_basic_delivery_charge"],
        orderSetupChargePerKilo: json["order_setup_charge_per_kilo"],
        cookiesDetailsPageId: json["cookies_details_page_id"],
        cookiesSummary: json["cookies_summary"],
        notificationFcmApiKey: json["notification_fcm_api_key"],
        notificationFcmAuthDomain: json["notification_fcm_auth_domain"],
        notificationFcmProjectId: json["notification_fcm_project_id"],
        notificationFcmStorageBucket: json["notification_fcm_storage_bucket"],
        notificationFcmMessagingSenderId:
            json["notification_fcm_messaging_sender_id"],
        notificationFcmAppId: json["notification_fcm_app_id"],
        notificationFcmPublicVapidKey:
            json["notification_fcm_public_vapid_key"],
        notificationFcmMeasurementId: json["notification_fcm_measurement_id"],
        notificationAudio: json["notification_audio"],
        imageCart: json["image_cart"],
        imageConfirm: json["image_confirm"],
        imageVag: json["image_vag"],
        imageNonVag: json["image_non_vag"],
        imageAppStore: json["image_app_store"],
        imagePlayStore: json["image_play_store"],
        imageOrderTrack: json["image_order_track"],
        imageOrderPlaced: json["image_order_placed"],
        imageOrderComplete: json["image_order_complete"],
        imageOrderDelivered: json["image_order_delivered"],
        imageOrderPreparing: json["image_order_preparing"],
        imageOrderOutForDelivery: json["image_order_out_for_delivery"],
        imageOrderRejected: json["image_order_rejected"],
        imageOrderCanceled: json["image_order_canceled"],
        imageOrderReturned: json["image_order_returned"],
        imageFourZeroFourPage: json["image_four_zero_four_page"],
        imageFourZeroThreePage: json["image_four_zero_three_page"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "company_email": companyEmail,
        "company_phone": companyPhone,
        "company_country_code": companyCountryCode,
        "site_default_branch": siteDefaultBranch,
        "site_default_language": siteDefaultLanguage,
        "site_currency_position": siteCurrencyPosition,
        "site_digit_after_decimal_point": siteDigitAfterDecimalPoint,
        "site_default_currency_symbol": siteDefaultCurrencySymbol,
        "site_phone_verification": sitePhoneVerification,
        "otp_type": otpType,
        "otp_digit_limit": otpDigitLimit,
        "otp_expire_time": otpExpireTime,
        "order_setup_food_preparation_time": orderSetupFoodPreparationTime,
        "order_setup_takeaway": orderSetupTakeaway,
        "order_setup_delivery": orderSetupDelivery,
        "order_setup_free_delivery_kilometer": orderSetupFreeDeliveryKilometer,
        "order_setup_basic_delivery_charge": orderSetupBasicDeliveryCharge,
        "order_setup_charge_per_kilo": orderSetupChargePerKilo,
        "site_online_payment_gateway": siteOnlinePaymentGateway,
      };
}
