import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _con = new HomeController();

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
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.black, Colors.black87]
                )
            ),
            child: Column(
              children: [
                _bannerApp(context),
                SizedBox(height: 50,),
                _textSelectYourRol(),
                SizedBox(height: 30),
                _imageTypeUser(context,'assets/img/pasajero.png','client'),
                SizedBox(height: 10),
                _textTypeUser('Cliente'),
                SizedBox(height: 50),
                _imageTypeUser(context,'assets/img/driver.png','driver'),
                SizedBox(height: 10),
                _textTypeUser('Conductor')
              ],
            ),
          ),
        )
    );
  }

  Widget _bannerApp(BuildContext context) {
    return ClipPath(
      clipper: DiagonalPathClipperTwo(),
      child: Container(
        color: Colors.white,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
                'assets/img/logo_app.png',
                width: 150,
                height: 100),
            Text(
              'facil y rapido',
              style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textSelectYourRol() {
    return Text(
      'SELECIONA TU ROL',
      style: TextStyle(
          color: Colors.white,
          fontFamily: 'OneDay',
          fontSize: 22,
          fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _imageTypeUser(BuildContext context, String image, String typeUser) {
    return GestureDetector(
      onTap: () {
        _con.goToLoginPage(typeUser);
      },
      child: CircleAvatar(
        backgroundImage: AssetImage(image),
        radius: 50,
        backgroundColor: Colors.grey[900],
      ),
    );
  }

  Widget _textTypeUser(String typeUser) {
    return Text(
      typeUser,
      style: TextStyle(
          color: Colors.white,
          fontSize: 16
      ),
    );
  }
}
