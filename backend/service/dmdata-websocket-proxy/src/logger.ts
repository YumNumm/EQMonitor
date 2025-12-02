import winston from "winston";
import LokiTransport from "winston-loki";
import { env } from "./environments.js";

export const logger = winston.createLogger({
	handleExceptions: true,
	handleRejections: true,
});
logger.add(
	new winston.transports.Console({
		format: winston.format.json(),
		level: "debug",
	}),
);
logger.add(
	new LokiTransport({
		host: "https://loki.yumnumm.dev",
		labels: {
			service: "dmdata-websocket-proxy",
			region: env.REGION,
			serverName: env.SERVER_NAME,
		},
		headers: {
			"proxy-authorization": `Bearer ${env.LOKI_TOKEN}`,
		},
		gracefulShutdown: true,
		handleExceptions: true,
		handleRejections: true,
		level: "debug",
		onConnectionError(error) {
			logger.error("Failed to connect to Loki", { error });
			console.error(error);
		},
	}),
);
