class Validation {
  static int _symbolCount(String s, String symbol) {
    int count = 0;

    for (int i = 0; i < s.length; i++) {
      if (s.substring(i, i + 1) == symbol) {
        count++;
      }
    }

    return count;
  }

  static String emailValidation(String email) {
    if (email == " " || email == null) {
      return "Email field cannot be empty";
    }

    if (!email.contains("@")) {
      return "No @ symbol Error";
    }

    if (_symbolCount(email, "@") != 1) {
      return "Multiple @ symbols Error";
    }

    if (email.endsWith(".") || email.startsWith(".") || email.startsWith(" ")) {
      return "Invalid Email";
    }
  }

  static String checkPassword(String password) {
    if (password == " " || password == null) {
      return "Password cannot be empty";
    } else if (password.length < 6) {
      return "Password should be at least 6 characters";
    } else {
      return null;
    }
  }

  static String checkConform(String password, String conform) {
    if ((password != conform || conform == null)) {
      // print(_conformError);
      return "Password isn't mach";
    } else {
      return null;
    }
  }
}
