import 'package:bloc/bloc.dart';
import 'package:ulearning_app/common/entities/course.dart';
import 'package:ulearning_app/pages/profile/payment_details/cubit/payment_details_state.dart';

class PaymentDetailsCubit extends Cubit<PaymentDetailsStates> {
  PaymentDetailsCubit() : super(const InitialPaymentDetailStates());

  void historyPaymentDetails(List<CourseItem> courseItem) {
    emit(HistoryPaymentDetailStates(courseItem));
  }

  void loadingHistoryPaymentDetails() {
    emit(const LoadingPaymentDetailStates());
  }

  void doneLoadingHistoryPaymentDetails() {
    emit(const DoneLoadingPaymentDetailStates());
  }
}
