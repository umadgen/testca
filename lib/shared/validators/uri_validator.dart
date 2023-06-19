import 'package:reactive_forms/reactive_forms.dart';

class UriValidator extends Validator<dynamic> {
  const UriValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    return control.isNotNull &&
            control.value is String &&
            Uri.parse(control.value).isAbsolute == true
        ? null
        : {'isUrl': true};
  }
}
