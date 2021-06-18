/**
 * @name FileMessenger
 * @author Lytigas
 * @description Send a message by writing to a file.
 * @version 0.0.0
 */

const fs = require('fs');

module.exports = (() => {
	const config = {
		info: {
			name: "FileMessenger",
			authors: [
				{
					name: "Lytigas",
				}
			],
			version: "0.0.0",
			description: "Send a message by writing to a file.",
		},
		changelog: []
	};

	return !global.ZeresPluginLibrary ? class {
		constructor() { this._config = config; }
		getName() { return config.info.name; }
		getAuthor() { return config.info.authors.map(a => a.name).join(", "); }
		getDescription() { return config.info.description; }
		getVersion() { return config.info.version; }
		load() {
			BdApi.showConfirmationModal("Library plugin is needed",
				[`The library plugin needed for ${config.info.name} is missing. Please click Download Now to install it.`], {
				confirmText: "Download",
				cancelText: "Cancel",
				onConfirm: () => {
					require("request").get("https://rauenzi.github.io/BDPluginLibrary/release/0PluginLibrary.plugin.js", async (error, response, body) => {
						if (error) return require("electron").shell.openExternal("https://betterdiscord.net/ghdl?url=https://raw.githubusercontent.com/rauenzi/BDPluginLibrary/master/release/0PluginLibrary.plugin.js");
						await new Promise(r => require("fs").writeFile(require("path").join(BdApi.Plugins.folder, "0PluginLibrary.plugin.js"), body, r));
					});
				}
			});
		}
		start() { }
		stop() { }
	} : (([Plugin, Api]) => {
		const plugin = (Plugin, Api) => {
			const { DiscordModules, Toasts } = Api;
			const { UserInfoStore } = DiscordModules;

			const getNonce = () => (new Date().getTime() * (1 << 9)) + Math.floor(Math.random() * (1 << 9))

			const sendMessage = (channel, msg) => {
				return fetch(`https://discord.com/api/v9/channels/${channel}/messages`, {
					"headers": {
						"accept": "*/*",
						"accept-language": "en-US",
						"authorization": UserInfoStore.getToken(),
						"content-type": "application/json",
						"sec-fetch-dest": "empty",
						"sec-fetch-mode": "cors",
						"sec-fetch-site": "same-origin",
					},
					"referrer": "https://discord.com/channels/809876514744696852/809876514744696855",
					"referrerPolicy": "no-referrer-when-downgrade",
					"body": JSON.stringify({ content: msg, nonce: getNonce(), tts: false }),
					"method": "POST",
					"mode": "cors",
					"credentials": "include"
				});
			}

			const watchFilePath = "/tmp/discord_file_message"
			const splitStr = "\x02"; // EOA/STX
			const endStr = "\x03"; // EOM/ETX
			const ackStr = "\x06"; // ACK
			const successStr = ackStr + "success";
			const failStr = ackStr + "failed";

			const showError = msg => Toasts.show("FileMessenger: " + msg, { type: Toasts.ToastTypes.error });
			const showSuccess = msg => Toasts.show("FileMessenger: " + msg, { type: Toasts.ToastTypes.success });

			const handleFileChange = () => {
				fs.readFile(watchFilePath, { encoding: 'utf-8' }, (err, data) => {
					if (err) {
						showError("Error reading comm file: " + err.message);
						return
					}
					const endOfMsg = data.indexOf(endStr);
					if (endOfMsg < 0) {
						// msg is not "done" yet
						return
					}
					const stripData = data.substring(0, endOfMsg);
					const components = stripData.split(splitStr);
					const chan = components.shift();
					const msg = components.join(splitStr);

					// ensure chan parses as a discord channel
					if (!/^[0-9]+$/.test(chan)) {
						showError("Parsed channel invalid: " + chan);
						endHandleFileChange(false);
						return
					}
					// ensure message is non-empty
					if (msg.length <= 0) {
						showError("Message empty");
						endHandleFileChange(false);
						return
					}

					sendMessage(chan, msg).then(resp => {
						if (resp.ok) {
							endHandleFileChange(true);
							showSuccess("Message sent");
						} else {
							showError("Sending message did not succeed: " + resp.status + " " + resp.statusText)
							endHandleFileChange(false);
						}
					}).catch(err => {
						showError("Error sending message: " + err.toString());
						endHandleFileChange(false);
					})
				})
			}

			const endHandleFileChange = success => {
				const writeStr = success ? successStr : failStr;
				fs.writeFileSync(watchFilePath, writeStr, { flag: 'w' });
			}

			return class MessageStatus extends Plugin {
				onStart() {

					// if file doesn't exist, watching crashes.
					const fd = fs.openSync(watchFilePath, 'w');
					fs.closeSync(fd);

					this.watcher = fs.watch(watchFilePath, { persistent: false, recursive: false });
					this.watcher.on('change', (evt, _filename) => {
						if (evt === "change") {
							handleFileChange();
							return;
						}
						if (evt !== "rename") {
							showError("Got unexpected event: ", evt);
						}
					});
				}

				onStop() {
					this.watcher.close()
				}
			}
		};
		return plugin(Plugin, Api);
	})(global.ZeresPluginLibrary.buildPlugin(config));
})();
