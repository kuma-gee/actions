const core = require("@actions/core");
const discord = require("discord.js");

try {
  const webhook = core.getInput("discord-webhook");
  if (!webhook) core.setFailed("Discord webhook is required");

  const webhookClient = new discord.WebhookClient({ url: webhook });

  const failure = core.getInput("failure");
  const title = core.getInput("title");
  const msg = core.getInput("message");
  const embed = new discord.EmbedBuilder()
    .setTitle(title)
    .setDescription(msg)
    .setColor(failure ? 0xff0000 : 0x00ff00);

  core.debug(`Sending message: ${msg}`);
  webhookClient.send({ embeds: [embed], });

} catch (error) {
  core.setFailed(error.message);
}
