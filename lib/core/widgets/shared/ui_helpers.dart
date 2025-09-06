enum FieldType {
  eMail("Email"),
  password("Password"),
  name("Name"),
  phoneNumber("Mobile Number"),
  pinCode("PIN code");

  final String description;
  const FieldType(this.description);
}

extension FieldTypeExtension on FieldType {
  String get name {
    switch (this) {
      case FieldType.eMail:
        return "Email";
      case FieldType.password:
        return "Password";
      case FieldType.name:
        return "Name";
      case FieldType.phoneNumber:
        return "Phone Number";
      case FieldType.pinCode:
        return "PIN code";
    }
  }
}

typedef WidgetDataExporter<T extends Object> = void Function(T object)?;
typedef FlexibleProcessor<T extends Object, R extends Object> =
    R Function(T object);
typedef WidgetDataExporterNullable<T extends Object> =
    void Function(T? object)?;
typedef WidgetDataExporterMultiVariable<T extends Object, R extends Object> =
    void Function(T object, R object2)?;
