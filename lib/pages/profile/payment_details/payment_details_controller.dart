import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/apis/course_api.dart';
import 'package:ulearning_app/pages/profile/buy_courses/bloc/buy_courses_bloc.dart';
import 'package:ulearning_app/pages/profile/buy_courses/bloc/buy_courses_event.dart';
import 'package:ulearning_app/pages/profile/payment_details/cubit/payment_details_cubit.dart';

class PaymentDetailsController {
  late BuildContext context;
  PaymentDetailsController({required this.context});

  void int() {
    asyncLoadPaymentDetailsData();
  }

  asyncLoadPaymentDetailsData() async {
    context.read<PaymentDetailsCubit>().loadingHistoryPaymentDetails();
    var result = await CourseAPI.orderList();
    if (result.code == 200) {
      if (context.mounted) {
        context.read<PaymentDetailsCubit>().doneLoadingHistoryPaymentDetails();

        Future.delayed(const Duration(milliseconds: 10), () {
          context.read<PaymentDetailsCubit>().historyPaymentDetails(result.data!);
        });
      }
    }
  }
}
