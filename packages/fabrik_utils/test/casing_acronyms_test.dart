import 'package:fabrik_utils/fabrik_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('acronyms group as a single word', () {
    test('leading acronym followed by words', () {
      expect('XMLHttpRequest'.snakeCase, 'xml_http_request');
      expect('XMLHttpRequest'.camelCase, 'xmlHttpRequest');
      expect('XMLHttpRequest'.kebabCase, 'xml-http-request');
    });

    test('acronym at the end of a word', () {
      expect('parseJSON'.snakeCase, 'parse_json');
      expect('parseJSON'.camelCase, 'parseJson');
    });

    test('acronym in the middle', () {
      expect('myXMLParser'.snakeCase, 'my_xml_parser');
      expect('myXMLParser'.camelCase, 'myXmlParser');
    });

    test('two-letter acronyms', () {
      expect('IOString'.snakeCase, 'io_string');
      expect('APIKey'.snakeCase, 'api_key');
    });

    test('long acronym followed by a capitalised word', () {
      expect('HTTPSConnection'.snakeCase, 'https_connection');
    });

    test('acronym terminated by a delimiter rather than a lowercase letter', () {
      expect('iOS device'.snakeCase, 'i_os_device');
      expect('tvOS app'.snakeCase, 'tv_os_app');
    });

    test('trailing acronym at end of input', () {
      expect('macOS'.snakeCase, 'mac_os');
      expect('user2FA'.snakeCase, 'user2_fa');
    });
  });

  group('existing casing behaviour is preserved', () {
    test('plain camelCase splitting', () {
      expect('HelloWorld'.snakeCase, 'hello_world');
      expect('helloWorld'.snakeCase, 'hello_world');
    });

    test('delimiter splitting', () {
      expect('hello world'.snakeCase, 'hello_world');
      expect('hello_world'.camelCase, 'helloWorld');
      expect('foo-bar_baz.qux'.snakeCase, 'foo_bar_baz_qux');
    });

    test('all-caps input stays one word', () {
      expect('ALLCAPS'.snakeCase, 'allcaps');
      expect('ALLCAPS'.pascalCase, 'Allcaps');
    });

    test('single characters', () {
      expect('a'.snakeCase, 'a');
      expect('a'.pascalCase, 'A');
    });

    test('empty and whitespace-only input', () {
      expect(''.snakeCase, '');
      expect('   '.snakeCase, '');
      expect(''.camelCase, '');
    });
  });

  group('the CLI filename case', () {
    // fabrik generate feature <Name> derives file names from snakeCase, so a
    // feature named with an acronym must not explode into single letters.
    test('an acronym feature name yields a readable filename', () {
      expect('XMLParser'.snakeCase, 'xml_parser');
      expect('APIClient'.snakeCase, 'api_client');
      expect('HTTPService'.snakeCase, 'http_service');
    });
  });
}
