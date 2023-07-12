import 'package:flutter/material.dart';

class LoginpPage extends StatefulWidget {
  LoginpPage({Key? key}) : super(key: key);

  @override
  _LoginpPageState createState() => _LoginpPageState();
}

class _LoginpPageState extends State<LoginpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        title: Text(
          'Iniciar sesion',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                width: 100,
                height: 100,
                image: AssetImage('assets/logo.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: size.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('#SOSCuba',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Ingrese sus credenciales',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          style: TextStyle(fontFamily: 'Roboto'),
                          textCapitalization: TextCapitalization.none,
                          maxLength: 30,
                          controller: usernameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.red,
                            border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2)),
                            counterText: '',
                            hintText: 'ejemplo: miguelangel',
                            labelText: 'Usuario',
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          maxLength: 15,
                          controller: passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            fillColor: Colors.red,
                            border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2)),
                            counterText: '',
                            hintText: 'Introduzca su contraseña',
                            labelText: 'Contraseña',
                          )),
                    ),
                    FilledButton(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 15.0),
                        child: Text("Entrar",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            )),
                      ),
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(25.0)),
                      // elevation: 0.0,
                      // color: Colors.red[400],
                      onPressed: () {
                        setState(() {
                          // loading = true;
                        });
                        // _send();
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
