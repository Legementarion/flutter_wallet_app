import 'package:moor_flutter/moor_flutter.dart';

// assuming that your file is called filename.dart. This will give an error at first,
// but it's needed for moor to know about the generated code
part 'moor_db.g.dart';

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 2, max: 20)();

  TextColumn get money => text().nullable()();

  DateTimeColumn get date => dateTime()();
}

@UseMoor(tables: [Events])
class MyDatabase extends _$MyDatabase {
  MyDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  // you should bump this number whenever you change or add a table definition.
  @override
  int get schemaVersion => 1;

  void updateEvent(Event entry) {
    var findevent = select(events)
      ..where((t) => t.title.like(events.title.toString()));

    findevent.get().then((data) {
      if (data.isEmpty) {
        into(events).insert(entry);
      } else {
        update(events).replace(entry);
      }
    });
  }

//   watches all Events. The stream will automatically
//   emit new items whenever the underlying data changes.
  Stream<List<Event>> watchEventEntries() {
    return (select(events)
          ..orderBy([(entry) => OrderingTerm(expression: entry.date)]))
        .watch();
  }
}
