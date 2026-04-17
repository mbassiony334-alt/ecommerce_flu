import 'package:bloc/bloc.dart';
import 'package:e_commarcae/core/error/server_error.dart';
import 'package:e_commarcae/core/services/api/api_consumer.dart';
import 'package:e_commarcae/core/services/api/endpoints.dart';
import 'package:e_commarcae/core/services/cache/cache_helper.dart';
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
      await CacheHelper.saveData(key: ApiKey.token, value: signModel.token);
      await CacheHelper.saveData(key: 'userName', value: signModel.user.name);
      emit(AuthSucces());
    } on ServerError catch (e) {
      emit(AuthFailure(errormessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(AuthFailure(errormessage: e.toString()));
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
        await CacheHelper.saveData(key: ApiKey.token, value: signModel.token);
        await CacheHelper.saveData(key: 'userName', value: signModel.user.name);
      }
      emit(Regsuccess());
    } on ServerError catch (e) {
      emit(Regfailure(errormessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(Regfailure(errormessage: e.toString()));
    }
  }

  Future<void> forgetPass({String? email, String? phone}) async {
    emit(AuthLoading());
    try {
      var response = await api.post(
        Endpoint.forgetWithEmail,
        data: {ApiKey.email: email, ApiKey.phone: phone},
      );
      print(response);
      emit(ForgetPass());
    } on ServerError catch (e) {
      emit(Forgetfaliure(errormessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(Forgetfaliure(errormessage: e.toString()));
    }
  }

  resPassword(String email ,String pass,String confirm)async{
    emit(AuthLoading());
    try {
      var response = await api.post(
        Endpoint.resetPassword,
        data: {ApiKey.email: email, ApiKey.password:pass,ApiKey.confirmPassword:confirm},
      );
      print(response);
      emit(RestPassSuccess());
    } on ServerError catch (e) {
      emit(RestPassfaliure(errormessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(RestPassfaliure(errormessage: e.toString()));
    }
  }
  }

