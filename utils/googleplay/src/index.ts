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
  const releaseNotesFilePath =
    process.env.RELEASE_NOTES_FILE_PATH || process.argv[4];
  if (!releaseNotesFilePath) {
    throw new Error("RELEASE_NOTES_FILE_PATH is not set");
  }
  const releaseNotes = fs.readFileSync(releaseNotesFilePath, "utf8");
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
  const trackUpdate = await androidPublisher.edits.tracks.update({
    requestBody: {
      releases: [
        {
          versionCodes: [upload.data.versionCode?.toString() ?? ""],
          releaseNotes: JSON.parse(releaseNotes),
          status: "draft",
        },
      ],
      // https://developers.google.com/android-publisher/tracks?hl=ja#ff-track-name
      track: "qa",
    },
  });
  console.log(trackUpdate.data);
  if (!edit.data.id) {
    throw new Error("Edit ID is not set");
  }
  const commit = await androidPublisher.edits.commit({
    packageName,
    editId: edit.data.id,
  });
  console.log(commit.data);
}

main().catch((e) => {
  const data = e.response?.data;
  if (data) {
    console.error(data);
    process.exit(1);
  }
  throw e;
});
