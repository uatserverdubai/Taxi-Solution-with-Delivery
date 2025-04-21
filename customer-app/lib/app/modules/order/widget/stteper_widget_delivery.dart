// ignore_for_file: library_private_types_in_public_api

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../controllers/order_controller.dart';

class StepperWidgetDelivery extends StatefulWidget {
  const StepperWidgetDelivery({super.key});

  @override
  _Stepper createState() => _Stepper();
}

class _Stepper extends State<StepperWidgetDelivery> {
  final orderController = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          EasyStepper(
            activeStep: orderController.activeStep.value,
            lineStyle: LineStyle(
              lineLength: 50,
              lineSpace: 0,
              lineType: LineType.normal,
              defaultLineColor: Colors.grey,
              finishedLineColor: AppColor.primaryColor,
              lineThickness: 2,
            ),
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 20, vertical: 20),
            activeStepTextColor: AppColor.primaryColor,
            finishedStepTextColor: Colors.black87,
            finishedStepBackgroundColor: Colors.white,
            internalPadding: 0,
            showLoadingAnimation: false,
            stepRadius: 8,
            showStepBorder: false,
            steps: [
              EasyStep(
                enabled: false,
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: orderController.orderDetailsData.value.status! >= 1
                      ? SvgPicture.asset(Images.tick)
                      : SvgPicture.asset(Images.roundStepper),
                ),
                customTitle: Text("ORDER_PLACED".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color:
                            orderController.orderDetailsData.value.status! == 1
                                ? AppColor.primaryColor
                                : AppColor.fontColor)),
              ),
              EasyStep(
                enabled: false,
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: orderController.orderDetailsData.value.status! >= 4
                      ? SvgPicture.asset(Images.tick)
                      : SvgPicture.asset(Images.roundStepper),
                ),
                customTitle: Text("ORDER_ACCEPTED".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color:
                            orderController.orderDetailsData.value.status! == 4
                                ? AppColor.primaryColor
                                : AppColor.fontColor)),
              ),
              EasyStep(
                enabled: false,
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: orderController.orderDetailsData.value.status! >= 7
                      ? SvgPicture.asset(Images.tick)
                      : SvgPicture.asset(Images.roundStepper),
                ),
                customTitle: Text(
                  "PREPARING".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: orderController.orderDetailsData.value.status! == 7
                          ? AppColor.primaryColor
                          : AppColor.fontColor),
                ),
              ),
              EasyStep(
                enabled: false,
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: orderController.orderDetailsData.value.status! >= 8
                      ? SvgPicture.asset(Images.tick)
                      : SvgPicture.asset(Images.roundStepper),
                ),
                customTitle: Text(
                  "PREPARED".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: orderController.orderDetailsData.value.status! == 8
                          ? AppColor.primaryColor
                          : AppColor.fontColor),
                ),
              ),
              EasyStep(
                enabled: false,
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: orderController.orderDetailsData.value.status! >= 10
                      ? SvgPicture.asset(Images.tick)
                      : SvgPicture.asset(Images.roundStepper),
                ),
                customTitle: Text(
                  "ON_THE_WAY".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color:
                          orderController.orderDetailsData.value.status! == 10
                              ? AppColor.primaryColor
                              : AppColor.fontColor),
                ),
              ),
              EasyStep(
                enabled: false,
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: orderController.orderDetailsData.value.status! >= 13
                      ? SvgPicture.asset(Images.tick)
                      : SvgPicture.asset(Images.roundStepper),
                ),
                customTitle: Text(
                  "DELIVERED".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color:
                          orderController.orderDetailsData.value.status! == 13
                              ? AppColor.primaryColor
                              : AppColor.fontColor),
                ),
              ),
            ],
            onStepReached: (index) => setState(
                () => orderController.orderDetailsData.value.status = index),
          ),
        ],
      );
    });
  }
}
