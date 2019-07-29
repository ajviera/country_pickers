import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/typedefs.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';

class CountryPickerPopupMenu extends StatefulWidget {
  CountryPickerPopupMenu({
    @required this.onValuePicked,
    this.itemFilter,
    this.selectedFilteredDialogCountry,
  });

  /// Filters the available country list
  final ItemFilter itemFilter;
  final CountryPicked selectedFilteredDialogCountry;
  final Function onValuePicked;
  @override
  _CountryPickerPopupMenuState createState() => _CountryPickerPopupMenuState();
}

class _CountryPickerPopupMenuState extends State<CountryPickerPopupMenu> {
  List<CountryPicked> _countries;

  List<CountryPicked> _filteredCountries;
  CountryPicked _selectedFilteredDialogCountry;

  @override
  void initState() {
    _countries =
        countryList.where(widget.itemFilter ?? acceptAllCountries).toList();
    _countries.sort((a, b) => a.name.compareTo(b.name));
    _filteredCountries = _countries;

    _selectedFilteredDialogCountry = widget.selectedFilteredDialogCountry ??
        CountryPickerUtils.getCountryByIsoCode('US');

    super.initState();
  }

  @override
  void didUpdateWidget(CountryPickerPopupMenu oldWidget) {
    if (widget.selectedFilteredDialogCountry?.isoCode !=
        oldWidget.selectedFilteredDialogCountry?.isoCode) {
      setState(() {
        _selectedFilteredDialogCountry = widget.selectedFilteredDialogCountry ??
            CountryPickerUtils.getCountryByIsoCode('US');
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CountryPicked>(
      padding: EdgeInsets.symmetric(vertical: 100),
      offset: Offset(0, 500),
      onSelected: _select,
      child: CountryPickerUtils.getDefaultFlagImage(
        _selectedFilteredDialogCountry,
      ),
      itemBuilder: (BuildContext context) => _groupOptions(),
    );
  }

  List<PopupMenuEntry<CountryPicked>> _groupOptions() {
    List<PopupMenuEntry<CountryPicked>> widgets = [];

    widgets.add(PopupMenuDivider(height: 25));

    _filteredCountries.forEach((country) {
      widgets.add(
        PopupMenuItem<CountryPicked>(
          value: country,
          child: Row(
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
          ),
        ),
      );
    });

    return widgets;
  }

  void _select(CountryPicked choice) {
    setState(() => _selectedFilteredDialogCountry = choice);
    widget.onValuePicked(choice);
  }
}
