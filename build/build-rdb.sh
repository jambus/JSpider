#!/bin/bash

# create RDB postgres manually on AWS
psql -h spider.cwjm8lssrlxz.ap-northeast-1.rds.amazonaws.com -p 5432 -U root -d postgres -f db.sql
#It will ask to input db root password

