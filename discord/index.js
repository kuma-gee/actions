const core = require("@actions/core");
const github = require("@actions/github");
const discord = require("discord.js");

try {
  const webhook = core.getInput("discord-webhook");
  if (!webhook) core.setFailed("Discord webhook is required");

  const webhookClient = new discord.WebhookClient({ url: webhook });
  webhookClient.send();

  const title = core.getInput("title");
  const embed = new discord.EmbedBuilder().setTitle(title).setColor(0x00ffff);

  const msg = core.getInput("message");

  webhookClient.send({
    content: msg,
    embeds: [embed],
  });

} catch (error) {
  core.setFailed(error.message);
}
