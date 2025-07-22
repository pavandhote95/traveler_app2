import 'package:flutter/material.dart';

class CustomToast {
  static void show(
      BuildContext context, {
        required String message,
        required Color backgroundColor,
        Color textColor = Colors.white,
        bool isTop = false,
      }) {
    if (isTop) {
      _showTopSnackBar(context, message, backgroundColor, textColor);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          content: Text(
            message,
            style: TextStyle(
              fontFamily: 'MontserratMedium',
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
              color: textColor,
            ),
          ),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(22), // Ensures floating works properly
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  static void _showTopSnackBar(
      BuildContext context, String message, Color backgroundColor, Color textColor) {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 0,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Text(
              message,
              style: TextStyle(
                fontFamily: 'MontserratMedium',
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  static void showErrorHome(BuildContext context, String message, {bool isTop = false}) {
    show(
      context,
      message: message,
      backgroundColor:  const Color(0xFF1E1E1E),
      textColor: Colors.white,
      isTop: isTop,
    );
  }
    static void showError(BuildContext context, String message, {bool isTop = false}) {
    show(
      context,
      message: message,
      backgroundColor: Colors.redAccent,
      textColor: Colors.black,
      isTop: isTop,
    );
  }

  static void showSuccessHome(BuildContext context, String message, {bool isTop = false}) {
    show(
      context,
      message: message,
      backgroundColor: Colors.tealAccent.shade700,
      textColor: Colors.white,
      isTop: isTop,
    );
  }
    
  static void showSuccess(BuildContext context, String message, {bool isTop = false}) {
    show(
      context,
      message: message,
      backgroundColor: Colors.tealAccent.shade700,
      textColor: Colors.white,
      isTop: isTop,
    );
  }
  }
