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

/** デバイス */
export const devices = pgTable(
  "devices",
  {
    id: uuid("id")
      .default(sql`uuid_generate_v7()`)
      .notNull()
      .unique(),
    fcmToken: text("fcm_token").notNull().unique(),
    apnsToken: text("apns_token").unique(),
    createdAt: timestamp("created_at", { withTimezone: true })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp("updated_at", { withTimezone: true })
      .defaultNow()
      .notNull()
      .$onUpdateFn(() => new Date()),
  },
  (table) => [
    primaryKey({ columns: [table.id] }),
    index("devices_fcm_token_idx").on(table.fcmToken),
    index("devices_apns_token_idx").on(table.apnsToken),
    check(
      "devices_fcm_token_check",
      sql`length(${table.fcmToken}) > 10 AND length(${table.fcmToken}) < 200`
    ),
    check(
      "devices_apns_token_check",
      sql`length(${table.apnsToken}) > 10 AND length(${table.apnsToken}) < 200`
    ),
  ]
);
