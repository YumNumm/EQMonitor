class EewAreaFilterBuilder {
  const EewAreaFilterBuilder();

  static const _emptyFilter = <Object>['==', '1', '2'];

  List<Object> build(List<String> codes) {
    if (codes.isEmpty) {
      return _emptyFilter;
    }
    return <Object>[
      'in',
      ['get', 'code'],
      ['literal', codes],
    ];
  }
}
