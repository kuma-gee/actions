const core = require("@actions/core");
const process = require("child_process");
const changelog = (...args) =>
  import("conventional-changelog").then(({ default: changelog }) =>
    changelog(...args)
  );

function streamToString(stream) {
  const chunks = [];
  return new Promise((resolve, reject) => {
    stream.on("data", (chunk) => chunks.push(Buffer.from(chunk)));
    stream.on("error", (err) => reject(err));
    stream.on("end", () => resolve(Buffer.concat(chunks).toString("utf8")));
  });
}

function exec(command) {
  return process.execSync(command).toString().trim();
}

async function run() {
  try {
    let previousTag = core.getInput("previous-tag");
    if (previousTag === "") {
      previousTag = exec("git tag | sort --version-sort | tail -n2 | head -1");
    }

    let latestTag = core.getInput("latest-tag");
    if (latestTag === "") {
      latestTag = exec("git describe --tags --abbrev=0");
    }

    console.log("Generating changelog for tags:", previousTag, latestTag);
    const log = await streamToString(
      await changelog(
        {
          preset: "angular",
          // tagPrefix: `${previousTag}..${latestTag}`,
          tagPrefix: `version`,
        },
        { previousTag, currentTag: latestTag, version: latestTag }
      )
    );

    core.setOutput("changelog", log);
  } catch (error) {
    core.setFailed(error.message);
  }
}

run();
