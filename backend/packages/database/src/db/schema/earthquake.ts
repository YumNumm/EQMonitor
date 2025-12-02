import {
	bigint,
	index,
	integer,
	numeric,
	pgTable,
	serial,
	smallint,
	text,
	timestamp,
	unique,
	varchar,
} from "drizzle-orm/pg-core";
import type { TelegramStatus } from "./common";
import { jmaIntensityEnum, jmaLgIntensityEnum } from "./enums";

/** 地震情報 */
export const earthquake = pgTable(
	"earthquake",
	{
		eventId: bigint("event_id", { mode: "bigint" }).primaryKey(),
		status: text("status").$type<TelegramStatus>().notNull(),
		magnitude: numeric("magnitude", { precision: 2, scale: 1 }),
		magnitudeCondition: text("magnitude_condition"),
		maxIntensity: jmaIntensityEnum("max_intensity"),
		maxLpgmIntensity: jmaLgIntensityEnum("max_lpgm_intensity"),
		depth: integer("depth"),
		latitude: numeric("latitude", { precision: 6, scale: 3 }),
		longitude: numeric("longitude", { precision: 6, scale: 3 }),
		epicenterCode: smallint("epicenter_code"),
		epicenterName: text("epicenter_name"),
		epicenterDetailCode: smallint("epicenter_detail_code"),
		epicenterDetailName: text("epicenter_detail_name"),
		arrivalTime: timestamp("arrival_time", { withTimezone: true }),
		originTime: timestamp("origin_time", { withTimezone: true }),
		headline: text("headline"),
		text: text("text"),
	},
	(table) => [
		index("earthquake_depth_idx").on(table.depth),
		index("earthquake_epicenter_idx").on(table.epicenterCode),
		index("earthquake_magnitude_idx").on(
			table.magnitude,
			table.magnitudeCondition,
		),
		index("earthquake_max_intensity_idx").on(table.maxIntensity),
		index("earthquake_max_lpgm_intensity_idx").on(table.maxLpgmIntensity),
		index("earthquake_origin_time_idx").on(table.originTime),
	],
);

const intensityItem = {
	id: serial("id").primaryKey(),
	eventId: bigint("event_id", { mode: "bigint" })
		.notNull()
		.references(() => earthquake.eventId, {
			onUpdate: "cascade",
			onDelete: "cascade",
		}),
	code: varchar("code", { length: 7 }).notNull(),
	intensity: jmaIntensityEnum("intensity"),
	lpgmIntensity: jmaLgIntensityEnum("lpgm_intensity"),
};

/** 震度細分区域 */
export const earthquakeIntensityRegions = pgTable(
	"earthquake_intensity_regions",
	intensityItem,
	(table) => [
		unique("earthquake_intensity_regions_event_id_code_key").on(
			table.eventId,
			table.code,
		),
		index("earthquake_intensity_regions_intensity_idx").on(table.intensity),
		index("earthquake_intensity_regions_lpgm_intensity_idx").on(
			table.lpgmIntensity,
		),
	],
);

/* 震度 都道府県 */
export const earthquakeIntensityPrefectures = pgTable(
	"earthquake_intensity_prefectures",
	intensityItem,
);

/* 震度 市区町村 */
export const earthquakeIntensityCities = pgTable(
	"earthquake_intensity_cities",
	intensityItem,
);

/* 震度 観測点 */
export const earthquakeIntensityStations = pgTable(
	"earthquake_intensity_stations",
	intensityItem,
);
