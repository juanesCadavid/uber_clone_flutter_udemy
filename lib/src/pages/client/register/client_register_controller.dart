import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:uber_clone_flutter_udemy/src/models/cliente.dart';
import 'package:uber_clone_flutter_udemy/src/providers/auth_provider.dart';
import 'package:uber_clone_flutter_udemy/src/providers/client_provider.dart';
import 'package:uber_clone_flutter_udemy/src/utils/my_progress_dialog.dart';
import 'package:uber_clone_flutter_udemy/src/utils/snackbar.dart' as utils;

class ClientRegisterController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  AuthProvider _authProvider;
  ClientProvider _clientProvider;
  ProgressDialog _progressDialog;

  Future init(BuildContext context) {
    this.context = context;
    _authProvider = new AuthProvider();
    _clientProvider = new ClientProvider();
    _progressDialog = MyProgressDialog.createProgressDialog(context, 'Espere un momento ...');
  }

  void Register() async {
    String userName = userNameController.text;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('email: $email and password $password');

    if (userName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      print('todos los campos son obligatorios');
      utils.Snackbar.showSnackbar(context, key, 'todos los campos son obligatorios');
      return;
    }

    if (confirmPassword != password) {
      print('las contraeñas no coinciden');
      utils.Snackbar.showSnackbar(context, key, 'las contraeñas no coinciden');
      return;
    }

    if (password.length < 6) {
      print('la contraeña tiene que tener al menos 6 caracteres');
      utils.Snackbar.showSnackbar(context, key, 'la contraeña tiene que tener al menos 6 caracteres');
      return;
    }

    _progressDialog.show();

    try {
      bool isRegister = await _authProvider.register(email, password);
      if (isRegister) {
        Client client = new Client(
          id:_authProvider.getUser().uid,
          email:_authProvider.getUser().email,
          userName: userName,
          password: password

        );
        await _clientProvider.create(client);
        _progressDialog.hide();
        utils.Snackbar.showSnackbar(context, key, 'el usuario se registro');
        Navigator.pushNamedAndRemoveUntil(context, 'client/map', (route) => false);
      } else {
        utils.Snackbar.showSnackbar(context, key, 'no se pudo registrar');
      }
    } catch (error) {
      _progressDialog.hide();
      utils.Snackbar.showSnackbar(context, key, 'Error: $error');
      print('Error: $error');
    }
  }
}
