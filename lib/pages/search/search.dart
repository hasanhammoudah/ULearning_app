import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/pages/common_widgets.dart';
import 'package:ulearning_app/pages/search/bloc/search_bloc.dart';
import 'package:ulearning_app/pages/search/bloc/search_state.dart';
import 'package:ulearning_app/pages/search/search_controller.dart';
import 'package:ulearning_app/pages/search/widgets/search_widgets.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late MySearchController _mySearchController;
  @override
  void didChangeDependencies() {
    _mySearchController = MySearchController(context: context);
    _mySearchController.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Search"),
      body: BlocBuilder<SearchBloc, SearchStates>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                sliver: SliverToBoxAdapter(
                  child: searchView(context, 'courses you might like',
                      home: false),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                  vertical: 0,
                ),
                sliver: SliverToBoxAdapter(
                    child: SingleChildScrollView(
                  child: searchList(state),
                )),
              ),
            ],
          );
        },
      ),
    );
  }
}
