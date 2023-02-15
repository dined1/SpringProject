import bodyParser from "body-parser";
import express from "express";
import pg from "pg";

// Connect to the database using the DATABASE_URL environment
//   variable injected by Railway
// const pool = new pg.Pool();

const app = express();
const path = require('path');
// const port = process.env.PORT || 3333;

app.set('view engine', 'ejs');
// app.set('views', 'C:/expressjs-postgres/src/views')
app.set('views', path.join(__dirname, 'views'));

app.use(bodyParser.json());
app.use(bodyParser.raw({ type: "application/vnd.custom-type" }));
app.use(bodyParser.text({ type: "text/html" }));

app.get("/", async (req, res) => {
//   const { rows } = await pool.query("SELECT tadoushi, jidoushi, translation FROM tajiverb");
  res.render('ind', {
    subject: 'EJS template engine',
    name: 'Japanese',
    link: 'https://google.com'
  });
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
