class CountryPicked {
  final String name;
  final String isoCode;
  final String iso3Code;
  final String phoneCode;
  final String placeholder;

  CountryPicked({
    this.isoCode,
    this.iso3Code,
    this.phoneCode,
    this.name,
    this.placeholder = "",
  });

  factory CountryPicked.fromMap(Map<String, String> map) => CountryPicked(
        name: map['name'],
        isoCode: map['isoCode'],
        iso3Code: map['iso3Code'],
        phoneCode: map['phoneCode'],
        placeholder: map['placeholder'],
      );
}
