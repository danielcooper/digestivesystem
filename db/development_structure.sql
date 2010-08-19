CREATE TABLE "exposures" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "birth" datetime, "death" datetime, "stream_id" integer, "created_at" datetime, "updated_at" datetime, "resource_id" integer);
CREATE TABLE "resources" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "type" varchar(255), "title" varchar(255), "blurb" text, "resource_url" varchar(255), "created_at" datetime, "updated_at" datetime, "external_image_url" varchar(255), "artist_gid" varchar(255), "artist_name" varchar(255));
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "services" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "display_name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "streams" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "display_name" varchar(255), "service_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20100816145239');

INSERT INTO schema_migrations (version) VALUES ('20100817163112');

INSERT INTO schema_migrations (version) VALUES ('20100818131718');

INSERT INTO schema_migrations (version) VALUES ('20100818135707');

INSERT INTO schema_migrations (version) VALUES ('20100818142258');

INSERT INTO schema_migrations (version) VALUES ('20100818160022');

INSERT INTO schema_migrations (version) VALUES ('20100819092732');