import {
	bigint,
	jsonb,
	pgTable,
	serial,
	text,
	timestamp,
} from "drizzle-orm/pg-core";
import { informationAuthorEnum, informationLevelEnum } from "./enums";

/** お知らせ */
export const information = pgTable("information", {
	id: serial("id").primaryKey(),
	title: text("title").notNull(),
	author: informationAuthorEnum("author").default("unknown").notNull(),
	createdAt: timestamp("created_at", { withTimezone: true })
		.defaultNow()
		.notNull(),
	eventId: bigint("event_id", { mode: "bigint" }),
	type: text("type").notNull(),
	level: informationLevelEnum("level").notNull(),
	body: jsonb("body").notNull(),
});
