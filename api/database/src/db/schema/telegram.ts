import {
	bigint,
	integer,
	jsonb,
	pgTable,
	serial,
	text,
	timestamp,
} from "drizzle-orm/pg-core";

/** 電文 */
export const telegram = pgTable("telegram", {
	id: serial("id").primaryKey(),
	eventId: bigint("event_id", { mode: "bigint" }).notNull(),
	type: text("type").notNull(),
	schemaType: text("schema_type").notNull(),
	status: text("status").notNull(),
	infoType: text("info_type").notNull(),
	pressTime: timestamp("press_time", { withTimezone: true }).notNull(),
	reportTime: timestamp("report_time", { withTimezone: true }).notNull(),
	validTime: timestamp("valid_time", { withTimezone: true }),
	serialNo: integer("serial_no"),
	headline: text("headline"),
	body: jsonb("body").notNull(),
});
