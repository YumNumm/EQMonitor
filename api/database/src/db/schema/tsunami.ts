import {
	bigint,
	index,
	integer,
	jsonb,
	pgTable,
	serial,
	text,
	timestamp,
} from "drizzle-orm/pg-core";

/** 津波情報 */
export const tsunami = pgTable(
	"tsunami",
	{
		id: serial("id").primaryKey(),
		eventId: bigint("event_id", { mode: "bigint" }).notNull(),
		serialNo: integer("serial_no"),
		type: text("type").notNull(),
		status: text("status").notNull(),
		infoType: text("info_type").notNull(),
		pressAt: timestamp("press_at", { withTimezone: true }).notNull(),
		reportAt: timestamp("report_at", { withTimezone: true }).notNull(),
		validAt: timestamp("valid_at", { withTimezone: true }),
		body: jsonb("body").notNull(),
		headline: text("headline"),
	},
	(table) => [
		index("tsunami_event_id_idx").on(table.eventId),
		index("tsunami_valid_at_idx").on(table.validAt),
	],
);
