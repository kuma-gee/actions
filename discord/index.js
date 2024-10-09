const core = require("@actions/core");
const discord = require("discord.js");

try {
  const webhook = core.getInput("discord-webhook");
  if (!webhook) core.setFailed("Discord webhook is required");

  const webhookClient = new discord.WebhookClient({ url: webhook });
  webhookClient.send();

  const title = core.getInput("title");
  const msg = core.getInput("message");
  const embed = new discord.EmbedBuilder().setTitle(title).setDescription(msg).setColor(0x00ffff);

  core.debug(`Sending message: ${msg}`);
  webhookClient.send({
    // content: msg ?? 'No message provided',
    embeds: [embed],
  });

} catch (error) {
  core.setFailed(error.message);
}
