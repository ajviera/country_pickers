import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/widgets.dart';

class CountryPickerUtils {
  static CountryPicked getCountryByIsoCode(String isoCode) {
    try {
      return countryList.firstWhere(
        (country) => country.isoCode.toLowerCase() == isoCode.toLowerCase(),
      );
    } catch (error) {
      throw Exception("The initialValue provided is not a supported iso code!");
    }
  }

  static String getFlagImageAssetPath(String isoCode) {
    return "assets/${isoCode.toLowerCase()}.png";
  }

  static Widget getDefaultFlagImage(CountryPicked country) {
    return Image.asset(
      CountryPickerUtils.getFlagImageAssetPath(country.isoCode),
      height: 20.0,
      width: 30.0,
      fit: BoxFit.fill,
      package: "country_pickers",
    );
  }

  static CountryPicked getCountryByPhoneCode(String phoneCode) {
    try {
      return countryList.firstWhere(
        (country) => country.phoneCode.toLowerCase() == phoneCode.toLowerCase(),
      );
    } catch (error) {
      throw Exception(
          "The initialValue provided is not a supported phone code!");
    }
  }
}
