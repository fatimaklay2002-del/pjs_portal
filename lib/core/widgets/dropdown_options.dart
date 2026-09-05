/// Sorts a dropdown's option labels alphabetically (Arabic collation via
/// the default Dart string comparator). Use at each CustomDropdownField's
/// `items:` — it only reorders the list, nothing else about the UI changes.
List<String> sortedOptions(List<String> items) => List.of(items)..sort();
