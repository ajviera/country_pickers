import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';

/// Returns true when a country should be included in lists / dialogs
/// offered to the user.
typedef bool ItemFilter(CountryPicked country);

typedef Widget ItemBuilder(CountryPicked country);

/// Simple closure which always returns true.
bool acceptAllCountries(_) => true;
