BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "article" ADD COLUMN "categoryId" bigint;
ALTER TABLE "article" ADD COLUMN "_categoryArticlesCategoryId" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "article_tag" (
    "id" bigserial PRIMARY KEY,
    "articleId" bigint NOT NULL,
    "tagId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "article_tag_idx" ON "article_tag" USING btree ("articleId", "tagId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "category" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "tag" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL
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
    VALUES ('my_app', '20260916130559205', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260916130559205', "timestamp" = now();

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
