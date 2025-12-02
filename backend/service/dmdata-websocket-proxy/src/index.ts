import type { APITypes } from "@dmdata/api-types";
import { serve } from "@hono/node-server";
import { createNodeWebSocket } from "@hono/node-ws";
import { prometheus } from "@hono/prometheus";
import * as pyroscope from "@pyroscope/nodejs";
import { Hono } from "hono";
import type { WSContext } from "hono/ws";
import * as uuid from "uuid";
import type WebSocket from "ws";
import { DMDATA } from "./dmdata.js";
import { env } from "./environments.js";
import { logger } from "./logger.js";

pyroscope.init({
	serverAddress: "http://10.17.201.203:4040",
	appName: "dmdata-websocket-proxy",
	wall: {
		collectCpuTime: true,
	},
});
pyroscope.start();

const { printMetrics, registerMetrics } = prometheus();

export type WebSocketPayload = APITypes.WebSocketV2.Event.All & {
	rayId: string;
};

let websockets: WSContext<WebSocket>[] = [];

const app = new Hono()
	.use("*", registerMetrics)
	.get("/metrics", printMetrics)
	.get("/health", (c) => c.text("ok"));
const { injectWebSocket, upgradeWebSocket } = createNodeWebSocket({ app });
app.get(
	"/ws",
	upgradeWebSocket((c) => ({
		onOpen(_event, ws) {
			websockets.push(ws);
			logger.info("New Connection has been established", {
				type: "connection",
				ws: {
					status: ws.readyState,
					remoteAddress: ws.url,
				},
			});
		},
		onClose(_event, ws) {
			websockets = websockets.filter((w) => w !== ws);
			logger.info("Connection has been closed", {
				type: "connection",
				ws: {
					status: ws.readyState,
					remoteAddress: ws.url,
				},
			});
		},
		onMessage(_event, ws) {
			logger.info("Message has been received", {
				type: "message",
				ws: {
					status: ws.readyState,
					remoteAddress: ws.url,
				},
				message: _event.data,
			});
		},
	})),
);

// DMDATAからのデータを処理し、接続されたWebSocketに転送する関数
const handleDMDATAMessage = (data: APITypes.WebSocketV2.Event.All) => {
	if (data.type === "data") {
		logger.info("Broadcasting message to all connected clients", {
			id: data.id,
			clientCount: websockets.length,
		});
		const performanceStart = performance.now();

		// すべての接続されているクライアントにデータを送信
		for (const ws of websockets) {
			if (ws.readyState === 1) {
				const rayId = uuid.v7();
				// OPEN
				try {
					ws.send(
						JSON.stringify({
							rayId,
							...data,
						}),
					);
					logger.info("Message sent to client", {
						type: data.head.type,
						url: ws.raw?.url,
						rayId,
					});
				} catch (error) {
					logger.error("Failed to send message to client", { error });
				}
			} else {
				logger.info("Skipping message to client", {
					type: data.head.type,
					url: ws.raw?.url,
					readyState: ws.readyState,
				});
			}
		}
		const performanceEnd = performance.now();
		logger.info("Message broadcasted to all connected clients", {
			id: data.id,
			clientCount: websockets.length,
			performance: performanceEnd - performanceStart,
		});
	}
};

// DMDATA WebSocketクライアントを初期化
const token = env.DMDATA_TOKEN;
if (!token) {
	logger.error("DMDATA_TOKEN environment variable is not set");
	process.exit(1);
}

const dmdataClient = new DMDATA(token, handleDMDATAMessage);
dmdataClient.startWebSocket().catch((error) => {
	logger.error("Failed to start DMDATA WebSocket", { error });
	process.exit(1);
});

// プロセス終了時にDMDATA接続をクリーンアップ
process.on("SIGINT", () => {
	logger.info("Shutting down...");
	dmdataClient.close();
	process.exit(0);
});

process.on("SIGTERM", () => {
	logger.info("Shutting down...");
	dmdataClient.close();
	process.exit(0);
});

const server = serve(
	{
		fetch: app.fetch,
		port: env.DMDATA_WS_PROXY_PORT
			? Number.parseInt(env.DMDATA_WS_PROXY_PORT)
			: undefined,
	},
	(info) => {
		logger.info("Server is running", {
			port: info.port,
			url: `${info.address}:${info.port}`,
		});
	},
);
injectWebSocket(server);

export type WebSocketApp = typeof app;
