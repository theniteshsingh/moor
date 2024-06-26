import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

import '../../analysis/errors/utils.dart';

void main() {
  group('json with new type inference', () {
    final engine = SqlEngine(EngineOptions(
      enabledExtensions: const [Json1Extension()],
      version: SqliteVersion.v3_45,
    ));
    // add user (name, phone) table
    final table = engine.schemaReader.read(
      engine.parse('CREATE TABLE user (name TEXT, phone TEXT)').rootNode
          as TableInducingStatement,
    );
    engine.registerTable(table);

    ResolveResult findResult(String expression) {
      final result = engine.analyze('SELECT $expression;');

      final select = result.root as SelectStatement;
      final column = select.resultSet.resolvedColumns!.single;

      return result.typeOf(column);
    }

    const resolvedString = ResolveResult(ResolvedType(type: BasicType.text));
    const resolvedBlob = ResolveResult(ResolvedType(type: BasicType.blob));

    test('create json', () {
      expect(findResult("json('{}')"), resolvedString);
      expect(findResult("json_array('foo', 'bar')"), resolvedString);
      expect(findResult("json_insert('{}')"), resolvedString);
      expect(findResult("json_replace('{}')"), resolvedString);
      expect(findResult("json_set('{}')"), resolvedString);
      expect(findResult('json_object()'), resolvedString);
      expect(findResult("json_patch('{}', '{}')"), resolvedString);
      expect(findResult("json_remove('{}', '{}')"), resolvedString);
      expect(findResult("json_quote('foo')"), resolvedString);
      expect(findResult('json_group_array()'), resolvedString);
      expect(findResult('json_group_object()'), resolvedString);
      expect(findResult('json_pretty(?)'), resolvedString);
    });

    test('create binary json', () {
      expect(findResult("jsonb('{}')"), resolvedBlob);
      expect(findResult("jsonb_array('foo', 'bar')"), resolvedBlob);
      expect(findResult("jsonb_insert('{}')"), resolvedBlob);
      expect(findResult("jsonb_replace('{}')"), resolvedBlob);
      expect(findResult("jsonb_set('{}')"), resolvedBlob);
      expect(findResult('jsonb_object()'), resolvedBlob);
      expect(findResult("jsonb_patch('{}', '{}')"), resolvedBlob);
      expect(findResult("jsonb_remove('{}', '{}')"), resolvedBlob);
      expect(findResult('jsonb_group_array()'), resolvedBlob);
      expect(findResult('jsonb_group_object()'), resolvedBlob);
    });

    test('json_type', () {
      expect(
        findResult("json_type('foo', 'bar')"),
        const ResolveResult(ResolvedType(type: BasicType.text, nullable: true)),
      );
    });

    test('json_valid', () {
      expect(
          findResult('json_valid()'), const ResolveResult(ResolvedType.bool()));
    });

    test('json_extract', () {
      expect(findResult('json_extract()'), const ResolveResult.unknown());
    });

    test('json_array_length', () {
      expect(
        findResult('json_array_length()'),
        const ResolveResult(ResolvedType(type: BasicType.int)),
      );
    });

    test('can use table-valued functions', () {
      final result = engine.analyze('''
SELECT DISTINCT user.name
  FROM user, json_each(user.phone)
 WHERE json_each.value LIKE '704-%';
    ''');

      expect(result.errors, isEmpty);
    });
  });

  test('does not allow jsonb functions before 3.45', () {
    final engine = SqlEngine(EngineOptions(version: SqliteVersion.v3_44));
    final result = engine.analyze('SELECT jsonb(?);');
    expect(result.errors, [
      analysisErrorWith(
        lexeme: 'jsonb',
        type: AnalysisErrorType.unknownFunction,
      )
    ]);
  });

  test('does not allow json_pretty before 3.46', () {
    final engine = SqlEngine(EngineOptions(version: SqliteVersion.v3_45));
    final result = engine.analyze('SELECT json_pretty(?);');
    expect(result.errors, [
      analysisErrorWith(
        lexeme: 'json_pretty',
        type: AnalysisErrorType.notSupportedInDesiredVersion,
      )
    ]);
  });
}
