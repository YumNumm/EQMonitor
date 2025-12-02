import * as v from "valibot";

export const environments = v.object({
	LOKI_TOKEN: v.pipe(v.string(), v.minLength(1)),
	DMDATA_WS_PROXY_PORT: v.optional(v.pipe(v.string(), v.minLength(1))),
	DMDATA_TOKEN: v.pipe(v.string(), v.minLength(1)),
	REGION: v.optional(v.picklist(["osaka", "tokyo", "auto"])),
	SERVER_NAME: v.optional(v.string()),
});

export type Environments = v.InferOutput<typeof environments>;

export const env = v.parse(environments, process.env);
