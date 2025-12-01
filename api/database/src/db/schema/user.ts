import { sql } from "drizzle-orm";
import {
  check,
  index,
  numeric,
  pgTable,
  primaryKey,
  smallint,
  text,
  timestamp,
  uuid,
} from "drizzle-orm/pg-core";
import { jmaIntensityEnum } from "./enums";

export const user = pgTable("user", {
  id: uuid("id")
    .default(sql`uuid_generate_v7()`)
    .notNull()
    .unique(),
});
