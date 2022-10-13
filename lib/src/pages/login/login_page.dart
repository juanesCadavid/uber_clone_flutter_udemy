import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:uber_clone_flutter_udemy/src/pages/login/login_controller.dart';
import 'package:uber_clone_flutter_udemy/src/utils/colors.dart' as utils;
import 'package:uber_clone_flutter_udemy/src/widgets/button_app.dart';
// StatefulWidget se utiliza cuando hay cambios en los objetos
class LoginPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginController _con = new LoginController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
        appBar: AppBar(),
        body: SingleChildScrollView(
          // nos permite hacer scroll
          child: Column(
            children: [
              _bannerApp(),
              _textDescription(),
              _textLogin(),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.12),
              _textFieldEmail(),
              _textFieldPassword(),
              _buttonLogin(),
              _textDontHaveAccount(),
            ],
          ),
        ));
  }

  Widget _textDontHaveAccount() {
    return GestureDetector(
      onTap: _con.goToRegisterPage,
      child: Container(
        margin: EdgeInsets.only(bottom: 50),
        child: Text(
          '¿No tienes cuenta?',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: _con.login,
        text: 'Iniciar sesion',
        color: utils.Colors.ubberCloneColor,
        textColor: Colors.white,
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller:_con.emailController,
        decoration: InputDecoration(
            hintText: 'Correo@gmail.com',
            labelText: 'Correo electronico',
            suffixIcon: Icon(
              //prefixIcon para ponerlo al principio
              Icons.email_outlined,
              color: utils.Colors.ubberCloneColor,
            )),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
        controller:_con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Contraseña',
            suffixIcon: Icon(
              //prefixIcon para ponerlo al principio
              Icons.lock_open_outlined,
              color: utils.Colors.ubberCloneColor,
            )),
      ),
    );
  }

  Widget _textDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'Continua con tu',
        style: TextStyle(
            color: Colors.black54, fontSize: 24, fontFamily: 'NimbusSans'),
      ),
    );
  }

  Widget _textLogin() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'Login',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
      ),
    );
  }

  Widget _bannerApp() {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: utils.Colors.ubberCloneColor,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.22,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/img/logo_app.png',
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.45,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.20),
            Text(
              '               ',
              style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
