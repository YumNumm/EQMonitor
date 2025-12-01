import {
	index,
	integer,
	jsonb,
	pgTable,
	serial,
	timestamp,
	uuid,
} from "drizzle-orm/pg-core";
import { jmaIntensityEnum } from "./enums";

/** 揺れ検知イベント */
export const shakeDetectionEvents = pgTable(
	"shake_detection_events",
	{
		id: serial("id").primaryKey(),
		eventId: uuid("event_id").notNull(),
		serialNo: integer("serial_no").notNull(),
		createdAt: timestamp("created_at", { withTimezone: true }).notNull(),
		insertedAt: timestamp("inserted_at", { withTimezone: true })
			.defaultNow()
			.notNull(),
		maxIntensity: jmaIntensityEnum("max_intensity").notNull(),
		regions: jsonb("regions").notNull(),
		topLeft: jsonb("top_left").notNull(),
		bottomRight: jsonb("bottom_right").notNull(),
		pointCount: integer("point_count").notNull(),
	},
	(table) => [
		index("shake_detection_created_at_idx").on(table.createdAt),
		index("shake_detection_events_event_id_idx").on(table.eventId),
		index("shake_detection_inserted_at_idx").on(table.insertedAt),
		index("shake_detection_max_intensity_idx").on(table.maxIntensity),
	],
);
