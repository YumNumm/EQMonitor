import { sql } from "drizzle-orm";
import { pgTable, uuid } from "drizzle-orm/pg-core";

export const user = pgTable("user", {
	id: uuid("id").default(sql`uuid_generate_v7()`).notNull().unique(),
});
