BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "article" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "article" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "slug" text NOT NULL,
    "summary" text,
    "content" text NOT NULL,
    "coverImageUrl" text,
    "authorName" text NOT NULL,
    "authorAvatarUrl" text,
    "status" text NOT NULL,
    "viewsCount" bigint NOT NULL,
    "likesCount" bigint NOT NULL,
    "readingTimeMinutes" bigint NOT NULL,
    "isFeatured" boolean NOT NULL,
    "publishedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone,
    "categoryId" bigint,
    "_categoryArticlesCategoryId" bigint
);

--
-- ACTION DROP TABLE
--
DROP TABLE "category" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "category" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "slug" text NOT NULL,
    "description" text,
    "colorHex" text,
    "iconName" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comment" (
    "id" bigserial PRIMARY KEY,
    "articleId" bigint NOT NULL,
    "authorName" text NOT NULL,
    "authorEmail" text NOT NULL,
    "authorAvatarUrl" text,
    "content" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "isApproved" boolean NOT NULL,
    "parentCommentId" bigint,
    "userId" bigint
);

--
-- ACTION DROP TABLE
--
DROP TABLE "tag" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "tag" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "slug" text NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "article"
    ADD CONSTRAINT "article_fk_0"
    FOREIGN KEY("categoryId")
    REFERENCES "category"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "article"
    ADD CONSTRAINT "article_fk_1"
    FOREIGN KEY("_categoryArticlesCategoryId")
    REFERENCES "category"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "comment"
    ADD CONSTRAINT "comment_fk_0"
    FOREIGN KEY("articleId")
    REFERENCES "article"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION RESTORE FOREIGN KEY
--
ALTER TABLE ONLY "article_tag"
    ADD CONSTRAINT "article_tag_fk_0"
    FOREIGN KEY("articleId")
    REFERENCES "article"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "article_tag"
    ADD CONSTRAINT "article_tag_fk_1"
    FOREIGN KEY("tagId")
    REFERENCES "tag"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR my_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('my_app', '20260917053513514', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260917053513514', "timestamp" = now();

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
