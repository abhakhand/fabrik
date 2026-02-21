import 'package:fabrik_utils/fabrik_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NullableStringX', () {
    test('isNullOrBlank is true for null', () {
      const String? s = null;
      expect(s.isNullOrBlank, isTrue);
    });

    test('isNullOrBlank is true for empty string', () {
      expect(''.isNullOrBlank, isTrue);
    });

    test('isNullOrBlank is true for whitespace-only string', () {
      expect('   '.isNullOrBlank, isTrue);
      expect('\t\n'.isNullOrBlank, isTrue);
    });

    test('isNullOrBlank is false for non-empty string', () {
      expect('hello'.isNullOrBlank, isFalse);
      expect(' hi '.isNullOrBlank, isFalse);
    });
  });

  group('StringX.capitalizeFirst', () {
    test('capitalizes first letter and lowercases rest', () {
      expect('hello'.capitalizeFirst, 'Hello');
      expect('hello WORLD'.capitalizeFirst, 'Hello world');
    });

    test('handles single character', () {
      expect('a'.capitalizeFirst, 'A');
    });

    test('handles empty string', () {
      expect(''.capitalizeFirst, '');
    });
  });

  group('FabrikCasing / StringX casing', () {
    group('titleCase', () {
      test('converts space-separated words', () {
        expect('hello world'.titleCase, 'Hello World');
      });

      test('converts camelCase input', () {
        expect('helloWorld'.titleCase, 'Hello World');
      });

      test('converts snake_case input', () {
        expect('hello_world'.titleCase, 'Hello World');
      });

      test('converts kebab-case input', () {
        expect('hello-world'.titleCase, 'Hello World');
      });

      test('handles empty string', () {
        expect(''.titleCase, '');
      });
    });

    group('camelCase', () {
      test('converts space-separated words', () {
        expect('hello world'.camelCase, 'helloWorld');
      });

      test('converts PascalCase input', () {
        expect('HelloWorld'.camelCase, 'helloWorld');
      });

      test('converts snake_case input', () {
        expect('hello_world_test'.camelCase, 'helloWorldTest');
      });

      test('handles single word', () {
        expect('hello'.camelCase, 'hello');
      });
    });

    group('pascalCase', () {
      test('converts space-separated words', () {
        expect('hello world'.pascalCase, 'HelloWorld');
      });

      test('converts camelCase input', () {
        expect('helloWorld'.pascalCase, 'HelloWorld');
      });

      test('converts snake_case input', () {
        expect('hello_world'.pascalCase, 'HelloWorld');
      });
    });

    group('snakeCase', () {
      test('converts space-separated words', () {
        expect('hello world'.snakeCase, 'hello_world');
      });

      test('converts camelCase input', () {
        expect('helloWorld'.snakeCase, 'hello_world');
      });

      test('converts PascalCase input', () {
        expect('HelloWorld'.snakeCase, 'hello_world');
      });
    });

    group('kebabCase', () {
      test('converts space-separated words', () {
        expect('hello world'.kebabCase, 'hello-world');
      });

      test('converts camelCase input', () {
        expect('helloWorld'.kebabCase, 'hello-world');
      });
    });

    group('constantCase', () {
      test('converts space-separated words', () {
        expect('hello world'.constantCase, 'HELLO_WORLD');
      });

      test('converts camelCase input', () {
        expect('helloWorld'.constantCase, 'HELLO_WORLD');
      });
    });

    group('sentenceCase', () {
      test('capitalizes first word only', () {
        expect('hello world test'.sentenceCase, 'Hello world test');
      });

      test('converts camelCase input', () {
        expect('helloWorld'.sentenceCase, 'Hello world');
      });
    });

    group('dottedCase', () {
      test('converts space-separated words', () {
        expect('hello world'.dottedCase, 'hello.world');
      });
    });

    group('pathCase', () {
      test('converts space-separated words', () {
        expect('hello world'.pathCase, 'hello/world');
      });
    });

    group('headerCase', () {
      test('converts space-separated words', () {
        expect('hello world'.headerCase, 'Hello-World');
      });
    });

    group('edge cases', () {
      test('handles all-delimiter string', () {
        expect('___'.snakeCase, '');
        expect('---'.kebabCase, '');
      });

      test('handles leading and trailing delimiters', () {
        expect('_hello_world_'.snakeCase, 'hello_world');
      });

      test('handles consecutive delimiters', () {
        expect('hello__world'.snakeCase, 'hello_world');
        expect('hello--world'.camelCase, 'helloWorld');
      });

      test('handles ALL_CAPS input as single word', () {
        expect('HELLO'.snakeCase, 'hello');
        expect('HELLO_WORLD'.camelCase, 'helloWorld');
      });

      test('handles single-word input', () {
        expect('hello'.pascalCase, 'Hello');
        expect('hello'.constantCase, 'HELLO');
      });
    });
  });
}
