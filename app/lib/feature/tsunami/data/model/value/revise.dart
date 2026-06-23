import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

enum Revise {
  addition,
  update,
}

extension ReviseApiExt on api.Revise {
  Revise toDomain() => switch (this) {
    api.Revise.addition => Revise.addition,
    api.Revise.update => Revise.update,
  };
}
