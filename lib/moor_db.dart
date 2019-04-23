import 'package:moor_flutter/moor_flutter.dart';

// assuming that your file is called filename.dart. This will give an error at first,
// but it's needed for moor to know about the generated code
//part 'moor_db.g.dart';

@DataClassName("Events")
class Events extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 2, max: 20)();

  TextColumn get money => text().nullable()();
}

@DataClassName("Wallet")
class Wallet extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get money => text().nullable()();
}

@UseMoor(tables: [Events, Wallet])
class MyDatabase {
//  MyDatabase()
//      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

//  // you should bump this number whenever you change or add a table definition.
//  @override
//  int get schemaVersion => 1;
//
//  Future moveImportantTasksIntoCategory(Events target) {
//    // use update(...).write when you have a custom where clause and want to update
//    // only the columns that you specify (here, only "category" will be updated, the
//    // title and description of the rows affected will be left unchanged).
//    // Notice that you can't set fields back to null with this method.
//    return (update(Events)..where((t) => t.title.like(target.title))).write(
//      TodoEntry(category: target.id),
//    );
//  }
//
//  Future update(Wallet entry) {
//    return update(Wallet).replace(entry);
//  }
//
//  Future<Wallet> get wallet => select(wallet).get();
//
//  // watches all Events. The stream will automatically
//  // emit new items whenever the underlying data changes.
//  Stream<List<EventsEntry>> watchEntriesInCategory(Category c) {
//    return (select(Events)
//          ..orderBy([(entry) => OrderingTerm(expression: entry.title)]))
//        .watch();
//  }
}
