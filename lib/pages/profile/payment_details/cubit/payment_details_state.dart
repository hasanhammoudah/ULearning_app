import 'package:ulearning_app/common/entities/course.dart';

abstract class PaymentDetailsStates {
  const PaymentDetailsStates();
}

class InitialPaymentDetailStates extends PaymentDetailsStates {
  const InitialPaymentDetailStates();
}

class LoadingPaymentDetailStates extends PaymentDetailsStates {
  const LoadingPaymentDetailStates();
}

class DoneLoadingPaymentDetailStates extends PaymentDetailsStates {
  const DoneLoadingPaymentDetailStates();
}

class HistoryPaymentDetailStates extends PaymentDetailsStates {
  const HistoryPaymentDetailStates(this.courseItem);
  final List<CourseItem> courseItem;
}
