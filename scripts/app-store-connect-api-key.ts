import { sign } from "jsonwebtoken";
import fs from "node:fs";
const env = {
  keyId: "4LQFA4R675",
  issuerId: "fd4cca56-716b-4f03-8e44-de72a03453db",
};
const header = {
  alg: "ES256",
  typ: "JWT",
  kid: env.keyId,
} as const;

const jwt = sign(
  {
    iss: env.issuerId,
    aud: "appstoreconnect-v1",
  },
  fs.readFileSync("AuthKey.p8"),
  {
    header,
    algorithm: "ES256",
    expiresIn: "2m",
  }
);

console.log(jwt);
