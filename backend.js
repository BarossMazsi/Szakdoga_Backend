const express = require('express')
const mysql = require('mysql')
var cors = require('cors')

const app = express()
const port = 3000

app.use(cors())
app.use(express.json());


var connection
function kapcsolat(){
    connection = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: '',
        database: 'focis_mobil'
      })
      connection.connect()
}



app.get('/', (req, res) => {
  res.send('Hello World!')
})
//-Mazsi végpontjai------------------------------------------------------------------------------------------------------
app.get('/video', (req, res) => {
    kapcsolat()
    connection.query('SELECT * from video', (err, rows, fields) => {
        if (err) {
            console.log(err)
            res.status(500).send("Hiba")
        }
        else{
            console.log(rows)
            res.status(200).send(rows)
        }
      })
      connection.end()
  })

  app.get('/', (req, res) => {
    res.send('Hello World!')
  })
  
  app.post('/SzavazatFelvitel', (req, res) => {
    const connection = kapcsolat()
    const bevitel1 = req.body.bevitel1

    if (!bevitel1) {
        return res.status(400).send('Hiányzó szavazati adat.')
    }

    try {
        connection.query('INSERT INTO szavazat VALUES (null, ?)', [bevitel1], (err, rows) => {
            if (err) {
                console.error('Error executing query:', err)
                res.status(500).send('Hiba történt a szavazat rögzítése során.')
            } else {
                res.status(200).send("Sikeres Szavazás!")
            }
        })
    } catch (error) {
        console.error('Unexpected error:', error)
        res.status(500).send('Váratlan hiba történt.')
    } finally {
        connection.end((err) => {
            if (err) {
                console.error('Error closing the database connection:', err)
            } else {
                console.log('Database connection closed.')
            }
        })
    }
})
  
//István végpontjai-------------------------------------------------------------------------------------
app.get('/Sportoloklista', (req, res) => {
    kapcsolat();
    connection.query('SELECT * FROM sportolok', (err, rows) => {
        if (err) {
            console.log(err);
            res.status(500).send("Hiba");
        } else {
            console.log(rows);
            res.status(200).send(rows);
        }
    })
    connection.end()
});

app.get('/Tanacsoklista', (req, res) => {
    kapcsolat();
    connection.query('SELECT * FROM tanacsok inner join sportolok on tanacsok.sportoloid=sportolok.ID', (err, rows) => {
        if (err) {
            console.log(err);
            res.status(500).send("Hiba");
        } else {
            console.log(rows);
            res.status(200).send(rows);
        }
    })
    connection.end()
});



app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
