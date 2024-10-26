const core = require("@actions/core");
const github = require("@actions/github");
const process = require("child_process");

function exec(command) {
  return process.execSync(command).toString().trim();
}

function getTags() {
  let latestTag = core.getInput("latest-tag");
  if (latestTag === "") {
    latestTag = "HEAD";
  }

  const isReleseCandidate = latestTag.includes("-rc");

  let previousTag = core.getInput("previous-tag");
  if (previousTag === "") {
    if (isReleseCandidate) {
      previousTag = exec("git tag -l v* --sort=creatordate | tail -n2 | head -n1");
    } else {
      previousTag = exec(
        "git tag -l v* --sort=creatordate | grep -v '\\-rc[0-9]' | tail -n2 | head -n1"
      );
    }

    if (!previousTag) {
      previousTag = latestTag;
    }
  }

  console.log(exec('git tag -l v* --sort=creatordate | grep -v "\\-rc[0-9]"'));

  return [previousTag, latestTag];
}

function groupBy(array, keyFn, mapper = (x) => x) {
  return array.reduce((acc, item) => {
    const group = keyFn(item);
    if (!acc[group]) acc[group] = [];
    acc[group].push(mapper(item));
    return acc;
  }, {});
}

const KEYWORDS = {
  feat: "Features",
  fix: "Bug Fixes",
  others: "Others",
};

const ORDER = ["feat", "fix", "others"];

// Use our own changelog generator, library has problems and will be difficult to customize
function generateChangelog(previousTag, latestTag, includeOthers = false) {
  console.log("Generating changelog for tags:", previousTag, latestTag);
  const githubUrl = `https://github.com/${github.context.repo.owner}/${github.context.repo.repo}`;
  const logs = exec(`git log --pretty='%h %H %s' ${previousTag}..${latestTag}`);
  const data = logs
    .split("\n")
    .map((line) => {
      const [hash, fullHash, ...message] = line.split(" ");
      let [type, text] = message.join(" ").split(":");
      if (!text && includeOthers) {
        text = type;
        type = "others";
      }

      if (!ORDER.includes(type)) return null;

      text = text.trim();
      return {
        type,
        message: `* ${text} [${hash}](${githubUrl}/commit/${fullHash})`,
      };
    })
    .filter((x) => !!x);

  const grouped = groupBy(
    data,
    (item) => item.type,
    (item) => item.message
  );

  const title = `## [${latestTag}](${githubUrl}/compare/${previousTag}..${latestTag})`;
  const content = Object.keys(grouped)
    .sort((a, b) => ORDER.indexOf(a) - ORDER.indexOf(b))
    .map((type) => {
      const items = grouped[type].join("\n");
      return `### ${KEYWORDS[type]}\n\n${items}`;
    })
    .join("\n\n");

  return `${title}\n${content}`;
}

async function run() {
  try {
    const [previousTag, latestTag] = getTags();
    const includeOthers = core.getInput("include-others") === "true";
    const log = generateChangelog(previousTag, latestTag, includeOthers);

    core.setOutput("changelog", log);
  } catch (error) {
    core.setFailed(error.message);
  }
}

run();
