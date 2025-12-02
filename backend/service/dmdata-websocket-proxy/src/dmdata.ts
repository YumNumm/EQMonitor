import { env } from "node:process";
import type { APITypes } from "@dmdata/api-types";
import WebSocket from "ws";
import { logger } from "./logger.js";

export class DMDATA {
	private ws: WebSocket | null = null;
	private pingInterval: NodeJS.Timeout | null = null;
	private pingTimeout: NodeJS.Timeout | null = null;
	private lastPingId: string | null = null;
	private reconnectAttempts = 0;
	private maxReconnectAttempts = 5;
	private reconnectDelay = 5000;

	constructor(
		private readonly token: string,
		private readonly dataHandler: (
			data: APITypes.WebSocketV2.Event.All,
		) => void,
	) {}

	async startWebSocket() {
		try {
			// 1. Socket Start APIを呼び出してチケットを取得
			const ticket = await this.getSocketStartTicket();

			// 2. WebSocketを開始
			this.connectWebSocket(ticket);

			return true;
		} catch (error) {
			logger.error("Failed to start WebSocket", { error });
			throw error;
		}
	}

	private async getSocketStartTicket(): Promise<APITypes.SocketStart.ResponseOk> {
		try {
			const token = Buffer.from(`${this.token}:`).toString("base64");
			const response = await fetch("https://api.dmdata.jp/v2/socket", {
				method: "POST",
				headers: {
					Authorization: `Basic ${token}`,
					"Content-Type": "application/json",
				},
				body: JSON.stringify({
					classifications: ["telegram.earthquake", "eew.forecast"],
					formatMode: "json",
					test: "no",
					appName: "dmdata-websocket-proxy",
				} satisfies APITypes.SocketStart.RequestBodyJSON),
			});
			const json = await response.json();
			logger.info("Socket start ticket response", {
				json: JSON.stringify(json, null, 2),
			});

			if (!response.ok) {
				throw new Error(`API error: ${json.error} (${json.code})`);
			}

			const data = json as APITypes.SocketStart.ResponseOk;
			logger.info("Socket start ticket retrieved", {
				socketId: data.websocket.id,
				classifications: data.classifications,
				test: data.test,
				types: data.types,
				formatMode: data.formats,
				appName: data.appName,
			});

			return data;
		} catch (error) {
			logger.error("Failed to get socket start ticket", { error });
			throw error;
		}
	}

	private connectWebSocket(startTicket: APITypes.SocketStart.ResponseOk) {
		const region = env.REGION ?? "auto";
		let wsUrl = startTicket.websocket.url;

		if (region === "tokyo") {
			wsUrl = wsUrl.replace("ws.api.dmdata.jp", "ws-tokyo.api.dmdata.jp");
		} else if (region === "osaka") {
			wsUrl = wsUrl.replace("ws.api.dmdata.jp", "ws-osaka.api.dmdata.jp");
		}

		logger.info("Connecting to WebSocket", {
			url: wsUrl,
			region,
		});
		try {
			this.ws = new WebSocket(wsUrl, {
				headers: {
					WebSocketProtocol: "dmdata.v2",
				},
			});

			this.ws.on("open", () => {
				logger.info("WebSocket connection established");
				this.reconnectAttempts = 0;
				this.startPingInterval();
			});

			this.ws.on("message", (data: Buffer) => {
				try {
					const message = JSON.parse(
						data.toString(),
					) as APITypes.WebSocketV2.Event.All;
					this.handleWebSocketMessage(message);
				} catch (error) {
					logger.error("Failed to parse WebSocket message", {
						error,
						data: data.toString(),
					});
				}
			});

			this.ws.on("error", (error: Error) => {
				logger.error("WebSocket error", { error });
			});

			this.ws.on("close", (code: number, reason: Buffer) => {
				logger.info("WebSocket connection closed", {
					code,
					reason: reason.toString(),
				});
				this.cleanupWebSocket();
				this.handleReconnect();
			});
		} catch (error) {
			logger.error("Failed to connect WebSocket", { error });
			this.handleReconnect();
		}
	}

	private handleWebSocketMessage(message: APITypes.WebSocketV2.Event.All) {
		switch (message.type) {
			case "start":
				logger.info("WebSocket start message received", {
					socketId: message.socketId,
					classifications: message.classifications,
				});
				break;

			case "ping":
				// pingを受け取ったらpongを返す
				this.lastPingId = message.pingId ?? null;
				this.sendPong(message.pingId ?? "");
				break;

			case "data":
				logger.info("Data message received", {
					message,
				});
				// データハンドラーを呼び出す
				this.dataHandler(message);
				break;

			case "error":
				logger.error("Error message received", {
					error: message.error,
					code: message.code,
					close: message.close,
				});
				if (message.close && this.ws) {
					this.ws.close();
				}
				break;

			case "pong":
				logger.debug("Pong message received", {
					pingId: message.pingId,
				});
				break;
			case "change.classification":
				logger.info("Classification changed", {
					message,
				});
				break;
			case "jmafile":
				logger.info("JMA file message received", {
					message,
				});
				break;
		}
	}

	private sendPong(pingId: string) {
		if (!this.ws || this.ws.readyState !== WebSocket.OPEN) return;

		try {
			const pongMessage: APITypes.WebSocketV2.Event.Pong = {
				type: "pong",
				pingId,
			};
			this.ws.send(JSON.stringify(pongMessage));
			logger.debug("Pong sent", { pingId });
		} catch (error) {
			logger.error("Failed to send pong", { error, pingId });
		}
	}

	private sendPing() {
		if (!this.ws || this.ws.readyState !== WebSocket.OPEN) return;

		try {
			const pingId = Date.now().toString();
			const pingMessage: APITypes.WebSocketV2.Event.Ping = {
				type: "ping",
				pingId,
			};
			this.ws.send(JSON.stringify(pingMessage));
			logger.debug("Ping sent", { pingId });
		} catch (error) {
			logger.error("Failed to send ping", { error });
		}
	}

	private startPingInterval() {
		// 30秒ごとにPingを送信
		this.pingInterval = setInterval(() => this.sendPing(), 30000);
	}

	private cleanupWebSocket() {
		if (this.pingInterval) {
			clearInterval(this.pingInterval);
			this.pingInterval = null;
		}

		if (this.pingTimeout) {
			clearTimeout(this.pingTimeout);
			this.pingTimeout = null;
		}

		this.lastPingId = null;

		if (this.ws) {
			this.ws.removeAllListeners();
			if (this.ws.readyState === WebSocket.OPEN) {
				this.ws.close();
			}
			this.ws = null;
		}
	}

	private handleReconnect() {
		if (this.reconnectAttempts >= this.maxReconnectAttempts) {
			logger.error("Max reconnect attempts reached");
			return;
		}

		this.reconnectAttempts++;
		const delay = this.reconnectDelay * 1.5 ** (this.reconnectAttempts - 1);

		logger.info("Attempting to reconnect", {
			attempt: this.reconnectAttempts,
			maxAttempts: this.maxReconnectAttempts,
			delay,
		});

		setTimeout(() => this.startWebSocket(), delay);
	}

	// WebSocket接続を終了
	public close() {
		logger.info("Closing WebSocket connection");
		this.cleanupWebSocket();
	}
}
