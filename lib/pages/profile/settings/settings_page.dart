import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/routes/routes.dart';
import 'package:ulearning_app/common/values/constants.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/application/bloc/application_bloc.dart';
import 'package:ulearning_app/pages/application/bloc/application_event.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_bloc.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_state.dart';
import 'package:ulearning_app/pages/profile/settings/widgets/settings_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void removeUserData() {
    context.read<ApplicationBloc>().add(
          const TriggerAppEvent(0),
        );
    Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.SIGN_IN, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBarForSettings(),
      body: SingleChildScrollView(
        child: BlocBuilder<SettingsBloc, SettingStates>(
          builder: (context, state) {
            return Container(
              child: Column(
                children: [
                  settingsButton(context, removeUserData),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
