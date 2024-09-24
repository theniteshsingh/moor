// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<Note> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final int id;
  final String content;
  const Note({required this.id, required this.content});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      content: Value(content),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
    };
  }

  Note copyWith({int? id, String? content}) => Note(
        id: id ?? this.id,
        content: content ?? this.content,
      );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note && other.id == this.id && other.content == this.content);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<String> content;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    required String content,
  }) : content = Value(content);
  static Insertable<Note> custom({
    Expression<int>? id,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
    });
  }

  NotesCompanion copyWith({Value<int>? id, Value<String>? content}) {
    return NotesCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyEncryptedDatabase extends GeneratedDatabase {
  _$MyEncryptedDatabase(QueryExecutor e) : super(e);
  $MyEncryptedDatabaseManager get managers => $MyEncryptedDatabaseManager(this);
  late final $NotesTable notes = $NotesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notes];
}

typedef $$NotesTableCreateCompanionBuilder = NotesCompanion Function({
  Value<int> id,
  required String content,
});
typedef $$NotesTableUpdateCompanionBuilder = NotesCompanion Function({
  Value<int> id,
  Value<String> content,
});

class $$NotesTableFilterComposer extends $$NotesTableComposer {
  $$NotesTableFilterComposer($$NotesTableComposer c)
      : super(
            $db: c.$db,
            $table: c.$table,
            joinBuilder: c.$joinBuilder,
            $addJoinBuilderToRootComposer: c.$addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer:
                c.$removeJoinBuilderFromRootComposer);
  ColumnFilters<int> get id => ColumnFilters(_id);
  ColumnFilters<String> get content => ColumnFilters(_content);
}

class $$NotesTableOrderingComposer extends $$NotesTableComposer {
  $$NotesTableOrderingComposer($$NotesTableComposer c)
      : super(
            $db: c.$db,
            $table: c.$table,
            joinBuilder: c.$joinBuilder,
            $addJoinBuilderToRootComposer: c.$addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer:
                c.$removeJoinBuilderFromRootComposer);
  ColumnOrderings<int> get id => ColumnOrderings(_id);
  ColumnOrderings<String> get content => ColumnOrderings(_content);
}

class $$NotesTableAnnotationComposer extends $$NotesTableComposer {
  $$NotesTableAnnotationComposer($$NotesTableComposer c)
      : super(
            $db: c.$db,
            $table: c.$table,
            joinBuilder: c.$joinBuilder,
            $addJoinBuilderToRootComposer: c.$addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer:
                c.$removeJoinBuilderFromRootComposer);
  GeneratedColumn<int> get id => _id;
  GeneratedColumn<String> get content => _content;
}

class $$NotesTableComposer
    extends Composer<_$MyEncryptedDatabase, $NotesTable> {
  $$NotesTableComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get _id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get _content =>
      $composableBuilder(column: $table.content, builder: (column) => column);
}

class $$NotesTableTableManager extends RootTableManager<
    _$MyEncryptedDatabase,
    $NotesTable,
    Note,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableAnnotationComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder,
    (Note, BaseReferences<_$MyEncryptedDatabase, $NotesTable, Note>),
    Note,
    PrefetchHooks Function()> {
  $$NotesTableTableManager(_$MyEncryptedDatabase db, $NotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$NotesTableFilterComposer(
              $$NotesTableComposer($db: db, $table: table)),
          createOrderingComposer: () => $$NotesTableOrderingComposer(
              $$NotesTableComposer($db: db, $table: table)),
          createAnnotationComposer: () => $$NotesTableAnnotationComposer(
              $$NotesTableComposer($db: db, $table: table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> content = const Value.absent(),
          }) =>
              NotesCompanion(
            id: id,
            content: content,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String content,
          }) =>
              NotesCompanion.insert(
            id: id,
            content: content,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotesTableProcessedTableManager = ProcessedTableManager<
    _$MyEncryptedDatabase,
    $NotesTable,
    Note,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableAnnotationComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder,
    (Note, BaseReferences<_$MyEncryptedDatabase, $NotesTable, Note>),
    Note,
    PrefetchHooks Function()>;

class $MyEncryptedDatabaseManager {
  final _$MyEncryptedDatabase _db;
  $MyEncryptedDatabaseManager(this._db);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
}
