import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Volcan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Volcano",
      home: MyCanvas(),
    );
  }
}

class MyCanvas extends StatefulWidget {
  @override
  _MyCanvasState createState() => _MyCanvasState();
}

class _MyCanvasState extends State<MyCanvas> with TickerProviderStateMixin {
  var temPos = Offset(0, 0);
  var disPos = Offset(0, 0);
  double pos = 0;
  var angulo;
  var velocidad;
  var masa;
  var friccion;
  var columna;
  var vimage;
  var drawerhight = 0.0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
  final anguloController = TextEditingController();
  final velocidadController = TextEditingController();
  final friccionController = TextEditingController();
  final masaController = TextEditingController();

  Animation<double> animation;
  AnimationController controller;
  void animationStart() {
    var controller = AnimationController(
        duration: Duration(milliseconds: 7500), vsync: this);
    animation = Tween(begin: 0.0, end: 400.0).animate(controller)
      ..addListener(() {
        setState(() {
          //pos es tiempo
          columna = col;
          pos = animation.value;
        });
      });
    animation
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          columna = col;
          pos = 500;
        } else if (status == AnimationStatus.dismissed) {
          //print("hola");
        }
      });
    if (controller.isAnimating &&
        velocidad != null &&
        angulo != null &&
        friccion != null &&
        masa != null) {
      controller.stop();
    } else {
      controller.forward();
    }
  }

  List column() {
    if (col == []) {
      return columna;
    } else {
      return col;
    }
  }

  @override
  void initState() {
    super.initState();
    rootBundle
        .load('lib/Assets/v.jpg')
        .then((data) => setState(() => this.vimage = data));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        endDrawer: Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .345 * .9,
            height: MediaQuery.of(context).size.height * .60 * .9,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(15.0)),
              child: Drawer(
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  decoration: BoxDecoration(
                      color: Colors.deepOrange[100],
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(15))),
                  child: FittedBox(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        Container(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 15,
                            ),
                            Container(
                              height: 150,
                              width: 110,
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Container(
                                    child: TextField(
                                        controller: velocidadController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Velocidad',
                                        ),
                                        keyboardType: TextInputType.number),
                                  ),
                                  Container(
                                    height: 15,
                                  ),
                                  Container(
                                    child: TextField(
                                        controller: anguloController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Angulo',
                                        ),
                                        keyboardType: TextInputType.number),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 150,
                              width: 100,
                              child: Column(
                                children: [
                                  Container(
                                    child: TextField(
                                        controller: friccionController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Friccion',
                                        ),
                                        keyboardType: TextInputType.number),
                                  ),
                                  Container(
                                    height: 15,
                                  ),
                                  Container(
                                    child: TextField(
                                        controller: masaController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Masa',
                                        ),
                                        keyboardType: TextInputType.number),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/Assets/v.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CustomPaint(
                painter: VolcanPainter(
                    pos, velocidad, angulo, masa, friccion, vimage),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 70,
                        width: 86,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("lib/Assets/volc.png"),
                          fit: BoxFit.cover,
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: 220,
            width: 100,
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  margin: new EdgeInsets.symmetric(horizontal: 20.0),
                  child: FloatingActionButton(
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.edit),
                      onPressed: () {
                        scaffoldKey.currentState.openEndDrawer();
                      }),
                ),
                Container(
                  height: 60,
                  width: 60,
                  margin: new EdgeInsets.symmetric(vertical: 20.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.play_arrow_rounded),
                    onPressed: () {
                      //set variables
                      velocidad = velocidadController.text;
                      angulo = anguloController.text;
                      friccion = friccionController.text;
                      masa = masaController.text;
                      //pasar a double
                      velocidad = double.tryParse(velocidad);
                      angulo = double.tryParse(angulo);
                      friccion = double.tryParse(friccion);
                      masa = double.tryParse(masa);
                      pos = 0;

                      if (velocidad != null &&
                          angulo != null &&
                          friccion != null &&
                          masa != null) {
                        animationStart();
                      } else {
                        velocidad = 1.0;
                        angulo = 270.0;
                        friccion = 1.0;
                        masa = 1.0;

                        // SnackBar(
                        //   behavior: SnackBarBehavior.floating,
                        //   content: Text('Text label'),
                        //   action: SnackBarAction(
                        //     label: 'Action',
                        //     onPressed: () {},
                        //   ),
                        // );
                      }
                    },
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: FloatingActionButton(
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.assignment),
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.deepOrange[100],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 500,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                    columns: [
                                      DataColumn(
                                        label: Text(
                                          "Posicion en X",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                          label: Text(
                                        "Posicion en Y",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Velocidad",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Aceleración",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic),
                                      )),
                                    ],
                                    rows: columna,
                                  ),
                                ),
                              );
                            });
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
