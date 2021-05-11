## OS SQL LnL

### Setup

Takes ~ 5 - 10 minutes to setup.

1. [Initialize database](./setup/step_1_init.sql)
2. [Import generator helper functions](./setup/step_2_helpers.sql)
3. [Import faker data](./setup/step_3_faker.sql)
4. [Generate parents table](./setup/step_4_parents.sql)
5. [Build learners table](./setup/step_5_learners.sql)
6. [Create enrollments](./setup/step_6_enrollments.sql) 

*Optional*

- [Clean up script](./setup/step_0_remove.sql) to remove lnl type, function, and table definitions

### Challenge

1. [Challenge 0](./challenge/0.sql)
2. [Challenge 1](./challenge/1.sql)
3. [Challenge 2](./challenge/2.sql)

### How to generate fake data

1. `yarn install`
2. `node index.js`
3. This will create a file named [stubbed\_faker\_data.sql](./export/stubbed\_faker\_data.sql) in the export folder. Import / run the file into your database.
