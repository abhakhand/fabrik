import 'package:fabrik_forms/src/validators/base.dart';

/// A validator that checks whether a string is a valid URL.
///
/// Accepts `http://` and `https://` URLs by default. Use [requireHttps] to
/// restrict to secure URLs only.
class UrlValidator extends FabrikValidator<String> {
  /// Creates a [UrlValidator].
  ///
  /// - [isRequired]: whether the field must be non-empty. Defaults to true.
  /// - [requireHttps]: when true, only `https://` URLs are accepted.
  /// - [requiredMessage]: error if field is required but empty.
  /// - [invalidMessage]: error if the URL format is invalid.
  /// - [httpsMessage]: error if URL is not HTTPS when [requireHttps] is true.
  const UrlValidator({
    this.isRequired = true,
    this.requireHttps = false,
    this.requiredMessage = 'URL is required',
    this.invalidMessage = 'Invalid URL',
    this.httpsMessage = 'URL must use HTTPS',
  });

  /// Whether to require the field to be non-empty.
  final bool isRequired;

  /// Whether to require the URL to use the HTTPS scheme.
  final bool requireHttps;

  /// Message shown when required field is left empty.
  final String requiredMessage;

  /// Message shown when the URL format is invalid.
  final String invalidMessage;

  /// Message shown when [requireHttps] is true but the URL uses HTTP.
  final String httpsMessage;

  static final _regex = RegExp(
    r'^https?:\/\/(www\.)?'
    r'[-a-zA-Z0-9@:%._+~#=]{1,256}'
    r'\.[a-zA-Z0-9()]{1,6}'
    r'\b([-a-zA-Z0-9()@:%_+.~#?&/=]*)$',
  );

  @override
  String? call(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return isRequired ? requiredMessage : null;
    if (!_regex.hasMatch(trimmed)) return invalidMessage;
    if (requireHttps && !trimmed.startsWith('https://')) return httpsMessage;
    return null;
  }
}
