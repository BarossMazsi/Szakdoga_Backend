const express = require('express')
const mysql = require('mysql')
var cors = require('cors')

const app = express()
const port = 3000

app.use(cors())
app.use(express.json());
app.use(express.static('kepek'));


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

app.get('/EdzesTipusok', (req, res) => {
    kapcsolat();  // Kapcsolódás az adatbázishoz
    connection.query('SELECT * FROM tipus', (err, rows) => {
      if (err) {
        console.error('Hiba történt az edzéstípusok lekérdezésekor:', err);
        return res.status(500).send('Hiba történt az edzéstípusok lekérdezésekor.');
      }
      res.status(200).json(rows); // Edzéstípusok visszaadása
    });
    connection.end();
  });


  app.post('/EdzesFelvitel', (req, res) => {
       
  
    // Új edzés adat rögzítése
    const query = 'INSERT INTO edzes  VALUES (null,4 ,?, ?, ?,?)';
    const values = [req.body.bevitel1,req.body.bevitel2,req.body.bevitel3,req.body.bevitel4];
  
    kapcsolat();
    connection.query(query, values, (err, result) => {
      if (err) {
        console.error('Hiba történt az edzés rögzítésekor:', err);
        return res.status(500).send('Hiba történt az edzés rögzítésekor.');
      }
      res.status(200).send({ message: 'Edzés rögzítve!' });
    });
    connection.end();
  });
  
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
    const query = `
        SELECT 
            tanacsok.*,
            sportolok.*,
            DATE_FORMAT(tanacsok.datum, '%Y-%m-%d') AS local_datum
        FROM 
            tanacsok 
        INNER JOIN 
            sportolok 
        ON 
            tanacsok.sportoloid = sportolok.ID
    `;
    connection.query(query, (err, rows) => {
        if (err) {
            console.log(err);
            res.status(500).send("Hiba");
        } else {
            console.log(rows);
            res.status(200).send(rows);
        }
    });
    connection.end();
});

app.post('/regisztracio', (req, res) => {
    kapcsolat();
    connection.query('select felh_nev from felhasznalok where felh_nev=? ',[req.body.bevitel1], (err, rows, fields) => {
        if (err) {
            console.log(err)
            res.status(500).send("Hiba")
        }
        else{
            console.log(rows)
            if (rows.length!=0) {
                  res.status(500).send("A felhasználónév már létezik!")
            } else {
                    kapcsolat()
                    connection.query('insert into felhasznalok values (null,?,?)',[req.body.bevitel1, req.body.bevitel2], (err, rows, fields) => {
                      if (err) {
                          console.log(err)
                          res.status(500).send("Hiba")
                      }
                      else{
                          console.log(rows)
                          res.status(200).send("Sikeres regisztráció!")
                      }
                    })            
                   }
        }
      })
      connection.end()
  });

  app.post('/beleptetes', (req, res) => {
    kapcsolat();
    connection.query('select fel_id,felh_nev from felhasznalok where felh_nev=? and felh_jelszo=?',[req.body.bevitel1, req.body.bevitel2], (err, rows, fields) => {
        if (err) {
            console.log(err)
            res.status(500).send([])
        }
        else{
            console.log(rows)
            res.status(200).send(rows)
        }
      })
      connection.end()
  });

  app.get('/felhasznalok', (req, res) => {
    kapcsolat();
    connection.query('SELECT * FROM felhasznalok', (err, rows) => {
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