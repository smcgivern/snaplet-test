var fs = require("fs");

var config = JSON.parse(fs.readFileSync("./.snaplet/config.json"));

config.targetDatabaseUrl = require("./database-url.js").databaseUrl;

fs.writeFileSync("./.snaplet/config.json", JSON.stringify(config));
