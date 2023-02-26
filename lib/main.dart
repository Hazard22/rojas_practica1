import 'dart:io';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rojas_practica_1_registro/widgets/passTxtFields.dart';
import 'package:rojas_practica_1_registro/widgets/txtField.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Txtfield email = Txtfield("Email");
  final Txtfield name = Txtfield("Nombres");
  final Txtfield laName = Txtfield("Apellidos");
  final PassTxtFields pass = PassTxtFields("Contraseña");
  final PassTxtFields veriPass = PassTxtFields("Confirmar contraseña");

  final ImagePicker _picker = ImagePicker();

  var seleImg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 230, 230, 1),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(254, 193, 4, 1),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40))),
                          child: Center(
                              child: Text(
                            "Registro de usuario",
                            style: TextStyle(fontSize: 30),
                          )),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 50,
                          left: 50,
                          child: seleImg == null
                              ? Center(
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/images/avatar.png"),
                                    backgroundColor: Colors.yellow,
                                    radius: 80,
                                  ),
                                )
                              : Center(
                                  child: CircleAvatar(
                                    backgroundImage: FileImage(seleImg),
                                    backgroundColor: Colors.yellow,
                                    radius: 80,
                                  ),
                                )),
                      Positioned(
                          bottom: 0,
                          right: 130,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 35,
                            child: IconButton(
                                onPressed: () {
                                  AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.noHeader,
                                      headerAnimationLoop: false,
                                      animType: AnimType.bottomSlide,
                                      title:
                                          'Seleccione un origin para la imagen',
                                      showCloseIcon: true,
                                      body: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ListTile(
                                              title: Text("Camara"),
                                              leading: Icon(Icons.camera),
                                              onTap: () async {
                                                await pickImgCame();
                                              },
                                            ),
                                            ListTile(
                                              title: Text("Galeria"),
                                              leading: Icon(
                                                  Icons.add_photo_alternate),
                                              onTap: () async {
                                                await pickImgGall();
                                              },
                                            )
                                          ],
                                        ),
                                      )).show();
                                },
                                icon: Icon(Icons.photo_library)),
                          ))
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      email,
                      name,
                      laName,
                      pass,
                      veriPass,
                      Container(
                        margin: EdgeInsets.all(20),
                        child: SocialLoginButton(
                          backgroundColor: Colors.amber,
                          height: 50,
                          text: 'Registrar',
                          borderRadius: 20,
                          fontSize: 25,
                          buttonType: SocialLoginButtonType.generalLogin,
                          onPressed: () {
                            if (email.valor == "" ||
                                name.valor == "" ||
                                laName.valor == "" ||
                                pass.valor == "" ||
                                veriPass.valor == "") {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                headerAnimationLoop: false,
                                title: 'Error',
                                desc: 'Uno o mas campos estan vacios',
                                btnOkOnPress: () {},
                                btnOkIcon: Icons.cancel,
                                btnOkColor: Colors.red,
                              ).show();
                            } else if (!isEmail(email.valor)) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                headerAnimationLoop: false,
                                animType: AnimType.topSlide,
                                showCloseIcon: true,
                                closeIcon:
                                    const Icon(Icons.close_fullscreen_outlined),
                                title: 'Alerta',
                                desc: 'La direccion de correo no es valida',
                                btnOkOnPress: () {},
                              ).show();
                            } else if (pass.valor != veriPass.valor) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                headerAnimationLoop: false,
                                animType: AnimType.topSlide,
                                showCloseIcon: true,
                                closeIcon:
                                    const Icon(Icons.close_fullscreen_outlined),
                                title: 'Alerta',
                                desc: 'Las contraseñas no coinciden',
                                btnOkOnPress: () {},
                              ).show();
                            } else {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.leftSlide,
                                headerAnimationLoop: false,
                                dialogType: DialogType.success,
                                showCloseIcon: true,
                                desc: 'Usuario registrado con exito',
                                btnOkOnPress: () {
                                  debugPrint('OnClcik');
                                },
                                btnOkIcon: Icons.check_circle,
                                onDismissCallback: (type) {
                                  debugPrint(
                                      'Dialog Dissmiss from callback $type');
                                },
                              ).show();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Future<void> pickImgGall() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        seleImg = File(image.path);
        print("Cromo perro");
      }
    });
  }

  Future<void> pickImgCame() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        seleImg = File(image.path);
        print("Cromo perro");
      }
    });
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }
}
