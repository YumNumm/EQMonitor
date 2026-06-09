const _emptyEewAreaFilter = <Object>['==', '1', '2'];

List<Object> buildEewAreaCodeFilter(List<String> codes) {
  if (codes.isEmpty) {
    return _emptyEewAreaFilter;
  }
  return <Object>[
    'in',
    ['get', 'code'],
    ['literal', codes],
  ];
}
