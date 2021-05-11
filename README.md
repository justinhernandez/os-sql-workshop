## OS SQL LnL

### Setup


4. Import / run the file [sql/init_db.sql](./sql/init_db.sql) into your database
5. Import / run the file [sql/init_helpers.sql](./sql/init_helpers.sql) into your database
6. Finally run the file [sql/populate.sql](./sql/populate.sql) to fill your database with test data. This should take ~ 2 minutes and generate ~ 6 million rows of data.

*Optional*

- [Clean up script](./sql/clean_up.sql) to remove lnl type, function, and table definitions

### Challenge

1. wow
2. neat
3. cool


### How to generate fake data

1. `yarn install`
2. `node index.js`
3. This will create a file named [stubbed\_faker\_data.sql](./export/stubbed\_faker\_data.sql) in the export folder. Import / run the file into your database.
