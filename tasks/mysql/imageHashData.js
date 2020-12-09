const path = require("path");
const fs = require("fs");
const file = require("../../WebContent/json/prebuilt.json");
const mysql = require("mysql");

class SQLManagerImpl {

    constructor() {
    }

    createConnection() {
        return new Promise((resolve, reject) => {
            const pool = mysql.createPool({
                connectionLimit: 10,
                host: "localhost",
                port: 3306,
                user: "root",
                password: "1234",
                database: "mydb",
                debug: true
            });

            pool.getConnection((err, conn) => {
                if(err) {
                    reject(err);
                    return;
                }
                resolve(conn);
            });
        });
    }

    async dropTable() {
        this._conn = await this.createConnection();
        this._conn.query(`DROP TABLE if exists tblimagehash`, (err, result) => {
            if(err) {
                console.warn(err);
                return;
            }
            console.log("drop table 성공");
        })    

        return this._conn;
    }

    async createTable(conn) {
        conn.query(`create table tblImageHash ( pageType varchar(4) not null, genderType varchar(1) not null, shopType varchar(1) not null, imgUrl varchar(256) not null, imgId varchar(256) not null )`, (err, result) => {
            if(err) {
                console.warn(err);
                return;
            }
            console.log("테이블 생성 완료");
        });

        return conn;
    }

    async insertAllData(conn) {
        try {
            const query = `insert into tblImageHash(pageType, genderType, shopType, imgUrl, imgId) values(?, ?, ?, ?, ?)`;
            file.forEach(data => {
                const {pageType, genderType, shopType, imageData} = data;

                Object.keys(imageData).forEach(key => {
                    const exec = conn.query(query, [
                        pageType,
                        genderType,
                        shopType,
                        key,
                        imageData[key]
                    ]);                    
                });

            });

        } catch(e) {
            console.warn(e);
        }

        return conn;

    }
}

async function start() {
    try {
        const man = new SQLManagerImpl();

        await man.dropTable().then(async (conn) => {
            await man.createTable(conn);
            await man.insertAllData(conn);
        })

    } catch(e) {
        console.warn(e);
    }
}

start();