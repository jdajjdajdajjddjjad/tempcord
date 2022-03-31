import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

const String _celsiusUnit = "\u{2103}", _fahrenheitUnit = "\u{2109}";

abstract class Temperature implements Comparable<Temperature> {
  final double value;

  Temperature._(this.value) : assert(value.isFinite);

  String get unit;

  Temperature _convertSameUnit(Temperature other);

  @override
  int compareTo(Temperature other) {
    double diff = value - _convertSameUnit(other).value;

    if (diff > 0) {
      return 1;
    } else if (diff < 0) {
      return -1;
    }

    return 0;
  }

  @override
  String toString() => "$value$unit";

  String toStringAsReadable() => "${value.toStringAsFixed(1)}$unit";

  /// Check [other] [Temperature] is repersenting same measurement's [value].
  bool sameTemperature(Temperature other) => compareTo(other) == 0;

  @override
  int get hashCode => hash3(runtimeType, value, unit);

  /// Compare [other] has **exact** same data of [Temperature].
  ///
  /// Please uses [sameTemperature] for checking same [Temperature] that
  /// required unit conversion.
  @override
  bool operator ==(Object? other) => hashCode == other.hashCode;

  bool operator >(Temperature other) => compareTo(other) > 0;

  bool operator <(Temperature other) => compareTo(other) < 0;

  bool operator >=(Temperature other) => compareTo(other) >= 0;

  bool operator <=(Temperature other) => compareTo(other) <= 0;

  Temperature operator +(double added);

  Temperature operator -(double subtracted);
}

@sealed
class Celsius extends Temperature {
  Celsius(double value) : super._(value);

  factory Celsius.fromFahrenheit(Fahrenheit fahrenheit) =>
      Celsius((fahrenheit.value - 32) * 5 / 9);

  @override
  Celsius _convertSameUnit(Temperature other) {
    if (other is Celsius) {
      return other;
    } else if (other is Fahrenheit) {
      return Celsius.fromFahrenheit(other);
    }

    throw TypeError();
  }

  @override
  String get unit => _celsiusUnit;

  @override
  Celsius operator +(double added) => Celsius(value + added);

  @override
  Celsius operator -(double subtracted) => Celsius(value - subtracted);
}

@sealed
class Fahrenheit extends Temperature {
  Fahrenheit(double value) : super._(value);

  factory Fahrenheit.fromCelsius(Celsius celsius) =>
      Fahrenheit((celsius.value * 9 / 5) + 32);

  @override
  Fahrenheit _convertSameUnit(Temperature other) {
    if (other is Fahrenheit) {
      return other;
    } else if (other is Celsius) {
      return Fahrenheit.fromCelsius(other);
    }

    throw TypeError();
  }

  @override
  String get unit => _fahrenheitUnit;

  @override
  Fahrenheit operator +(double added) => Fahrenheit(value + added);

  @override
  Fahrenheit operator -(double subtracted) => Fahrenheit(value - subtracted);
}
