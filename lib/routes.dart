import 'package:a2/%D8%A7%D9%84%D8%B5%D9%81%D8%AD%D8%A7%D8%AA/currency_selection.dart';
import 'package:a2/%D8%A7%D9%84%D8%B5%D9%81%D8%AD%D8%A7%D8%AA/home.dart';
import 'package:a2/%D8%A7%D9%84%D8%B5%D9%81%D8%AD%D8%A7%D8%AA/settinge.dart';
import 'package:a2/core/constant/routes.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoute.home: (context) => home(),
  AppRoute.settinge: (context) => Settinge(),
  AppRoute.CurrencySelection: (context) => CurrencySelection(),
};
