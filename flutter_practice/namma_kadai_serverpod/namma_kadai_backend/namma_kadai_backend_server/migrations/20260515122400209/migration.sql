BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "cart_item" (
    "id" bigserial PRIMARY KEY,
    "productId" text NOT NULL,
    "title" text NOT NULL,
    "price" double precision NOT NULL,
    "imageUrl" text NOT NULL,
    "quantity" bigint NOT NULL,
    "userId" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "order" (
    "id" bigserial PRIMARY KEY,
    "uid" text,
    "items" json NOT NULL,
    "totalAmount" double precision NOT NULL,
    "dateTime" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "product" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "price" double precision NOT NULL,
    "imageUrl" text NOT NULL,
    "category" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_model" (
    "id" bigserial PRIMARY KEY,
    "userId" text NOT NULL,
    "email" text NOT NULL,
    "name" text,
    "gender" text,
    "profileImageUrl" text,
    "createdAt" timestamp without time zone
);


--
-- MIGRATION VERSION FOR namma_kadai_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('namma_kadai_backend', '20260515122400209', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260515122400209', "timestamp" = now();

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
