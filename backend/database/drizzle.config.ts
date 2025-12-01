import { defineConfig } from "drizzle-kit";

export default defineConfig({
	out: "./drizzle",
	schema: "./src/db/schema.ts",
	dialect: "postgresql",
	dbCredentials: {
		url: "postgresql://localhost:5432/eqmonitor",
	},
});
