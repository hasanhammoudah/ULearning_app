import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/widgets/text_field.dart';
import 'package:ulearning_app/pages/common_widgets.dart';
import 'package:ulearning_app/pages/messages/chat/bloc/chat_bloc.dart';
import 'package:ulearning_app/pages/messages/chat/bloc/chat_event.dart';
import 'package:ulearning_app/pages/messages/chat/bloc/chat_state.dart';
import 'package:ulearning_app/pages/messages/chat/chat_controller.dart';
import 'package:ulearning_app/pages/messages/chat/widgets/chat_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatController _chatController;

  @override
  void didChangeDependencies() {
    _chatController = ChatController(context: context);
 
      _chatController.init();
   
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar("Chat"),
        body: BlocBuilder<ChatBloc, ChatStates>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 70.h,
                    ),
                    child: CustomScrollView(
                      controller: _chatController.appScrollController,
                      reverse: true,
                      shrinkWrap: true,
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25.w,
                          ),
                          sliver: SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              return chatWidget(state.msgcontentList[index]);
                            }, childCount: state.msgcontentList.length),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.h,
                  child: Container(
                    color: AppColors.primaryBackground,
                    width: 360.w,
                    constraints: BoxConstraints(
                      maxHeight: 170.h,
                      minHeight: 70.w,
                    ),
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      bottom: 0.h,
                      top: 10.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 270.w,
                          constraints: BoxConstraints(
                            maxHeight: 170.h,
                            minHeight: 70.w,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.primaryBackground,
                              border: Border.all(
                                color: AppColors.primaryFourthElementText,
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: 150.h,
                                  minHeight: 30.w,
                                ),
                                padding: EdgeInsets.only(left: 5.w),
                                width: 220.w,
                                child: appTextField(
                                    'Message...',
                                    "none",
                                    maxLines: null,
                                    controller:
                                        _chatController.textEditingController,
                                    (value) {}),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.read<ChatBloc>().add(
                                      TriggerMoreStatus(
                                          state.more_status ? false : true));
                                },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  width: 40.w,
                                  height: 40.h,
                                  child: Image.asset("assets/icons/05.png"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _chatController.sendMessage();
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: AppColors.primaryElement,
                                borderRadius: BorderRadius.circular(
                                  40.w,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(1, 1),
                                  ),
                                ]),
                            child: Image.asset(
                              "assets/icons/send2.png",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                state.more_status
                    ? Positioned(
                        right: 82.w,
                        bottom: 70.h,
                        height: 100.h,
                        width: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            chatFileButtons("assets/icons/file.png"),
                            chatFileButtons("assets/icons/photo.png"),
                          ],
                        ),
                      )
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}
