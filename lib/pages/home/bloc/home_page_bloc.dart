import 'package:bloc/bloc.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_event.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvents, HomePageState> {
  HomePageBloc() : super(const HomePageState()) {
    on<HomePageDots>(_homePageDots);
  }
  void _homePageDots(HomePageDots event, Emitter<HomePageState> emit) {
    emit(state.copyWith(index: event.index));
  }
}
