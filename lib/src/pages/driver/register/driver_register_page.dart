import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:uber_clone_flutter_udemy/src/pages/driver/register/driver_register_controller.dart';
import 'package:uber_clone_flutter_udemy/src/utils/colors.dart' as utils;
import 'package:uber_clone_flutter_udemy/src/utils/otp_widget.dart';
import 'package:uber_clone_flutter_udemy/src/widgets/button_app.dart';

// StatefulWidget se utiliza cuando hay cambios en los objetos
class DriverRegisterPage extends StatefulWidget {
  // const RegisterPage({Key? key}) : super(key: key);

  @override
  _DriverRegisterPageState createState() => _DriverRegisterPageState();
}

class _DriverRegisterPageState extends State<DriverRegisterPage> {
  DriverRegisterController _con = new DriverRegisterController();

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
              _textRegister(),
              _textLicencePlate(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: OTPFields(
                  pin1: _con.pin1Controller,
                  pin2: _con.pin2Controller,
                  pin3: _con.pin3Controller,
                  pin4: _con.pin4Controller,
                  pin5: _con.pin5Controller,
                  pin6: _con.pin6Controller,
                ),
              ),
              _textFieldUserName(),
              _textFieldEmail(),
              _textFieldPassword(),
              _textFieldConfirmPassword(),
              _buttonRegister(),
            ],
          ),
        ));
  }

  Widget _textLicencePlate(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'Placa del vehiculo',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 17
        ),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: _con.Register,
        text: 'Registrarse ahora',
        color: utils.Colors.ubberCloneColor,
        textColor: Colors.white,
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _con.emailController,
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

  Widget _textFieldUserName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: TextField(
        controller: _con.userNameController,
        decoration: InputDecoration(
            hintText: 'Pepito Perez',
            labelText: 'Nombre de Usuario',
            suffixIcon: Icon(
              //prefixIcon para ponerlo al principio
              Icons.person_outline,
              color: utils.Colors.ubberCloneColor,
            )),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
        controller: _con.passwordController,
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

  Widget _textFieldConfirmPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
        controller: _con.confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Confirmar Contraseña',
            suffixIcon: Icon(
              //prefixIcon para ponerlo al principio
              Icons.lock_open_outlined,
              color: utils.Colors.ubberCloneColor,
            )),
      ),
    );
  }

  Widget _textRegister() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Text(
        'REGISTRO',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }

  Widget _bannerApp() {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        color: utils.Colors.ubberCloneColor,
        height: MediaQuery.of(context).size.height * 0.22,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/img/logo_app.png',
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.20),
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
