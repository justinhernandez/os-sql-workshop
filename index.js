const Faker = require("faker");
const Fs = require("fs");

let fileOutput = "";

function writeFile() {
  const filePath = `${process.cwd()}/export/stubbed_faker_data.sql`;
  console.log(`writing ${filePath}...`);
  Fs.writeFileSync(filePath, fileOutput);
}

function updateOutput(table, collection) {
  fileOutput += `TRUNCATE TABLE ${table};\n`;
  collection.map((c) => {
    // escape single quotes
    c = c.replace("'", "''");
    fileOutput += `INSERT INTO ${table}(name) values('${c}');\n`;
  });
  fileOutput += "\n";
}

function generate(method, count) {
  const collect = [];
  for (let j = 0; j < count; j++) {
    collect.push(method());
  }
  return collect;
}

function build(table, method, count = 50) {
  const collection = generate(method, count);
  updateOutput(table, collection);
}

// collect faker collections
build("parent_first_names", Faker.name.firstName);
build("parent_last_names", Faker.name.lastName);
build("learner_first_names", Faker.name.firstName, 1000);
writeFile();
