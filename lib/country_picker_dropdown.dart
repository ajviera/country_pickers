import 'package:country_pickers/country.dart';
import 'package:country_pickers/countries.dart';
import 'package:country_pickers/utils/typedefs.dart';
import 'package:flutter/material.dart';
import 'utils/utils.dart';

///Provides a customizable [DropdownButton] for all countries
class CountryPickerDropdown extends StatefulWidget {
  CountryPickerDropdown({
    this.itemFilter,
    this.itemBuilder,
    this.selectedFilteredDialogCountry,
    this.onValuePicked,
  });

  /// Filters the available country list
  final ItemFilter itemFilter;

  ///This function will be called to build the child of DropdownMenuItem
  ///If it is not provided, default one will be used which displays
  ///flag image, isoCode and phoneCode in a row.
  ///Check _buildDefaultMenuItem method for details.
  final ItemBuilder itemBuilder;

  ///It should be one of the ISO ALPHA-2 Code that is provided
  ///in countryList map of countries.dart file.
  final CountryPicked selectedFilteredDialogCountry;

  ///This function will be called whenever a Country item is selected.
  final ValueChanged<CountryPicked> onValuePicked;

  @override
  _CountryPickerDropdownState createState() => _CountryPickerDropdownState();
}

class _CountryPickerDropdownState extends State<CountryPickerDropdown> {
  List<CountryPicked> _countries;
  CountryPicked _selectedCountry;

  @override
  void initState() {
    _countries =
        countryList.where(widget.itemFilter ?? acceptAllCountries).toList();
    _countries.sort((a, b) => a.name.compareTo(b.name));

    _selectedCountry = widget.selectedFilteredDialogCountry ??
        CountryPickerUtils.getCountryByIsoCode('US');

    super.initState();
  }

  @override
  void didUpdateWidget(CountryPickerDropdown oldWidget) {
    if (widget.selectedFilteredDialogCountry?.isoCode !=
        oldWidget.selectedFilteredDialogCountry?.isoCode) {
      setState(() {
        _selectedCountry = widget.selectedFilteredDialogCountry ??
            CountryPickerUtils.getCountryByIsoCode('US');
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<CountryPicked>> items = _countries
        .map((country) => DropdownMenuItem<CountryPicked>(
            value: country,
            child: widget.itemBuilder != null
                ? widget.itemBuilder(country)
                : _buildDefaultMenuItem(country)))
        .toList();

    return DropdownButtonHideUnderline(
      child: DropdownButton<CountryPicked>(
        isDense: true,
        onChanged: (value) {
          setState(() {
            _selectedCountry = value;
            widget.onValuePicked(value);
          });
        },
        items: items,
        value: _selectedCountry,
      ),
    );
  }

  Widget _buildDefaultMenuItem(CountryPicked country) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        Flexible(
          child: Text(
            country.name,
            style: TextStyle(fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          "+" + country.phoneCode,
          style: TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }
}
