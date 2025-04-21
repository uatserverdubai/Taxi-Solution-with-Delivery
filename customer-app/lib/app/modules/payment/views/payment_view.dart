// ignore_for_file: no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_unnecessary_containers, avoid_renaming_method_parameters, prefer_interpolation_to_compose_strings, unused_import
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking/app/data/model/response/order_details_model.dart';
import 'package:foodking/app/modules/checkout/widget/order_confirm_dialog_button.dart';
import 'package:foodking/app/modules/dashboard/views/dashboard_view.dart';
import 'package:foodking/app/modules/splash/controllers/splash_controller.dart';
import 'package:foodking/widget/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../util/api-list.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/custom_toast.dart';
import '../../order/controllers/order_controller.dart';
import 'payment_failed_view.dart';

class PaymentView extends StatefulWidget {
  final bool? fromHome;
  final int? orderId;
  final OrderDetailsData? order;
  const PaymentView({
    super.key,
    this.orderId,
    this.order,
    this.fromHome = true,
  });
  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String? selectedUrl;
  double value = 0.0;
  bool isLoading = true;
  PullToRefreshController pullToRefreshController = PullToRefreshController();
  MyInAppBrowser? browser;

  @override
  void initState() {
    super.initState();
    selectedUrl = APIList.paymentUrl! + widget.orderId.toString() + "/pay";
    _initData(widget.order, widget.fromHome);
  }

  void _initData(OrderDetailsData? order, bool? fromHome) async {
    browser = MyInAppBrowser(
      order: order,
      fromHome: fromHome,
      orderID: widget.orderId,
    );
    if (Platform.isAndroid) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(true);

      bool swAvailable = await WebViewFeature.isFeatureSupported(
        WebViewFeature.SERVICE_WORKER_BASIC_USAGE,
      );
      bool swInterceptAvailable = await WebViewFeature.isFeatureSupported(
        WebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST,
      );

      if (swAvailable && swInterceptAvailable) {
        ServiceWorkerController serviceWorkerController =
            ServiceWorkerController.instance();
        await serviceWorkerController.setServiceWorkerClient(
          ServiceWorkerClient(
            shouldInterceptRequest: (request) async {
              return null;
            },
          ),
        );
      }
    }

    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(color: AppColor.primaryColor),
      onRefresh: () async {
        if (Platform.isAndroid) {
          browser?.webViewController?.reload();
        } else if (Platform.isIOS) {
          browser?.webViewController?.loadUrl(
            urlRequest: URLRequest(
              url: await browser?.webViewController?.getUrl(),
            ),
          );
        }
      },
    );

    await browser?.openUrlRequest(
      urlRequest: URLRequest(url: WebUri(selectedUrl!)),
      settings: InAppBrowserClassSettings(
        browserSettings: InAppBrowserSettings(
          hideUrlBar: true,
          hideToolbarTop: true,
        ),
        webViewSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          useShouldOverrideUrlLoading: true,
          useOnLoadResource: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('DIGITAL_PAYMENT'.tr, style: fontBoldWithColorBlack),
      ),
      body: Center(
        child: Container(
          child: Stack(
            children: [
              isLoading
                  ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColor.primaryColor,
                      ),
                    ),
                  )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyInAppBrowser extends InAppBrowser {
  bool _canRedirect = true;
  OrderDetailsData? order;
  bool? fromHome;
  int? orderID;

  MyInAppBrowser({
    required this.order,
    required this.fromHome,
    required this.orderID,
  });

  @override
  Future onBrowserCreated() async {}

  @override
  Future onLoadStart(url) async {
    _pageRedirect(url.toString());
  }

  @override
  Future onLoadStop(url) async {
    pullToRefreshController?.endRefreshing();
    _pageRedirect(url.toString());
  }

  @override
  void onLoadError(url, code, message) {
    pullToRefreshController?.endRefreshing();
  }

  @override
  void onProgressChanged(progress) {
    if (progress == 100) {
      pullToRefreshController?.endRefreshing();
    }
  }

  @override
  void onExit() {
    if (_canRedirect) {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (_, dynamic) async => false,
            child: const AlertDialog(
              contentPadding: EdgeInsets.all(10),
              content: PaymentFailedView(),
            ),
          );
        },
      );
    }
  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
    navigationAction,
  ) async {
    return NavigationActionPolicy.ALLOW;
  }

  @override
  void onLoadResource(response) {}

  @override
  void onConsoleMessage(consoleMessage) {}

  void _pageRedirect(String url) async {
    Future.delayed(const Duration(seconds: 0), () {
      if (_canRedirect) {
        bool _isSuccess =
            url.contains('successful') && url.contains(APIList.baseUrl!);
        bool _isFailed = url.contains('fail') && url.contains(APIList.baseUrl!);
        bool _isCancel =
            url.contains('cancel') && url.contains(APIList.baseUrl!);
        bool _isBack = url.contains('home') && url.contains(APIList.baseUrl!);
        if (_isSuccess || _isFailed || _isCancel || _isBack) {
          _canRedirect = false;
          close();
        }
        if (_isSuccess) {
          _canRedirect = false;
          close();
          Get.find<OrderController>().getOrderDetails(order?.id ?? 0);

          if (fromHome == true) {
            Get.offAll(() => const DashboardView());
            PageController(initialPage: 0);
          } else {
            Get.back();
          }

          if (fromHome == true) {
            Get.dialog(
              barrierDismissible: false,
              Dialog(
                insetPadding: EdgeInsets.all(10.r),
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Stack(
                      children: [
                        Wrap(
                          children: [
                            Center(
                              child: Text(
                                "YOUR_PAYMENT_HAS_BEEN_CONFIRMED".tr,
                                style: fontMedium,
                              ),
                            ),
                            Center(
                              child: Lottie.asset(
                                Images.animationConfirmed,
                                height: 120.h,
                                width: 120.w,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(height: 20.h),
                            Center(
                              child: DialogButton(
                                color: AppColor.primaryColor,
                                onPressed: () async {
                                  await Get.find<OrderController>()
                                      .getOrderDetails(orderID!);
                                  Get.back();
                                },
                                radius: BorderRadius.circular(24.0.r),
                                child: FittedBox(
                                  child: Text(
                                    "GO_TO_ORDER_DETAILS".tr,
                                    style: fontMediumProWhite,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 0.h,
                          right: 0.w,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(
                              Images.IconClose,
                              height: 24.h,
                              width: 24.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            Get.find<OrderController>().getOrderDetails(orderID!);
          }

          customSnackbar(
            "DIGITAL_PAYMENT".tr,
            "YOUR_PAYMENT_HAS_BEEN_CONFIRMED".tr,
            AppColor.success,
          );
        } else if (_isFailed || _isCancel || _isBack) {
          Get.back();
          customSnackbar(
            "DIGITAL_PAYMENT".tr,
            "PAYMENT_FAILED".tr,
            AppColor.error,
          );
        }
      }
    });
  }
}
