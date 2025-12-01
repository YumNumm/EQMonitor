import { sql } from "drizzle-orm";
import {
	bigint,
	boolean,
	integer,
	jsonb,
	numeric,
	pgTable,
	serial,
	smallint,
	text,
	timestamp,
} from "drizzle-orm/pg-core";
import { jmaIntensityEnum, jmaLgIntensityEnum } from "./enums";

/** 緊急地震速報 */
export const eew = pgTable("eew", {
	id: serial("id").primaryKey(),
	eventId: bigint("event_id", { mode: "bigint" }).notNull(),
	type: text("type").notNull(),
	schemaType: text("schema_type").notNull(),
	status: text("status").notNull(),
	infoType: text("info_type").notNull(),
	serialNo: integer("serial_no"),
	headline: text("headline"),
	isCanceled: boolean("is_canceled").notNull(),
	isWarning: boolean("is_warning"),
	isLastInfo: boolean("is_last_info").notNull(),
	originTime: timestamp("origin_time", { withTimezone: true }),
	arrivalTime: timestamp("arrival_time", { withTimezone: true }),
	hypoName: text("hypo_name"),
	depth: smallint("depth"),
	latitude: numeric("latitude", { precision: 3, scale: 1 }),
	longitude: numeric("longitude", { precision: 4, scale: 1 }),
	magnitude: numeric("magnitude", { precision: 2, scale: 1 }),
	forecastMaxIntensity: jmaIntensityEnum("forecast_max_intensity"),
	forecastMaxLpgmIntensity: jmaLgIntensityEnum("forecast_max_lpgm_intensity"),
	regions: jsonb("regions"),
	forecastMaxIntensityIsOver: boolean("forecast_max_intensity_is_over"),
	forecastMaxLpgmIntensityIsOver: boolean(
		"forecast_max_lpgm_intensity_is_over",
	),
	reportTime: timestamp("report_time", { withTimezone: true })
		.default(sql`now() AT TIME ZONE 'utc'`)
		.notNull(),
	accuracy: jsonb("accuracy"),
	isPlum: boolean("is_plum").notNull(),
});
