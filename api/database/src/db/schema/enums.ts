import { pgEnum } from "drizzle-orm/pg-core";

/** 震度 */
export const jmaIntensityEnum = pgEnum("jma_intensity", [
  "0",
  "1",
  "2",
  "3",
  "4",
  "!5-",
  "5-",
  "5+",
  "6-",
  "6+",
  "7",
]);

/** 長周期地震動階級 */
export const jmaLgIntensityEnum = pgEnum("jma_lg_intensity", [
  "0",
  "1",
  "2",
  "3",
  "4",
]);
