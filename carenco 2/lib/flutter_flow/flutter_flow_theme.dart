// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

abstract class FlutterFlowTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  late Color primaryColor;
  late Color secondaryColor;
  late Color tertiaryColor;
  late Color alternate;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color primaryText;
  late Color secondaryText;

  late Color white;
  late Color grey850;
  late Color grey700;
  late Color grey500;
  late Color grey200;
  late Color grey100;
  late Color figicoGreen;
  late Color black;
  late Color darkenGreen;
  late Color bluegrey;
  late Color figicoRed;
  late Color alertGreen;

  String get title1Family => typography.title1Family;
  TextStyle get title1 => typography.title1;
  String get title2Family => typography.title2Family;
  TextStyle get title2 => typography.title2;
  String get title3Family => typography.title3Family;
  TextStyle get title3 => typography.title3;
  String get subtitle1Family => typography.subtitle1Family;
  TextStyle get subtitle1 => typography.subtitle1;
  String get subtitle2Family => typography.subtitle2Family;
  TextStyle get subtitle2 => typography.subtitle2;
  String get bodyText1Family => typography.bodyText1Family;
  TextStyle get bodyText1 => typography.bodyText1;
  String get bodyText2Family => typography.bodyText2Family;
  TextStyle get bodyText2 => typography.bodyText2;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  late Color primaryColor = const Color(0xFF1A1C21);
  late Color secondaryColor = const Color(0xFFC3F483);
  late Color tertiaryColor = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFFFF5963);
  late Color primaryBackground = const Color(0xFFF1F4F8);
  late Color secondaryBackground = const Color(0x00FFFFFF);
  late Color primaryText = const Color(0xFF101213);
  late Color secondaryText = const Color(0xFF57636C);

  late Color white = Color(0xFFFCFDFF);
  late Color grey850 = Color(0xFF2F3135);
  late Color grey700 = Color(0xFF4B4D51);
  late Color grey500 = Color(0xFF7C7F84);
  late Color grey200 = Color(0xFFD7DADE);
  late Color grey100 = Color(0xFFEDEEF1);
  late Color figicoGreen = Color(0xFFCCFF8D);
  late Color black = Color(0xFF1A1C21);
  late Color darkenGreen = Color(0xFFC3F483);
  late Color bluegrey = Color(0xFFB4BED9);
  late Color figicoRed = Color(0xFFE95958);
  late Color alertGreen = Color(0xFF00DE16);
}

abstract class Typography {
  String get title1Family;
  TextStyle get title1;
  String get title2Family;
  TextStyle get title2;
  String get title3Family;
  TextStyle get title3;
  String get subtitle1Family;
  TextStyle get subtitle1;
  String get subtitle2Family;
  TextStyle get subtitle2;
  String get bodyText1Family;
  TextStyle get bodyText1;
  String get bodyText2Family;
  TextStyle get bodyText2;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get title1Family => 'Pretendard';
  TextStyle get title1 => TextStyle(
        fontFamily: 'Pretendard',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 24.0,
      );
  String get title2Family => 'Pretendard';
  TextStyle get title2 => TextStyle(
        fontFamily: 'Pretendard',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 20.0,
      );
  String get title3Family => 'Pretendard';
  TextStyle get title3 => TextStyle(
        fontFamily: 'Pretendard',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 18.0,
      );
  String get subtitle1Family => 'Pretendard';
  TextStyle get subtitle1 => TextStyle(
        fontFamily: 'Pretendard',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get subtitle2Family => 'Pretendard';
  TextStyle get subtitle2 => TextStyle(
        fontFamily: 'Pretendard',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get bodyText1Family => 'Pretendard';
  TextStyle get bodyText1 => TextStyle(
        fontFamily: 'Pretendard',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
  String get bodyText2Family => 'Pretendard';
  TextStyle get bodyText2 => TextStyle(
        fontFamily: 'Pretendard',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
}

class DarkModeTheme extends FlutterFlowTheme {
  late Color primaryColor = const Color(0xFF4B39EF);
  late Color secondaryColor = const Color(0xFF39D2C0);
  late Color tertiaryColor = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFFFF5963);
  late Color primaryBackground = const Color(0xFF1A1F24);
  late Color secondaryBackground = const Color(0xFF101213);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xFF95A1AC);

  late Color white = Color(0xFFFFFFFF);
  late Color grey850 = Color(0xFF22282F);
  late Color grey700 = Color(0xFFF90C36);
  late Color grey500 = Color(0xFF90EBF6);
  late Color grey200 = Color(0xFF8B56E1);
  late Color grey100 = Color(0xFFC65C1C);
  late Color figicoGreen = Color(0xFF7DDC26);
  late Color black = Color(0xFF04B1F0);
  late Color darkenGreen = Color(0xFF9EC5F5);
  late Color bluegrey = Color(0xFF57E63D);
  late Color figicoRed = Color(0xFF9920BB);
  late Color alertGreen = Color(0xFFCB7E80);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
