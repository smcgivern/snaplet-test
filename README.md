# Snaplet test

Requires Postgres on the path. Use `asdf install` and `npm install` to set up Node and Snaplet.

## Usage

* Run `./setup` to create a database and run Postgres. This will also edit `config.json` to point to your local directory.
* Run `./start-postgres` somewhere, and then `./inspect` somewhere else.
* Run `./teardown` to destroy the test DB.

## Observed behaviour

The whole of each table is copied, even though subsetting should allow a much smaller set of rows to be copied:

```
$ ./inspect

> snapshot-capture
> rm -r dump ; SNAPLET_SOURCE_DATABASE_URL=$(node database-url.js) DEBUG='snaplet:capture*' snaplet snapshot capture dump



⚠️ No copycat hash key has been set, a publicly visible default will be used. To avoid this, you can either:
* Use copycat.setHashKey() in your transform config
* Provide a hash key as an env var, e.g: COPYCAT_SECRET='!7bo-TgzqivND*a_' snaplet ss capture

You can read more about copycat hash keys here: https://github.com/snaplet/copycat#pii

2023-08-01T13:18:15.421Z snaplet:capture 2023-08-01T13:18:15.421Z snaplet:capture Event "progress": { step: 'schemas', completed: 0 }
2023-08-01T13:18:15.422Z snaplet:capture:pg_dump 2023-08-01T13:18:15.422Z snaplet:capture:pg_dump schemas configuration {}
2023-08-01T13:18:15.422Z snaplet:capture:pg_dump 2023-08-01T13:18:15.422Z snaplet:capture:pg_dump Running: "pg_dump --schema-only --no-password --no-privileges --no-owner --verbose postgresql://postgres@localhost:5432/snaplet-test?host=%2FUsers%2Fsmcgivern%2FCode%2Fsnaplet-test%2Fsock"
2023-08-01T13:18:15.432Z snaplet:capture 2023-08-01T13:18:15.432Z snaplet:capture Event "progress": {
  step: 'schemas',
  completed: 5,
  metadata: { message: 'reading extensions...' }
}
2023-08-01T13:18:15.432Z snaplet:capture 2023-08-01T13:18:15.432Z snaplet:capture Event "progress": {
  step: 'schemas',
  completed: 10,
  metadata: { message: 'identifying extension members...' }
}
2023-08-01T13:18:15.432Z snaplet:capture 2023-08-01T13:18:15.432Z snaplet:capture Event "progress": {
  step: 'schemas',
  completed: 15,
  metadata: { message: 'reading schemas...' }
}
2023-08-01T13:18:15.433Z snaplet:capture 2023-08-01T13:18:15.433Z snaplet:capture Event "progress": {
  step: 'schemas',
  completed: 20,
  metadata: { message: 'reading user-defined tables...' }
}
2023-08-01T13:18:15.452Z snaplet:capture 2023-08-01T13:18:15.452Z snaplet:capture Event "progress": {
  step: 'schemas',
  completed: 30,
  metadata: { message: 'reading default privileges...' }
}
2023-08-01T13:18:15.452Z snaplet:capture 2023-08-01T13:18:15.452Z snaplet:capture Event "progress": {
  step: 'schemas',
  completed: 35,
  metadata: { message: 'reading user-defined collations...' }
}
2023-08-01T13:18:15.454Z snaplet:capture 2023-08-01T13:18:15.454Z snaplet:capture Event "progress": {
  step: 'schemas',
  completed: 40,
  metadata: { message: 'reading user-defined conversions...' }
}
2023-08-01T13:18:15.454Z snaplet:capture 2023-08-01T13:18:15.454Z snaplet:capture Event "progress": {
  step: 'schemas',
  completed: 45,
  metadata: { message: 'reading type casts...' }
}
2023-08-01T13:18:15.454Z snaplet:capture 2023-08-01T13:18:15.454Z snaplet:capture Event "progress": {
  step: 'schemas',
  completed: 50,
  metadata: { message: 'reading transforms...' }
}
2023-08-01T13:18:15.455Z snaplet:capture 2023-08-01T13:18:15.455Z snaplet:capture Event "progress": {
  step: 'schemas',
  completed: 60,
  metadata: { message: 'reading event triggers...' }
}
2023-08-01T13:18:15.455Z snaplet:capture 2023-08-01T13:18:15.455Z snaplet:capture Event "progress": {
  step: 'schemas',
  completed: 65,
  metadata: { message: 'finding extension tables...' }
}
2023-08-01T13:18:15.455Z snaplet:capture 2023-08-01T13:18:15.455Z snaplet:capture Event "progress": {
  step: 'schemas',
  completed: 70,
  metadata: { message: 'reading table specific info...' }
}
2023-08-01T13:18:15.458Z snaplet:capture 2023-08-01T13:18:15.458Z snaplet:capture Event "progress": {
  step: 'schemas',
  completed: 90,
  metadata: { message: 'reading rewrite rules...' }
}
2023-08-01T13:18:15.459Z snaplet:capture 2023-08-01T13:18:15.459Z snaplet:capture Event "progress": {
  step: 'schemas',
  completed: 95,
  metadata: { message: 'reading dependency data...' }
}
Saving database schema to: dump/schemas.sql
2023-08-01T13:18:15.467Z snaplet:capture 2023-08-01T13:18:15.467Z snaplet:capture Event "progress": { step: 'schemas', completed: 100 }
2023-08-01T13:18:15.467Z snaplet:capture 2023-08-01T13:18:15.467Z snaplet:capture Event "progress": { step: 'subset', completed: 0 }
Subset database using config file...
1. Subsetting 100% of a.
2023-08-01T13:18:15.481Z snaplet:capture:subset 2023-08-01T13:18:15.481Z snaplet:capture:subset populateSubsetOfTable - subsetQuery SELECT "id" FROM "public"."a" TABLESAMPLE BERNOULLI (100) REPEATABLE(4856147686225579) WHERE id = 1234 LIMIT 1000000
2. Traversing parents of a:
3. Traversing other tables:
Traversing public.b...
2023-08-01T13:18:15.549Z snaplet:capture:subset 2023-08-01T13:18:15.549Z snaplet:capture:subset traverseSortedTables - query:  SELECT "b"."id" , "b"."a_id" FROM "public"."b" JOIN "public"."a" ON "public"."b"."a_id" = "public"."a"."id" WHERE "public"."a"."id" IN (...)
Traversing public.c...
2023-08-01T13:18:15.565Z snaplet:capture:subset 2023-08-01T13:18:15.565Z snaplet:capture:subset traverseSortedTables - query:  SELECT "c"."a_id" , "c"."b_id" , "c"."id" FROM "public"."c" JOIN "public"."a" ON "public"."c"."a_id" = "public"."a"."id" WHERE "public"."a"."id" IN (...)
2023-08-01T13:18:16.243Z snaplet:capture:subset 2023-08-01T13:18:16.243Z snaplet:capture:subset traverseSortedTables - query:  SELECT "c"."a_id" , "c"."b_id" , "c"."id" FROM "public"."c" JOIN "public"."b" ON "public"."c"."b_id" = "public"."b"."id" WHERE "public"."b"."id" IN (...)
4. Reduce traversal:
5. Traverse tables with empty parents:
2023-08-01T13:18:16.839Z snaplet:capture 2023-08-01T13:18:16.839Z snaplet:capture Event "subsetting": {
  'public.a': {
    schema_name: 'public',
    table_name: 'a',
    parents: [],
    children: [ [Object], [Object] ],
    traversedDown: false,
    traversedUp: true,
    entries: Map(1) { '1234' => [Object] },
    totalRowCount: 1000000,
    excluded: false,
    disconnected: false,
    reduceTraversal: false,
    whereClause: 'id = 1234',
    orderBy: undefined,
    rowLimit: 1000000,
    columns: [ [Object] ],
    primaryKey: 'id',
    visited: false
  },
  'public.b': {
    schema_name: 'public',
    table_name: 'b',
    parents: [ [Object] ],
    children: [ [Object] ],
    traversedDown: false,
    traversedUp: true,
    entries: Map(1000) {
      '1000001' => [Object],
# snip
    },
    totalRowCount: 2000000,
    excluded: false,
    disconnected: false,
    reduceTraversal: false,
    whereClause: undefined,
    orderBy: undefined,
    rowLimit: undefined,
    columns: [ [Object], [Object], [Object] ],
    primaryKey: 'id',
    visited: false
  }
}
----------------------------------
Table Row Counts after Subset
----------------------------------
public.a: 1/1000000 (0%)
public.b: 1000/1001000 (0%)
public.c: 1000000/2000000 (50%)
----------------------------------

Subset ready
2023-08-01T13:18:22.498Z snaplet:capture 2023-08-01T13:18:22.498Z snaplet:capture Event "progress": { step: 'subset', completed: 100 }
Copying files to: dump/tables
Subsetting finished
2023-08-01T13:18:22.512Z snaplet:capture 2023-08-01T13:18:22.512Z snaplet:capture Event "progress": { step: 'subset', completed: 100 }
2023-08-01T13:18:22.513Z snaplet:capture 2023-08-01T13:18:22.513Z snaplet:capture Event "progress": { step: 'subset', completed: 100 }
2023-08-01T13:18:22.513Z snaplet:capture 2023-08-01T13:18:22.513Z snaplet:capture Event "progress": { step: 'data', completed: 0 }
2023-08-01T13:18:22.513Z snaplet:capture 2023-08-01T13:18:22.513Z snaplet:capture computeCopyTablesCount result:
2023-08-01T13:18:22.513Z snaplet:capture 2023-08-01T13:18:22.513Z snaplet:capture totalRowsToCopy:  3
2023-08-01T13:18:22.513Z snaplet:capture 2023-08-01T13:18:22.513Z snaplet:capture disconnectedTables:  [ 'public.a', 'public.b', 'public.c' ]
2023-08-01T13:18:22.513Z snaplet:capture 2023-08-01T13:18:22.513Z snaplet:capture tablesCount:  {
  'public.a': { totalRowsToCopy: 1 },
  'public.b': { totalRowsToCopy: 1 },
  'public.c': { totalRowsToCopy: 1 }
}
2023-08-01T13:18:22.513Z snaplet:capture 2023-08-01T13:18:22.513Z snaplet:capture Event "progress": { step: 'subset', completed: 100 }
2023-08-01T13:18:22.513Z snaplet:capture 2023-08-01T13:18:22.513Z snaplet:capture Event "progress": { step: 'data', completed: 0 }
2023-08-01T13:18:22.513Z snaplet:capture 2023-08-01T13:18:22.513Z snaplet:capture Event "copyProgress": {
  status: 'IN_PROGRESS',
  tableName: 'a',
  schema: 'public',
  totalRows: 1
}
2023-08-01T13:18:22.514Z snaplet:capture 2023-08-01T13:18:22.514Z snaplet:capture copyTableData:
    table: public.a
    rowsToCopy: 1
    columnsToNullate:
    shouldDumpAllTable: true

public.a                       | ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ 0% | 0/12023-08-01T13:18:{
  tableName: 'a',
  schema: 'public',
  rows: 293928,
  totalAllCopiedRows: 0,
  totalAllRows: 3,
  totalRows: 1
}
public.a                       | ████████████████████████████████████████ 100% | 293928/12023-08-01{
  tableName: 'a',
  schema: 'public',
  rows: 605907,
  totalAllCopiedRows: 0,
  totalAllRows: 3,
  totalRows: 1
}
public.a                       | ████████████████████████████████████████ 100% | 605907/12023-08-01{
  tableName: 'a',
  schema: 'public',
  rows: 919251,
  totalAllCopiedRows: 0,
  totalAllRows: 3,
  totalRows: 1
}
public.a                       | ████████████████████████████████████████ 100% | 919251/12023-08-01}
2023-08-01T13:18:24.160Z snaplet:capture 2023-08-01T13:18:24.160Z snaplet:capture Event "copyProgre{
  tableName: 'a',
  schema: 'public',
  totalAllRows: 3,
  status: 'SUCCESS',
  totalAllCopiedRows: 1000000,
  rows: 1000000,
  totalRows: 1000000
}
2023-08-01T13:18:24.160Z snaplet:capture 2023-08-01T13:18:24.160Z snaplet:capture Event "copyProgre{
  status: 'IN_PROGRESS',
  tableName: 'b',
  schema: 'public',
  totalRows: 1
}
2023-08-01T13:18:24.160Z snaplet:capture 2023-08-01T13:18:24.160Z snaplet:capture copyTableData:
    table: public.b
    rowsToCopy: 1
    columnsToNullate:
    shouldDumpAllTable: true

public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ 0% | 0/12023-08-01T13:18:{
  tableName: 'b',
  schema: 'public',
  rows: 155545,
  totalAllCopiedRows: 1000000,
  totalAllRows: 3,
  totalRows: 1
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 155545/12023-08-01{
  tableName: 'b',
  schema: 'public',
  rows: 367676,
  totalAllCopiedRows: 1000000,
  totalAllRows: 3,
  totalRows: 1
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 367676/12023-08-01{
  tableName: 'b',
  schema: 'public',
  rows: 580675,
  totalAllCopiedRows: 1000000,
  totalAllRows: 3,
  totalRows: 1
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 580675/12023-08-01{
  tableName: 'b',
  schema: 'public',
  rows: 795843,
  totalAllCopiedRows: 1000000,
  totalAllRows: 3,
  totalRows: 1
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 795843/12023-08-01}
2023-08-01T13:18:26.646Z snaplet:capture 2023-08-01T13:18:26.646Z snaplet:capture Event "copyProgre{
  tableName: 'b',
  schema: 'public',
  totalAllRows: 3,
  status: 'SUCCESS',
  totalAllCopiedRows: 2001000,
  rows: 1001000,
  totalRows: 1001000
}
2023-08-01T13:18:26.646Z snaplet:capture 2023-08-01T13:18:26.646Z snaplet:capture Event "copyProgre{
  status: 'IN_PROGRESS',
  tableName: 'c',
  schema: 'public',
  totalRows: 1
}
2023-08-01T13:18:26.646Z snaplet:capture 2023-08-01T13:18:26.646Z snaplet:capture copyTableData:
    table: public.c
    rowsToCopy: 1
    columnsToNullate:
    shouldDumpAllTable: true
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 1001000/1
public.c                       | ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ 0% | 0/12023-08-01T13:18:{
  tableName: 'c',
  schema: 'public',
  rows: 162886,
  totalAllCopiedRows: 2001000,
  totalAllRows: 3,
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 1001000/1
public.c                       | ████████████████████████████████████████ 100% | 162886/12023-08-01{
  tableName: 'c',
  schema: 'public',
  rows: 329090,
  totalAllCopiedRows: 2001000,
  totalAllRows: 3,
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 1001000/1
public.c                       | ████████████████████████████████████████ 100% | 329090/12023-08-01{
  tableName: 'c',
  schema: 'public',
  rows: 496248,
  totalAllCopiedRows: 2001000,
  totalAllRows: 3,
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 1001000/1
public.c                       | ████████████████████████████████████████ 100% | 496248/12023-08-01{
  tableName: 'c',
  schema: 'public',
  rows: 664676,
  totalAllCopiedRows: 2001000,
  totalAllRows: 3,
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 1001000/1
public.c                       | ████████████████████████████████████████ 100% | 664676/12023-08-01{
  tableName: 'c',
  schema: 'public',
  rows: 833106,
  totalAllCopiedRows: 2001000,
  totalAllRows: 3,
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 1001000/1
public.c                       | ████████████████████████████████████████ 100% | 833106/12023-08-01{
  tableName: 'c',
  schema: 'public',
  rows: 999310,
  totalAllCopiedRows: 2001000,
  totalAllRows: 3,
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 1001000/1
public.c                       | ████████████████████████████████████████ 100% | 999310/12023-08-01{
  tableName: 'c',
  schema: 'public',
  rows: 1165046,
  totalAllCopiedRows: 2001000,
  totalAllRows: 3,
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 1001000/1
public.c                       | ████████████████████████████████████████ 100% | 1165046/12023-08-0{
  tableName: 'c',
  schema: 'public',
  rows: 1331407,
  totalAllCopiedRows: 2001000,
  totalAllRows: 3,
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 1001000/1
public.c                       | ████████████████████████████████████████ 100% | 1331407/12023-08-0{
  tableName: 'c',
  schema: 'public',
  rows: 1497137,
  totalAllCopiedRows: 2001000,
  totalAllRows: 3,
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 1001000/1
public.c                       | ████████████████████████████████████████ 100% | 1497137/12023-08-0{
  tableName: 'c',
  schema: 'public',
  rows: 1663183,
  totalAllCopiedRows: 2001000,
  totalAllRows: 3,
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 1001000/1
public.c                       | ████████████████████████████████████████ 100% | 1663183/12023-08-0{
  tableName: 'c',
  schema: 'public',
  rows: 1828913,
  totalAllCopiedRows: 2001000,
  totalAllRows: 3,
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 1001000/1
public.c                       | ████████████████████████████████████████ 100% | 1828913/12023-08-0{
  tableName: 'c',
  schema: 'public',
  rows: 1980465,
  totalAllCopiedRows: 2001000,
  totalAllRows: 3,
  totalRows: 1
}
2023-08-01T13:18:32.708Z snaplet:capture 2023-08-01T13:18:32.708Z snaplet:capture pgCopyTable resul}
2023-08-01T13:18:32.708Z snaplet:capture 2023-08-01T13:18:32.708Z snaplet:capture Event "copyProgre{
  tableName: 'c',
  schema: 'public',
  totalAllRows: 3,
  status: 'SUCCESS',
  totalAllCopiedRows: 4001000,
  rows: 2000000,
  totalRows: 2000000
}
public.a                       | ████████████████████████████████████████ 100% | 1000000/1
public.b                       | ████████████████████████████████████████ 100% | 1001000/1
public.c                       | ████████████████████████████████████████ 100% | 2000000/1

Capture complete!
To share this snapshot, run:
snaplet snapshot share ss-ivory-lasagna-168978
                                    query
------------------------------------------------------------------------------
 COPY "public"."a" ("id") TO STDOUT CSV HEADER NULL as 'NULL'
 COPY "public"."c" ("a_id", "b_id", "id") TO STDOUT CSV HEADER NULL as 'NULL'
 COPY "public"."b" ("a_id", "id") TO STDOUT CSV HEADER NULL as 'NULL'
(3 rows)
```
