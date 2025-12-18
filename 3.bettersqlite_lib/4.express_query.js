const express = require('express');
const Database = require('better-sqlite3');
const fs = require('fs');

const PORT = 3100;
const db_file = 'my-express-db.db'

const app = express();
const db = new Database(db_file);

// 입력 요청 json으로 받아서 req.body에 받아주기 위한 미들웨어..
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

function init_database() {
    const sql = fs.readFileSync('init_database.sql', 'utf-8');  // sync라서 동기모드로 읽힘 (즉 블로킹 함수)
    const statements = sql.split(';');  // 각 행을 ; 으로 짤라서, 빈행 (undefined / null 등) 으로 나오는걸 제외
    try {
        for (const statement of statements) {
            // console.log(statement);
            db.exec(statement);
        }
    } catch(err) {
        console.log('이미 초기화 되었습니다.'); // 아주 좋은 코드는 아님..
    }
}


init_database();

app.get('/api/table/:table', (req, res) => {
    const db_table = req.params.table;

    try {
        const query_str = `SELECT * FROM ${db_table}`;
        console.log(query_str)
    
        const query = db.prepare(`SELECT * FROM ${db_table}`);
        const queryResult = query.all();
        res.json(queryResult);
    } catch (err){
        res.send('요청하신 테이블 정보는 존재하지 않습니다.');
    };
});

app.get('/api/users', (req, res) => {
    // try-catch 해줘야함..
    const { username } = req.query;

    if (username) {
        const query = db.prepare('SELECT * FROM users WHERE username LIKE ?');
        const users = query.all(`%${username}%`);
        res.json(users);
    } else {
        const users = db.prepare('SELECT * FROM users').all();
        res.send(users);
    }
});

app.get('/api/users/:id', (req, res) => {
    const userId = req.params.id;

    const user = db.prepare('SELECT * FROM users WHERE id=?').get(userId);
    if (user) {
        res.send(user);
    } else {
        return res.status(404).send("사용자가 요청한 정보가 없습니다");
    }
});

app.post('/api/users', (req, res) => {
    const { username, password } = req.body;
    const insert = db.prepare('INSERT INTO users (username, password) VALUES (?,?)');
    const result = insert.run(username, password);
    res.send(`사용자가 추가되었습니다. 신규ID: ${result.lastInsertRowid}`);
});

// 숙제
app.put('/api/users/:id', (req, res) => {
    try {
        const userId = req.params.id;
        const { username, password } = req.body;
        const correction = db.prepare('UPDATE users SET username = ?, password = ? WHERE id = ?');
        const result = correction.run(username, password, userId);
    
        res.send(`수정 완료! 수정된 ID: ${result.changes}`);
    } catch (err) {
        res.status(404).send('해당 id를 찾을 수 없습니다');
    }
});

app.delete('/api/users/:id', (req, res) => {
    try {
        const id = req.params.id;
        const stmt = db.prepare('DELETE FROM users WHERE id = ?');
        const result = stmt.run(id); 
        
        res.send(`삭제 완료! 영향받은 행: ${result.changes}`);
    } catch (err) {
        res.status(404).send('사용자가 입력하신 Id가 없습니다..');
    }
});

// curl "localhost:3100/api/products?name=pro"
// curl localhost:3100/api/products
app.get('/api/products', (req, res) => {
    const { name } = req.query;

    if (name) {
        const query = db.prepare('SELECT * FROM products WHERE name LIKE ?');
        const rows = query.all(`%${name}%`);
        res.json(rows)
    } else {
        const query = db.prepare('SELECT * FROM products');
        const rows = query.all()
        res.json(rows);
    }
});

app.listen(PORT, () => {
    console.log('Server is ready...');
});

// curl localhost:3100/api/table/books
// curl localhost:3100/api/users
// curl localhost:3100/api/users?username=1
// curl localhost:3100/api/users?username=hello
// curl localhost:3100/api/users/1
// curl localhost:3100/api/users -X POST -d username=hello -d password=world

// curl -X DELETE http://localhost:3100/api/users/1

// curl -X PUT http://localhost:3100/api/users/1 \
//      -H "Content-Type: application/json" \
//      -d '{
//        "username": "수정된이름",
//        "password": "newpassword123"
//      }'