ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements';

CREATE TABLE a (
       id BIGSERIAL PRIMARY KEY
);

CREATE TABLE b (
       id BIGSERIAL PRIMARY KEY,
       a_id BIGSERIAL NOT NULL REFERENCES a(id)
);

CREATE TABLE c (
       id BIGSERIAL PRIMARY KEY,
       a_id BIGSERIAL NOT NULL REFERENCES a(id),
       b_id BIGSERIAL NOT NULL REFERENCES b(id)
);

INSERT INTO a
SELECT * FROM generate_series(1, 1000000);

INSERT INTO b (a_id)
SELECT id FROM (SELECT * FROM a ORDER BY random() LIMIT 1000) a, generate_series(1, 1000);

INSERT INTO c (a_id, b_id)
SELECT a_id, id FROM (SELECT * FROM b ORDER BY random() LIMIT 1000) a, generate_series(1, 1000);

INSERT INTO b (a_id)
SELECT id FROM (SELECT * FROM a WHERE id = 1234) a, generate_series(1, 1000);

INSERT INTO c (a_id, b_id)
SELECT a_id, id FROM (SELECT * FROM b WHERE a_id = 1234) a, generate_series(1, 1000);
