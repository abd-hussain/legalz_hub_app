class PasswordStrengthModel {
  PasswordStrengthModel(
      {this.min8max30Cchar,
      this.oneUpperCase,
      this.oneNumber,
      this.oneSpicialChar,
      this.oneLowerCase});
  bool? min8max30Cchar;
  bool? oneUpperCase;
  bool? oneLowerCase;
  bool? oneNumber;
  bool? oneSpicialChar;
}
