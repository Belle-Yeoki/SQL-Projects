SELECT *  --This just helps you see how many tables you have got in your Database
  FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'Customer'
  --This just helps you see how many tables you have got in your Database
  SELECT *
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME IN ('Customer','Testing');--This helps you see the content of your columns
  