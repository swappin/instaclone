class Filter {
  final String _filterName;
  final List<int> _filterBytes;
  bool toggleFilter;

  Filter(this._filterName, this._filterBytes, this.toggleFilter);

  String get filterName => _filterName;

  List<int> get filterBytes => _filterBytes;

  set toggledFilter(value) => toggleFilter = value;
}
