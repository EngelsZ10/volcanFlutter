import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'caidaLibreFunciones.dart';
import 'dart:math';

double F(double x) => x * 10;

var renglon = [
  DataCell(Text("")),
  DataCell(Text("")),
  DataCell(Text("")),
  DataCell(Text(""))
];

var col = [DataRow(cells: renglon)];

void ejes(canvas, size, color) {
  for (double i = 0; i < (size.height) * 6; i += 100) {
    canvas.drawLine(Offset(0, i), Offset(20, i), color);
  }

  for (double i = 0; i < (size.width) * 6; i += 100) {
    canvas.drawLine(Offset(i, 0), Offset(i, 20), color);
  }
}

double vely2(v, a) => v *= sin(radians(a));

double mov = 0;
var escala = 6;
var origen = [224.0, 270.0];

class VolcanPainter extends CustomPainter {
  var p1 = Offset(origen[0], origen[1]);
  var p2 = Offset(origen[0], origen[1]);
  var velocidad;
  var angulo;
  var masa;
  var friccion;
  double _pos;
  var vimage;
  final black = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10.0
    ..color = Colors.black;
  Paint orangeFill = Paint()..color = Colors.orange[600];

  VolcanPainter(this._pos, this.velocidad, this.angulo, this.masa,
      this.friccion, this.vimage)
      : super();

  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    canvas.scale(1 / 5, -1 / 5);

    // for (double i = 0; i < _pos; i++) {
    //   var pos = hazTabla("y2", velocidad, angulo, friccion, masa, (i / 100));
    //   p2 = Offset(F(pos[0]) + 200, F(pos[1]));
    //   canvas.drawLine(p1, p2, orangeFill);
    //   p1 = p2;
    // }

    col = [];
    // _pos es el tiempo
    for (double i = 0; i < _pos; i++) {
      if (p2.dy > 29) {
        var pos = hazTabla("y", velocidad, angulo, friccion, masa, (i / 10));
        p2 = Offset(F(pos[0]) + origen[0], F(pos[1]) + origen[1]);
        canvas.drawLine(p1, p2, black);
        p1 = p2;
        if (p2.dy >= 0) {
          renglon = [];
          var velo = veloc((i / 10), friccion, masa, vely(velocidad, angulo));
          var acel = acc((i / 10), friccion, masa, vely(velocidad, angulo));
          var posx = format(pos[0] + origen[0] / 10, 2);
          var posy = format(pos[1] + origen[1] / 10, 2);
          velo = format(velo, 2);
          acel = format(acel, 2);
          renglon.add(DataCell(Text("$posx")));
          renglon.add(DataCell(Text("$posy")));
          renglon.add(DataCell(Text("$velo")));
          renglon.add(DataCell(Text("$acel")));
          col.add(DataRow(cells: renglon));
        }
      }
    }
    if (p2 != Offset(origen[0], origen[1])) {
      canvas.drawCircle(p2, 30, orangeFill);
    }
    ejes(canvas, size, black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
