import 'package:tempcord/data/type/temperature.dart';

enum BodyTemperatureClassification { hypothermia, normal, hyperthermia }

enum Animal { human }

class _BodyTemperatureRangeMetadata {
  final Temperature lowNormalPoint;
  final Temperature highNormalPoint;

  _BodyTemperatureRangeMetadata(
      {required this.lowNormalPoint, required this.highNormalPoint});

  BodyTemperatureClassification classify(Temperature temperature) {
    if (temperature < lowNormalPoint) {
      return BodyTemperatureClassification.hypothermia;
    } else if (temperature > highNormalPoint) {
      return BodyTemperatureClassification.hyperthermia;
    }

    return BodyTemperatureClassification.normal;
  }
}

extension AnimalMetadata on Animal {
  _BodyTemperatureRangeMetadata get _metadata {
    switch (this) {
      case Animal.human:
        return _BodyTemperatureRangeMetadata(
            lowNormalPoint: Celsius(35), highNormalPoint: Celsius(37.5));
      default:
        throw UnimplementedError("No metadata is defined for $name");
    }
  }

  BodyTemperatureClassification classify(Temperature temperature) =>
      _metadata.classify(temperature);
}
