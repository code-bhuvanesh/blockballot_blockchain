import 'package:blockballot/features/camera_page/camera_page.dart';
import 'package:blockballot/features/confirmation_page/confirmation_page.dart';
import 'package:blockballot/features/meta_mask_bloc/meta_mask_bloc.dart';
import 'package:blockballot/features/meta_mask_connect_page/meta_mask_connect_page.dart';
import 'package:blockballot/features/user_auth_page/user_auth_page.dart';
import 'package:blockballot/features/voters_page/voters_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'services/services.dart';

void main() {
  initServices();
  runApp(BlocProvider(
    create: (context) => MetaMaskBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Route pageTransition(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
    );
  }

  Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case MetaMaskConnectPage.routename:
        return pageTransition(const MetaMaskConnectPage());
      case UserAuthPage.routename:
        return pageTransition(const UserAuthPage());
      case VotersPage.routename:
        return pageTransition(const VotersPage());
      case CameraPage.routename:
        return pageTransition(const CameraPage());
      case VotersPage.routename:
        return pageTransition(const VotersPage());
      case ConfirmationPage.routename:
        return pageTransition(const ConfirmationPage());
    }
    return pageTransition(const MetaMaskConnectPage());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MetaMaskConnectPage(),
      onGenerateRoute: generateRoutes,
    );
  }
}
