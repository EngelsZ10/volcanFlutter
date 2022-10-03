import "dart:math";

double format(var numero, var digitos) =>
    ((numero * pow(10, digitos)).toInt()) / pow(10, digitos);

double v = 265;
var an = 14.18;

var a = 0.0;
var vi = v * sin(radians(an));
var b = 5;
var m = 8;
double posy = 0.0;

double radians(degrees) => degrees * (pi / 180);

double valk(m, b) => m * (-9.81) / b;

double velocidad(t, b, m, v) {
  double k = valk(m, b);
  double c = -b / m;
  double vf = k + (v - k) * exp(c * t);
  return vf;
}

double aceleracion(t, b, m, v) {
  double c = -b / m;
  double k = valk(m, b);
  double a = c * (v - k) * exp(c * t);
  return a;
}

double pos(v, a, posi, t) {
  double posf = posi + v * t + a * (.5) * t * t;
  return posf;
}

void main() {
  for (int i = 0; i < 104; i += 1) {
    v = velocidad(i / 10, b, m, vi);
    a = aceleracion(i / 10, b, m, vi);
    print([i, format(a, 3), format(v, 3), format(posy, 3)]);
    posy = pos(v, a, posy, 0.1);
  }
}
