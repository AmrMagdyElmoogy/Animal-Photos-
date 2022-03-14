class InputConverter {
  int convertToInteger(String number) {
    try {
      int target = int.parse(number);
      return target;
    } on FormatException {
      throw const FormatException();
    }
  }
}
