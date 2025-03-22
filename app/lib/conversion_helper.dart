class ConversionHelper {
  static double convert(String type, double value) {
    switch (type) {
      case 'mphToKph':
        return value * 1.60934;
      case 'kphToMph':
        return value * 0.621371;
      case 'fahrenheitToCelsius':
        return (value - 32) / 1.8;
      case 'celsiusToFahrenheit':
        return (value * 1.8) + 32;
      default:
        throw ArgumentError("Invalid conversion type: $type");
    }
  }
}
