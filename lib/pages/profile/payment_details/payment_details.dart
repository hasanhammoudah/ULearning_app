import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/pages/common_widgets.dart';
import 'package:ulearning_app/pages/profile/payment_details/cubit/payment_details_cubit.dart';
import 'package:ulearning_app/pages/profile/payment_details/cubit/payment_details_state.dart';
import 'package:ulearning_app/pages/profile/payment_details/payment_details_controller.dart';
import 'package:ulearning_app/pages/profile/payment_details/widgets/payment_details_widgets.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  late PaymentDetailsController _paymentDetailsController;
  @override
  void didChangeDependencies() {
    _paymentDetailsController = PaymentDetailsController(context: context);
    _paymentDetailsController.int();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentDetailsCubit, PaymentDetailsStates>(
      builder: (context, state) {
        if (state is HistoryPaymentDetailStates) {
          return Scaffold(
              appBar: buildAppBar("Payment details"),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.sp),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      menuView(),
                      buildOrderListItem(state),
                    ],
                  ),
                ),
              ));
        } else if (state is LoadingPaymentDetailStates) {
          return Scaffold(
              appBar: buildAppBar("Payment details"),
              body: const Center(
                child: CircularProgressIndicator(),
              ));
        } else {
          return Container();
        }
      },
    );
  }
}
