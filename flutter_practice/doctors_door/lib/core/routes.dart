import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctors_door/features/dashboard/dashboard.dart';
import 'package:doctors_door/features/onboarding/onboarding_page.dart';
import 'package:doctors_door/features/doctor_list_page/doctor_page.dart';

class RoutePages{
  GoRouter router=GoRouter(
    routes: [
      GoRoute(path: '/doctorsList',
      pageBuilder:(context,state){
        return(MaterialPage(
          child:DoctorPage()
        ));
      } ),
      
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