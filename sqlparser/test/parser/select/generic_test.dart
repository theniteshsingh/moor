import 'package:sqlparser/src/ast/ast.dart';
import 'package:test/scaffolding.dart';
import '../utils.dart';

final Map<String, AstNode> testCases = {
  'SELECT tbl.*, *, 1 as name WHERE 1 ORDER BY name ASC LIMIT 3 OFFSET 5':
      SelectStatement(
    columns: [
      StarResultColumn('tbl'),
      StarResultColumn(null),
      ExpressionResultColumn(
        expression: NumericLiteral(1),
        as: 'name',
      ),
    ],
    where: NumericLiteral(1),
    orderBy: OrderBy(terms: [
      OrderingTerm(
        expression: Reference(columnName: 'name'),
        orderingMode: OrderingMode.ascending,
      ),
    ]),
    limit: Limit(
      count: NumericLiteral(3),
      offsetSeparator: token(TokenType.offset),
      offset: NumericLiteral(5),
    ),
  ),
  'SELECT tbl.*, (SELECT * FROM table2) FROM tbl': SelectStatement(
    columns: [
      StarResultColumn('tbl'),
      ExpressionResultColumn(
        expression: SubQuery(
          select: SelectStatement(
            columns: [StarResultColumn(null)],
            from: TableReference('table2'),
          ),
        ),
      ),
    ],
    from: TableReference('tbl'),
  ),
  'SELECT * FROM tbl WHERE id IN ()': SelectStatement(
    columns: [StarResultColumn(null)],
    from: TableReference('tbl'),
    where: InExpression(
      left: Reference(columnName: 'id'),
      inside: Tuple(expressions: []),
    ),
  ),
  'SELECT rowid FROM tbl': SelectStatement(
    columns: [
      ExpressionResultColumn(expression: Reference(columnName: 'rowid')),
    ],
    from: TableReference('tbl'),
  ),
};

void main() {
  testAll(testCases);

  test('supports mapped by columns', () {
    testStatement(
      'SELECT 1 MAPPED BY `foo` AS r',
      SelectStatement(columns: [
        ExpressionResultColumn(
          expression: NumericLiteral(1),
          mappedBy: MappedBy(null, inlineDart('foo')),
          as: 'r',
        ),
      ]),
      driftMode: true,
    );
  });
}
