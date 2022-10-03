import 'dart:math';

double aceleracion;
double velocidadY;

double radians(degrees) => degrees * (pi / 180);

double tiempoTotal(velocidad, angulo) =>
    (2 * velocidad * sin(radians(angulo))) / 9.81;

double vely(double v, double a) => v *= sin(radians(a));

double valk(m, b) => m * (-9.81) / b;

double veloc(t, b, m, v) {
  double k = valk(m, b);
  double c = -b / m;
  double vf = k + (v - k) * exp(c * t);
  return vf;
}

double acc(t, b, m, v) {
  double c = -b / m;
  double k = valk(m, b);
  double a = c * (v - k) * exp(c * t);
  return a;
}

double pos(v, b, m, t) {
  double c = m / b;
  double k = valk(m, b);
  double c2 = -b / m;
  double posf = k * t + c * (v - k) * (1 - exp(t * c2));
  return posf;
}

double posicionEnEje(
    var eje, var velocidad, var angulo, var b, var m, var tiempo) {
  if (eje == "y") {
    velocidad = vely(velocidad, angulo);
    return pos(velocidad, b, m, tiempo);
  } else if (eje == "y2") {
    velocidad = vely(velocidad, angulo);
    return velocidad * tiempo - 4.509 * tiempo * tiempo;
  } else {
    velocidad *= cos(radians(angulo));
    return velocidad * tiempo;
  }
}

double format(var numero, var digitos) =>
    ((numero * pow(10, digitos)).toInt()) / pow(10, digitos);

List hazTabla(String ejey, velocidad, angulo, friccion, masa, tiempo) {
  List<double> pos = [];
  var x = posicionEnEje('x', velocidad, angulo, friccion, masa, tiempo);
  var y = posicionEnEje(ejey, velocidad, angulo, friccion, masa, tiempo);
  //x = format(x, 2);
  //y = format(y, 2);
  pos.add(x);
  pos.add(y);
  return pos;
}
