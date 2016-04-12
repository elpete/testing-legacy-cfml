# Repo for "Live Testing a Legacy CFML App"

## Get Up and Running!

### Database Setup (MySQL)

**Note:** This will first delete the `eventplanning` database if you have previously created it.

| Setting  | Value     |
|----------|-----------|
| Host     | localhost |
| Port     | 3306      |
| Username | root      |
| Password | (blank)   |

Run the follow commands in your terminal:
```sh
# From the project root
mysql -uroot -p
# Enter again
source database-setup.sql
```

### Start the app

The easiest way to do this is with [CommandBox](https://www.ortussolutions.com/products/commandbox). Simply run `box server start` in the project root and you're off!

