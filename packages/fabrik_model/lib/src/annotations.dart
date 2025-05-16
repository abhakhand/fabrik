library fabrik_model.annotations;

class FabrikModel {
  final String? emptyConstructorName;

  const FabrikModel({this.emptyConstructorName});
}

class Field {
  final Object? defaultValue;
  final Function? fromJson;
  final Function? toJson;
  final bool includeFromJson;
  final bool includeToJson;

  const Field({
    this.defaultValue,
    this.fromJson,
    this.toJson,
    this.includeFromJson = true,
    this.includeToJson = true,
  });
}
