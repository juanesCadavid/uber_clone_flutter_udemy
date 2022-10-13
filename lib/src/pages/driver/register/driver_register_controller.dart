import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:uber_clone_flutter_udemy/src/models/cliente.dart';
import 'package:uber_clone_flutter_udemy/src/models/driver.dart';
import 'package:uber_clone_flutter_udemy/src/providers/auth_provider.dart';
import 'package:uber_clone_flutter_udemy/src/providers/client_provider.dart';
import 'package:uber_clone_flutter_udemy/src/providers/driver_provider.dart';
import 'package:uber_clone_flutter_udemy/src/utils/my_progress_dialog.dart';
import 'package:uber_clone_flutter_udemy/src/utils/snackbar.dart' as utils;

class DriverRegisterController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  TextEditingController pin1Controller = new TextEditingController();
  TextEditingController pin2Controller = new TextEditingController();
  TextEditingController pin3Controller = new TextEditingController();
  TextEditingController pin4Controller = new TextEditingController();
  TextEditingController pin5Controller = new TextEditingController();
  TextEditingController pin6Controller = new TextEditingController();

  AuthProvider _authProvider;
  DriverProvider _driverProvider;
  ProgressDialog _progressDialog;

  Future init(BuildContext context) {
    this.context = context;
    _authProvider = new AuthProvider();
    _driverProvider = new DriverProvider();
    _progressDialog = MyProgressDialog.createProgressDialog(context, 'Espere un momento ...');
  }

  void Register() async {
    String userName = userNameController.text;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    String pin1 = pin1Controller.text.trim().substring(0,1);
    String pin2 = pin2Controller.text.trim().substring(0,1);
    String pin3 = pin3Controller.text.trim().substring(0,1);
    String pin4 = pin4Controller.text.trim().substring(0,1);
    String pin5 = pin5Controller.text.trim().substring(0,1);
    String pin6 = pin6Controller.text.trim().substring(0,1);

    String placa = '$pin1$pin2$pin3-$pin4$pin5$pin6';

    print('email: $email and password $password');

    if (userName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      utils.Snackbar.showSnackbar(context, key, 'todos los campos son obligatorios');
      return;
    }

    if (confirmPassword != password) {
      utils.Snackbar.showSnackbar(context, key, 'las contraeñas no coinciden');
      return;
    }

    if (password.length < 6) {
      utils.Snackbar.showSnackbar(context, key, 'la contraeña tiene que tener al menos 6 caracteres');
      return;
    }

    _progressDialog.show();

    try {
      bool isRegister = await _authProvider.register(email, password);
      if (isRegister) {
        Driver driver = new Driver(
          id:_authProvider.getUser().uid,
          email:_authProvider.getUser().email,
          userName: userName,
          password: password,
          placa: placa
        );
        await _driverProvider.create(driver);
        _progressDialog.hide();
        utils.Snackbar.showSnackbar(context, key, 'el usuario se registro');
        Navigator.pushNamedAndRemoveUntil(context, 'driver/map', (route) => false);
      } else {
        utils.Snackbar.showSnackbar(context, key, 'no se pudo registrar');
      }
    } catch (error) {
      _progressDialog.hide();
      utils.Snackbar.showSnackbar(context, key, 'Error: $error');
    }
  }
}
