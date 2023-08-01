var path = require("path");

exports.databaseUrl = "postgresql://postgres@localhost:5432/snaplet-test?host=" + encodeURIComponent(path.resolve(__dirname, "sock"))

if (require.main === module) {
    console.log(exports.databaseUrl);
}
