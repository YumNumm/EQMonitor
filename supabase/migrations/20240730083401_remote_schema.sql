
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE EXTENSION IF NOT EXISTS "pg_cron" WITH SCHEMA "pg_catalog";

CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";

COMMENT ON SCHEMA "public" IS 'standard public schema';

CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";

CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";

CREATE TYPE "public"."information_author" AS ENUM (
    'jma',
    'developer',
    'unknown'
);

ALTER TYPE "public"."information_author" OWNER TO "postgres";

CREATE TYPE "public"."information_level" AS ENUM (
    'info',
    'warning',
    'critical'
);

ALTER TYPE "public"."information_level" OWNER TO "postgres";

CREATE TYPE "public"."jma_intensity" AS ENUM (
    '0',
    '1',
    '2',
    '3',
    '4',
    '!5-',
    '5-',
    '5+',
    '6-',
    '6+',
    '7'
);

ALTER TYPE "public"."jma_intensity" OWNER TO "postgres";

CREATE TYPE "public"."jma_lg_intensity" AS ENUM (
    '0',
    '1',
    '2',
    '3',
    '4'
);

ALTER TYPE "public"."jma_lg_intensity" OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";

CREATE TABLE IF NOT EXISTS "public"."tsunami" (
    "id" integer NOT NULL,
    "event_id" bigint NOT NULL,
    "serial_no" integer,
    "type" "text" NOT NULL,
    "status" "text" NOT NULL,
    "info_type" "text" NOT NULL,
    "press_at" timestamp with time zone NOT NULL,
    "report_at" timestamp with time zone NOT NULL,
    "valid_at" timestamp with time zone,
    "body" "jsonb" NOT NULL,
    "headline" "text"
);

ALTER TABLE "public"."tsunami" OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."latest_tsunami"() RETURNS SETOF "public"."tsunami"
    LANGUAGE "sql"
    AS $$
SELECT * 
FROM tsunami_latest
WHERE 
  report_at >= now() - interval '70 days' 
  AND
  valid_at >= now() - interval '70 days' 
ORDER BY report_at DESC
LIMIT 10;
$$;

ALTER FUNCTION "public"."latest_tsunami"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."update_devices_timestamp"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END
$$;

ALTER FUNCTION "public"."update_devices_timestamp"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."uuid_generate_v7"() RETURNS "uuid"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    return encode(set_bit(set_bit(overlay(
        uuid_send(gen_random_uuid())
        placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
        from 1 for 6
    ), 52, 1), 53, 1), 'hex')::uuid;
END
$$;

ALTER FUNCTION "public"."uuid_generate_v7"() OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."devices" (
    "id" "uuid" DEFAULT "public"."uuid_generate_v7"() NOT NULL,
    "fcm_token" "text" NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "devices_fcm_token_check" CHECK ((("length"("fcm_token") > 10) AND ("length"("fcm_token") < 200)))
);

ALTER TABLE "public"."devices" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."devices_earthquake_settings" (
    "id" "uuid" NOT NULL,
    "region_id" smallint NOT NULL,
    "min_jma_intensity" "public"."jma_intensity" NOT NULL,
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE "public"."devices_earthquake_settings" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."devices_eew_settings" (
    "id" "uuid" NOT NULL,
    "region_id" smallint DEFAULT 0 NOT NULL,
    "min_jma_intensity" "public"."jma_intensity" NOT NULL,
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE "public"."devices_eew_settings" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."devices_notification_settings" (
    "id" "uuid" NOT NULL,
    "notification_volume" numeric(2,1) DEFAULT 1.0,
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE "public"."devices_notification_settings" OWNER TO "postgres";

CREATE MATERIALIZED VIEW "public"."devices_with_earthquake_settings" AS
 SELECT "d"."id",
    "d"."fcm_token",
    "max"("des"."min_jma_intensity") AS "min_jma_intensity"
   FROM ("public"."devices" "d"
     JOIN "public"."devices_earthquake_settings" "des" ON (("d"."id" = "des"."id")))
  GROUP BY "d"."id", "d"."fcm_token"
  WITH NO DATA;

ALTER TABLE "public"."devices_with_earthquake_settings" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."earthquake" (
    "event_id" bigint NOT NULL,
    "status" "text" NOT NULL,
    "magnitude" numeric(2,1),
    "magnitude_condition" "text",
    "max_intensity" "public"."jma_intensity",
    "max_lpgm_intensity" "public"."jma_lg_intensity",
    "depth" integer,
    "latitude" numeric(6,3),
    "longitude" numeric(6,3),
    "epicenter_code" smallint,
    "epicenter_detail_code" smallint,
    "arrival_time" timestamp with time zone,
    "origin_time" timestamp with time zone,
    "headline" "text",
    "text" "text",
    "max_intensity_region_ids" smallint[],
    "intensity_regions" "jsonb",
    "intensity_prefectures" "jsonb",
    "intensity_cities" "jsonb",
    "intensity_stations" "jsonb",
    "lpgm_intensity_prefectures" "jsonb",
    "lpgm_intensity_regions" "jsonb",
    "lpgm_intenstiy_stations" "jsonb"
);

ALTER TABLE "public"."earthquake" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."eew" (
    "id" integer NOT NULL,
    "event_id" bigint NOT NULL,
    "type" "text" NOT NULL,
    "schema_type" "text" NOT NULL,
    "status" "text" NOT NULL,
    "info_type" "text" NOT NULL,
    "serial_no" integer,
    "headline" "text",
    "is_canceled" boolean NOT NULL,
    "is_warning" boolean,
    "is_last_info" boolean NOT NULL,
    "origin_time" timestamp with time zone,
    "arrival_time" timestamp with time zone,
    "hypo_name" "text",
    "depth" smallint,
    "latitude" numeric(3,1),
    "longitude" numeric(4,1),
    "magnitude" numeric(2,1),
    "forecast_max_intensity" "public"."jma_intensity",
    "forecast_max_lpgm_intensity" "public"."jma_lg_intensity",
    "regions" "jsonb",
    "forecast_max_intensity_is_over" boolean,
    "forecast_max_lpgm_intensity_is_over" boolean,
    "report_time" timestamp with time zone DEFAULT ("now"() AT TIME ZONE 'utc'::"text") NOT NULL,
    "accuracy" "jsonb",
    "is_plum" boolean NOT NULL
);

ALTER TABLE "public"."eew" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."eew_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."eew_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."eew_id_seq" OWNED BY "public"."eew"."id";

CREATE OR REPLACE VIEW "public"."eew_latest" AS
 SELECT DISTINCT ON ("eew"."event_id") "eew"."id",
    "eew"."event_id",
    "eew"."type",
    "eew"."schema_type",
    "eew"."status",
    "eew"."info_type",
    "eew"."serial_no",
    "eew"."headline",
    "eew"."is_canceled",
    "eew"."is_warning",
    "eew"."is_last_info",
    "eew"."origin_time",
    "eew"."arrival_time",
    "eew"."hypo_name",
    "eew"."depth",
    "eew"."latitude",
    "eew"."longitude",
    "eew"."magnitude",
    "eew"."forecast_max_intensity",
    "eew"."forecast_max_lpgm_intensity",
    "eew"."regions",
    "eew"."forecast_max_intensity_is_over",
    "eew"."forecast_max_lpgm_intensity_is_over",
    "eew"."report_time",
    "eew"."accuracy",
    "eew"."is_plum"
   FROM "public"."eew"
  ORDER BY "eew"."event_id" DESC, "eew"."serial_no" DESC
 LIMIT 5;

ALTER TABLE "public"."eew_latest" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."information" (
    "id" integer NOT NULL,
    "title" "text" NOT NULL,
    "author" "public"."information_author" DEFAULT 'unknown'::"public"."information_author" NOT NULL,
    "created_at" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "event_id" bigint,
    "type" "text" NOT NULL,
    "level" "public"."information_level" NOT NULL,
    "body" "jsonb" NOT NULL
);

ALTER TABLE "public"."information" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."information_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."information_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."information_id_seq" OWNED BY "public"."information"."id";

CREATE TABLE IF NOT EXISTS "public"."intensity_sub_division" (
    "id" integer NOT NULL,
    "event_id" bigint NOT NULL,
    "area_code" character varying(5) NOT NULL,
    "max_intensity" "public"."jma_intensity" NOT NULL,
    "max_lpgm_intensity" "public"."jma_lg_intensity"
);

ALTER TABLE "public"."intensity_sub_division" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."intensity_sub_division_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."intensity_sub_division_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."intensity_sub_division_id_seq" OWNED BY "public"."intensity_sub_division"."id";

CREATE TABLE IF NOT EXISTS "public"."telegram" (
    "id" integer NOT NULL,
    "event_id" bigint NOT NULL,
    "type" "text" NOT NULL,
    "schema_type" "text" NOT NULL,
    "status" "text" NOT NULL,
    "info_type" "text" NOT NULL,
    "press_time" timestamp with time zone NOT NULL,
    "report_time" timestamp with time zone NOT NULL,
    "valid_time" timestamp with time zone,
    "serial_no" integer,
    "headline" "text",
    "body" "jsonb" NOT NULL
);

ALTER TABLE "public"."telegram" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."telegram_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."telegram_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."telegram_id_seq" OWNED BY "public"."telegram"."id";

CREATE SEQUENCE IF NOT EXISTS "public"."tsunami_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."tsunami_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."tsunami_id_seq" OWNED BY "public"."tsunami"."id";

CREATE OR REPLACE VIEW "public"."tsunami_latest" AS
 SELECT DISTINCT ON ("tsunami"."event_id", "tsunami"."type") "tsunami"."id",
    "tsunami"."event_id",
    "tsunami"."serial_no",
    "tsunami"."type",
    "tsunami"."status",
    "tsunami"."info_type",
    "tsunami"."press_at",
    "tsunami"."report_at",
    "tsunami"."valid_at",
    "tsunami"."body",
    "tsunami"."headline"
   FROM "public"."tsunami"
  ORDER BY "tsunami"."event_id" DESC, "tsunami"."type", "tsunami"."press_at" DESC;

ALTER TABLE "public"."tsunami_latest" OWNER TO "postgres";

ALTER TABLE ONLY "public"."eew" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."eew_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."information" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."information_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."intensity_sub_division" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."intensity_sub_division_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."telegram" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."telegram_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."tsunami" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."tsunami_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."devices"
    ADD CONSTRAINT "devices_fcm_token_key" UNIQUE ("fcm_token");

ALTER TABLE ONLY "public"."earthquake"
    ADD CONSTRAINT "earthquake_pkey" PRIMARY KEY ("event_id");

ALTER TABLE ONLY "public"."eew"
    ADD CONSTRAINT "eew_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."information"
    ADD CONSTRAINT "information_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."intensity_sub_division"
    ADD CONSTRAINT "intensity_sub_division_event_id_area_code_key" UNIQUE ("event_id", "area_code");

ALTER TABLE ONLY "public"."intensity_sub_division"
    ADD CONSTRAINT "intensity_sub_division_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."telegram"
    ADD CONSTRAINT "telegram_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."tsunami"
    ADD CONSTRAINT "tsunami_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."devices_earthquake_settings"
    ADD CONSTRAINT "users_earthquake_settings_pkey" PRIMARY KEY ("id", "region_id");

ALTER TABLE ONLY "public"."devices_eew_settings"
    ADD CONSTRAINT "users_eew_settings_pkey" PRIMARY KEY ("id", "region_id");

ALTER TABLE ONLY "public"."devices"
    ADD CONSTRAINT "users_id_key" UNIQUE ("id");

ALTER TABLE ONLY "public"."devices_notification_settings"
    ADD CONSTRAINT "users_notification_settings_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."devices"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id", "fcm_token");

CREATE INDEX "earthquake_depth_idx" ON "public"."earthquake" USING "btree" ("depth");

CREATE INDEX "earthquake_epicenter_idx" ON "public"."earthquake" USING "btree" ("epicenter_code");

CREATE INDEX "earthquake_magnitude_idx" ON "public"."earthquake" USING "btree" ("magnitude", "magnitude_condition");

CREATE INDEX "earthquake_max_intensity_idx" ON "public"."earthquake" USING "btree" ("max_intensity");

CREATE INDEX "earthquake_max_lpgm_intensity_idx" ON "public"."earthquake" USING "btree" ("max_lpgm_intensity");

CREATE INDEX "earthquake_origin_time_idx" ON "public"."earthquake" USING "btree" ("origin_time");

CREATE INDEX "intensity_sub_division_max_intensity_idx" ON "public"."intensity_sub_division" USING "btree" ("max_intensity");

CREATE INDEX "intensity_sub_division_max_lpgm_intensity_idx" ON "public"."intensity_sub_division" USING "btree" ("max_lpgm_intensity");

CREATE INDEX "tsunami_event_id_idx" ON "public"."tsunami" USING "btree" ("event_id");

CREATE INDEX "tsunami_valid_at_idx" ON "public"."tsunami" USING "btree" ("valid_at");

CREATE OR REPLACE TRIGGER "update_devices_modtime" BEFORE UPDATE ON "public"."devices" FOR EACH ROW EXECUTE FUNCTION "public"."update_devices_timestamp"();

ALTER TABLE ONLY "public"."intensity_sub_division"
    ADD CONSTRAINT "public_intensity_sub_division_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."earthquake"("event_id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."devices_earthquake_settings"
    ADD CONSTRAINT "users_earthquake_settings_id_fkey" FOREIGN KEY ("id") REFERENCES "public"."devices"("id");

ALTER TABLE ONLY "public"."devices_eew_settings"
    ADD CONSTRAINT "users_eew_settings_id_fkey" FOREIGN KEY ("id") REFERENCES "public"."devices"("id");

ALTER TABLE ONLY "public"."devices_notification_settings"
    ADD CONSTRAINT "users_notification_settings_id_fkey" FOREIGN KEY ("id") REFERENCES "public"."devices"("id");

ALTER TABLE "public"."devices" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."devices_earthquake_settings" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."devices_eew_settings" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."devices_notification_settings" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."earthquake" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "earthquake_select_policy" ON "public"."earthquake" FOR SELECT USING (true);

ALTER TABLE "public"."eew" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "eew_select_policy" ON "public"."eew" FOR SELECT USING (true);

ALTER TABLE "public"."information" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "information_select_policy" ON "public"."information" FOR SELECT USING (true);

ALTER TABLE "public"."intensity_sub_division" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "intensity_sub_division_select_policy" ON "public"."intensity_sub_division" FOR SELECT USING (true);

ALTER TABLE "public"."telegram" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "telegram_select_policy" ON "public"."telegram" FOR SELECT USING (true);

ALTER TABLE "public"."tsunami" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "tsunami_select_policy" ON "public"."tsunami" FOR SELECT USING (true);

CREATE PUBLICATION "eqmonitor_db" WITH (publish = 'insert, update, delete, truncate');

ALTER PUBLICATION "eqmonitor_db" OWNER TO "postgres";

ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";

ALTER PUBLICATION "eqmonitor_db" ADD TABLE ONLY "public"."devices";

ALTER PUBLICATION "eqmonitor_db" ADD TABLE ONLY "public"."devices_earthquake_settings";

ALTER PUBLICATION "eqmonitor_db" ADD TABLE ONLY "public"."devices_eew_settings";

ALTER PUBLICATION "eqmonitor_db" ADD TABLE ONLY "public"."devices_notification_settings";

ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."earthquake";

ALTER PUBLICATION "eqmonitor_db" ADD TABLE ONLY "public"."earthquake";

ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."eew";

ALTER PUBLICATION "eqmonitor_db" ADD TABLE ONLY "public"."eew";

ALTER PUBLICATION "eqmonitor_db" ADD TABLE ONLY "public"."information";

ALTER PUBLICATION "eqmonitor_db" ADD TABLE ONLY "public"."intensity_sub_division";

ALTER PUBLICATION "eqmonitor_db" ADD TABLE ONLY "public"."telegram";

ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."tsunami";

ALTER PUBLICATION "eqmonitor_db" ADD TABLE ONLY "public"."tsunami";

ALTER PUBLICATION "eqmonitor_db" ADD TABLES IN SCHEMA "public";

GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

GRANT ALL ON TABLE "public"."tsunami" TO "anon";
GRANT ALL ON TABLE "public"."tsunami" TO "authenticated";
GRANT ALL ON TABLE "public"."tsunami" TO "service_role";

GRANT ALL ON FUNCTION "public"."latest_tsunami"() TO "anon";
GRANT ALL ON FUNCTION "public"."latest_tsunami"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."latest_tsunami"() TO "service_role";

GRANT ALL ON FUNCTION "public"."update_devices_timestamp"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_devices_timestamp"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_devices_timestamp"() TO "service_role";

GRANT ALL ON FUNCTION "public"."uuid_generate_v7"() TO "anon";
GRANT ALL ON FUNCTION "public"."uuid_generate_v7"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."uuid_generate_v7"() TO "service_role";

GRANT ALL ON TABLE "public"."devices" TO "anon";
GRANT ALL ON TABLE "public"."devices" TO "authenticated";
GRANT ALL ON TABLE "public"."devices" TO "service_role";

GRANT ALL ON TABLE "public"."devices_earthquake_settings" TO "anon";
GRANT ALL ON TABLE "public"."devices_earthquake_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."devices_earthquake_settings" TO "service_role";

GRANT ALL ON TABLE "public"."devices_eew_settings" TO "anon";
GRANT ALL ON TABLE "public"."devices_eew_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."devices_eew_settings" TO "service_role";

GRANT ALL ON TABLE "public"."devices_notification_settings" TO "anon";
GRANT ALL ON TABLE "public"."devices_notification_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."devices_notification_settings" TO "service_role";

GRANT ALL ON TABLE "public"."devices_with_earthquake_settings" TO "anon";
GRANT ALL ON TABLE "public"."devices_with_earthquake_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."devices_with_earthquake_settings" TO "service_role";

GRANT ALL ON TABLE "public"."earthquake" TO "anon";
GRANT ALL ON TABLE "public"."earthquake" TO "authenticated";
GRANT ALL ON TABLE "public"."earthquake" TO "service_role";

GRANT ALL ON TABLE "public"."eew" TO "anon";
GRANT ALL ON TABLE "public"."eew" TO "authenticated";
GRANT ALL ON TABLE "public"."eew" TO "service_role";

GRANT ALL ON SEQUENCE "public"."eew_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."eew_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."eew_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."eew_latest" TO "anon";
GRANT ALL ON TABLE "public"."eew_latest" TO "authenticated";
GRANT ALL ON TABLE "public"."eew_latest" TO "service_role";

GRANT ALL ON TABLE "public"."information" TO "anon";
GRANT ALL ON TABLE "public"."information" TO "authenticated";
GRANT ALL ON TABLE "public"."information" TO "service_role";

GRANT ALL ON SEQUENCE "public"."information_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."information_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."information_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."intensity_sub_division" TO "anon";
GRANT ALL ON TABLE "public"."intensity_sub_division" TO "authenticated";
GRANT ALL ON TABLE "public"."intensity_sub_division" TO "service_role";

GRANT ALL ON SEQUENCE "public"."intensity_sub_division_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."intensity_sub_division_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."intensity_sub_division_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."telegram" TO "anon";
GRANT ALL ON TABLE "public"."telegram" TO "authenticated";
GRANT ALL ON TABLE "public"."telegram" TO "service_role";

GRANT ALL ON SEQUENCE "public"."telegram_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."telegram_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."telegram_id_seq" TO "service_role";

GRANT ALL ON SEQUENCE "public"."tsunami_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."tsunami_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."tsunami_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."tsunami_latest" TO "anon";
GRANT ALL ON TABLE "public"."tsunami_latest" TO "authenticated";
GRANT ALL ON TABLE "public"."tsunami_latest" TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";

RESET ALL;
