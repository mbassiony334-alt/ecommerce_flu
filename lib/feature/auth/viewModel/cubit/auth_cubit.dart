import 'package:bloc/bloc.dart';
import 'package:e_commarcae/core/error/serve_eror.dart';
import 'package:e_commarcae/core/services/api/api_Concumer.dart';
import 'package:e_commarcae/core/services/api/endpoit.dart';
import 'package:e_commarcae/core/services/cash/cash_Healper.dart';
import 'package:e_commarcae/feature/auth/model/resgeter.dart';
import 'package:e_commarcae/feature/auth/model/signModel.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.api}) : super(AuthInitial());
  final ApiConsumer api;

  Future<void> signIn(String email, String pass) async {
    emit(AuthLoading());
    try {
      var response = await api.post(
        Endpoint.signIn,
        data: {ApiKey.email: email, ApiKey.password: pass},
      );
      print(response);
      SignModel signModel = SignModel.fromJson(response);
      CacheHelper.saveData(key: ApiKey.token, value: signModel.token);
      CacheHelper.saveData(key: "userInfo", value: signModel.user);
      emit(AuthSucces());
    } on ServeEror catch (e) {
      emit(AuthFailure(errormessage: e.erorrModel.errorMessage));
    }
  }

  Future<void> signUp(RegetierModel reg) async {
    emit(AuthLoading());
    try {
      var response = await api.post(
        Endpoint.signUp,
        data: {
          ApiKey.email: reg.email,
          ApiKey.password: reg.password,
          ApiKey.confirmPassword: reg.password,
          ApiKey.name: reg.name,
          ApiKey.phone: reg.phone,
        },
      );
      print(response);

      if (response is Map<String, dynamic> && response.containsKey('token')) {
        SignModel signModel = SignModel.fromJson(response);
        CacheHelper.saveData(key: ApiKey.token, value: signModel.token);
        CacheHelper.saveData(key: "userInfo", value: signModel.user);
      }
      emit(Regsuccess());
    } on ServeEror catch (e) {
      emit(Regfailure(errormessage: e.erorrModel.errorMessage));
    }
  }

  Future<void> forgetPass({String? email, String? phone}) async {
    emit(AuthLoading());
    try {
      var response = await api.post(
        Endpoint.forgetwithemail,
        data: {ApiKey.email: email, ApiKey.phone: phone},
      );
      print(response);
      emit(ForgetPass());
    } on ServeEror catch (e) {
      emit(Forgetfaliure(errormessage: e.erorrModel.errorMessage));
    }
  }

  resPassword(String email ,String pass,String confirm)async{
    emit(AuthLoading());
    try {
      var response = await api.post(
        Endpoint.restPass,
        data: {ApiKey.email: email, ApiKey.password:pass,ApiKey.confirmPassword:confirm},
      );
      print(response);
      emit(RestPassSuccess());
    } on ServeEror catch (e) {
      emit(RestPassfaliure(errormessage: e.erorrModel.errorMessage));
    }
  }
  }

