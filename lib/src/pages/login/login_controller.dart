import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:uber_clone_flutter_udemy/src/models/cliente.dart';
import 'package:uber_clone_flutter_udemy/src/models/driver.dart';
import 'package:uber_clone_flutter_udemy/src/providers/auth_provider.dart';
import 'package:uber_clone_flutter_udemy/src/providers/client_provider.dart';
import 'package:uber_clone_flutter_udemy/src/providers/driver_provider.dart';
import 'package:uber_clone_flutter_udemy/src/utils/shared_pref.dart';
import 'package:uber_clone_flutter_udemy/src/utils/snackbar.dart' as utils;
import '../../utils/my_progress_dialog.dart';

class LoginController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthProvider _authProvider;
  DriverProvider _driverProvider;
  ClientProvider _clientProvider;

  ProgressDialog _progressDialog;
  SharedPref _sharedPref;

  String _typeUser;

  Future init(BuildContext context) async {
    this.context = context;
    _authProvider = new AuthProvider();
    _clientProvider = new ClientProvider();
    _driverProvider = new DriverProvider();
    _progressDialog = MyProgressDialog.createProgressDialog(context, 'Espere un momento ...');
    _sharedPref = new SharedPref();
    _typeUser = await _sharedPref.read('typeUser');

    print('------------------ tipo usuario --------------------');
    print(_typeUser);
  }

  void goToRegisterPage(){

    if(_typeUser == 'client'){
      Navigator.pushNamed(context, 'client/register');
    }else if(_typeUser == 'driver'){
      Navigator.pushNamed(context, 'driver/register');
    }

  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('email: $email and password $password');


    try {
      _progressDialog.show();
      bool isLogin = await _authProvider.login(email, password);
      _progressDialog.hide();

      if (isLogin) {
        if(_typeUser == 'client'){
          Client client = await _clientProvider.getById(_authProvider.getUser().uid);
          if(client != null){
            utils.Snackbar.showSnackbar(context, key, 'El usuario se encuentra logeado');
            Navigator.pushNamedAndRemoveUntil(context, 'client/map', (route) => false);
          } else {
            utils.Snackbar.showSnackbar(context, key, 'El usuario no es valido');
            await _authProvider.signOut();
          }
        } else if(_typeUser == 'driver'){
          Driver driver = await _driverProvider.getById(_authProvider.getUser().uid);
          if(driver != null){
            utils.Snackbar.showSnackbar(context, key, 'El usuario se encuentra logeado');
            Navigator.pushNamedAndRemoveUntil(context, 'driver/map', (route) => false);
          } else {
            utils.Snackbar.showSnackbar(context, key, 'El usuario no es valido');
            await _authProvider.signOut();
          }
        }

      } else {
        utils.Snackbar.showSnackbar(context, key, 'Email y/o password incorrectos');
      }
    } catch (error) {
      _progressDialog.hide();
      utils.Snackbar.showSnackbar(context, key, 'Error: $error');
      print('Error: $error');
    }
  }
}
