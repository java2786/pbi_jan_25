# Database Management System - DBMS
## Type
- Relational Database - SQL
    - mysql
    - oracle
    - postgresql
    - MS Access
- Document Database - NO SQL
    - mongodb

## Installation
- Download, Install, Remember your credentials
- Windows: Open run -> services.msc
    - search 'MySql'
    - start/stop
- Linux: Open terminal and run command
    - sudo systemctl status mysql
    - sudo systemctl start mysql
    - sudo systemctl stop mysql

- Uninstall -> Uninstall, delete all folders related to mysql

## Usage - connection
- Open terminal and type
- $ mysql -u root -proot
    - same machine
- $ mysql --host localhost --port 3306 -u root -proot
- $ mysql -u root -proot

## Structure - table 
- Database Server - Database - Table - Row - Cell
    - $ create database db_name;
    - $ use db_name;
    - $ create table table_name(
        column data_type,
        column data_type,
        column data_type
    );

    - $ show databases;
    - $ create database tutorials;
    - $ use tutorials;
    - $ create table students(
        name varchar(10),
        age int,
        address varchar(50)
    );
    - $ show tables;
    - $ select * from students;
    - $ desc students;



