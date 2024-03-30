mixin ModelChecker {
  double? convertToDouble(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return value.toDouble();
    } else {
      return value;
    }
  }

  String convertToString(dynamic value) {
    String result = '';
    if (value == null) {
      result = '';
    } else {
      result = value.toString();
    }
    return result;
  }

  int convertToInteger(dynamic value) {
    int result = 0;
    if (value == null) {
      result = 0;
    } else if (value is String) {
      result = int.parse(value);
    } else if (value is double) {
      result = value.floor();
    } else {
      result = value;
    }
    return result;
  }

  bool convertToBoolean(dynamic value) {
    bool result = false;
    if (value == null) {
      result = false;
    } else if (value is String) {
      result = value.toLowerCase() == 'true';
    } else {
      result = value;
    }
    return result;
  }
}
