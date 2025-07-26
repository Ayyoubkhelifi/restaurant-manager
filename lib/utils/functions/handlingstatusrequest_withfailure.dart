import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant/utils/constants/app_assets.dart';
import 'package:restaurant/utils/constants/status_request.dart';

class HandlingstatusrequestWithfailure extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingstatusrequestWithfailure({
    super.key,
    required this.statusRequest,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return switch (statusRequest) {
      StatusRequest.loading => Center(child: Lottie.asset(AppAssets.loading)),
      StatusRequest.failure => Center(child: Lottie.asset(AppAssets.noData)),
      StatusRequest.serverfailure || StatusRequest.serverexception => Center(
        child: Lottie.asset(AppAssets.serverFailure),
      ),
      StatusRequest.offlinefailure => Center(
        child: Lottie.asset(AppAssets.offlineFailure),
      ),
      StatusRequest.success || StatusRequest.none => Center(child: widget),
    };
  }
}
