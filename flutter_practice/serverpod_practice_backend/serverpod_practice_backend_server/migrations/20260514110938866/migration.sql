BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "persons" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "age" bigint NOT NULL,
    "city" text NOT NULL,
    "favoriteColor" text NOT NULL,
    "profession" text NOT NULL
);


--
-- MIGRATION VERSION FOR serverpod_practice_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_practice_backend', '20260514110938866', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260514110938866', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
