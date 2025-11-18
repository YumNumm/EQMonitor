import fs from "node:fs";
import { androidpublisher_v3, google } from "googleapis";
async function main() {
    const packageName = process.env.PACKAGE_NAME || process.argv[2];
    if (!packageName) {
        throw new Error("PACKAGE_NAME is not set");
    }
    const aabFilePath = process.env.AAB_FILE_PATH || process.argv[3];
    if (!aabFilePath) {
        throw new Error("AAB_FILE_PATH is not set");
    }
    google.options({
        http2: true,
    });
    const auth = new google.auth.GoogleAuth({
        scopes: ["https://www.googleapis.com/auth/androidpublisher"],
    });
    const androidPublisher = new androidpublisher_v3.Androidpublisher({
        auth,
    });
    const edit = await androidPublisher.edits.insert({
        packageName,
    });
    const upload = await androidPublisher.edits.bundles.upload({
        requestBody: {
            packageName,
            edit: edit.data.id,
            media: {
                mimeType: "application/octet-stream",
                body: fs.createReadStream(aabFilePath),
            },
        },
    });
    console.log(upload.data);
}
main().catch((e) => {
    console.error(e);
    throw e;
});
