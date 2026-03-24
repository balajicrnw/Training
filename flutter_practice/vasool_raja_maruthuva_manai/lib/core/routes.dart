import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vasool_raja_maruthuva_manai/features/dashboard/dashboard.dart';
import 'package:vasool_raja_maruthuva_manai/features/onboarding/onboarding_page.dart';

class RoutePages{
  GoRouter router=GoRouter(
    routes: [
      GoRoute(path: '/dashboard',
      pageBuilder:(context,state){
        return(MaterialPage(
          child:DashboardPage()
        ));
      } ),
      GoRoute(path: '/',
      pageBuilder:(context,state){
        return(MaterialPage(
          child:OnboardingPage()
        ));
      } )
    ]
  );
}