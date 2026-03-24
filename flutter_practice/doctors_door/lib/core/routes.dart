import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctors_door/features/dashboard/dashboard.dart';
import 'package:doctors_door/features/onboarding/onboarding_page.dart';
import 'package:doctors_door/features/doctor_list_page/doctor_page.dart';
import 'package:doctors_door/features/hospital_list_page/hospitals_page.dart';
import 'package:doctors_door/features/hospital_list_page/hospital_details_page.dart';
import 'package:doctors_door/features/appointments/appointments_page.dart';
import 'package:doctors_door/features/appointments/book_appointment_page.dart';
import 'package:doctors_door/shared/hospital_model.dart';
import 'package:doctors_door/features/pharmacy/pharmacy_page.dart';
import 'package:doctors_door/features/pharmacy/cart_page.dart';

class RoutePages{
  GoRouter router=GoRouter(
    routes: [
      GoRoute(path: '/doctorsList',
      pageBuilder:(context,state){
        return(MaterialPage(
          child:DoctorPage()
        ));
      } ),
      GoRoute(path: '/hospitalsList',
      pageBuilder:(context,state){
        return(MaterialPage(
          child:const HospitalsPage()
        ));
      } ),
      GoRoute(path: '/hospitalDetails',
      pageBuilder:(context,state){
        final hospital = state.extra as HospitalModel;
        return(MaterialPage(
          child:HospitalDetailsPage(hospital: hospital)
        ));
      } ),
      
      GoRoute(path: '/appointments',
      pageBuilder:(context,state){
        return(MaterialPage(
          child:const AppointmentsPage()
        ));
      } ),
      GoRoute(path: '/bookAppointment',
      pageBuilder:(context,state){
        return(MaterialPage(
          child:const BookAppointmentPage()
        ));
      } ),
      GoRoute(path: '/pharmacy',
      pageBuilder:(context,state){
        return(MaterialPage(
          child:const PharmacyPage()
        ));
      } ),
      GoRoute(path: '/cart',
      pageBuilder:(context,state){
        return(MaterialPage(
          child:const CartPage()
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