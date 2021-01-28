import 'dart:convert';
import 'package:flash_chat/constants/constants.dart';
import 'package:flash_chat/models/remember_me.dart';
import 'package:flash_chat/repository/hive_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth extends ChangeNotifier {
  HiveRepository _hiveRepository = HiveRepository();

  RememberMe _remember;



  RememberMe get remember => _remember;


  setRemember(RememberMe remember) => _remember = remember;


  static Auth authProvider(BuildContext context, {bool listen = false}) => Provider.of<Auth>(context, listen: listen);





  RememberMe rememberMe(RememberMe remember) {
    setRemember(remember);
    print('remember ${remember.rememberMeBool}');
    return remember;
  }



  logout() {
    setRemember(null);
    _hiveRepository.clear<RememberMe>(name: kRemember);
    print('remember: $remember');
  }



}
