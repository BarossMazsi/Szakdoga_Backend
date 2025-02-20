const express = require('express')
const mysql = require('mysql')
const bcrypt = require('bcryptjs');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
var cors = require('cors')

const app = express()
const port = 3000

app.use(cors())
app.use(express.json());
app.use(express.static('kepek'));
app.use(bodyParser.json());

const SECRET_KEY = 'your_secret_key';

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
    const datum = new Date();  
    const jodatum=datum.getFullYear()+"-"+(datum.getMonth()+1)+"-"+datum.getDate()
    // Új edzés adat rögzítése
    const query = 'INSERT INTO edzes  VALUES (null,4 ,?, ?, ?,?,?,?)';
    const values = [jodatum,req.body.tipus,req.body.idoTartam,req.body.egetes,req.body.leiras,req.body.megjegyzes];
  
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

  app.get('/EdzesLekerdez', (req, res) => {
    kapcsolat();  // Kapcsolódás az adatbázishoz
    connection.query('SELECT edzes_id , edzes_datum , edzes_tipus , edzes_idotartam edzes_', (err, rows) => {
      if (err) {
        console.error('Hiba történt az edzések lekérdezésekor:', err);
        return res.status(500).send('Hiba történt az edzések lekérdezésekor.');
      }
      res.status(200).json(rows); // Edzéstípusok visszaadása
    });
    connection.end();
  });

  app.post('/EdzesAtlag', (req, res) => {
    kapcsolat();  // Kapcsolódás az adatbázishoz
    connection.query('SELECT edzes_felhid,edzes_tipus,AVG(edzes_idotartam), AVG(edzes_egetes) FROM edzes Where edzes_felhid =? Group BY edzes_felhid,edzes_tipus ',[req.body.bevitel1] ,(err, rows) => {
      if (err) {
        console.error('Hiba történt az edzéstípusok lekérdezésekor:', err);
        return res.status(500).send('Hiba történt az edzéstípusok lekérdezésekor.');
      }
      res.status(200).json(rows); // Edzéstípusok visszaadása
    });
    connection.end();
  });
/*
  app.get('/EdzesAtlag', (req, res) => {
    kapcsolat();  // Kapcsolódás az adatbázishoz
    connection.query('SELECT edzes_felhid,edzes_tipus,AVG(edzes_idotartam), AVG(edzes_egetes) FROM edzes Group BY edzes_felhid,edzes_tipus ',[req.body.bevitel1] ,(err, rows) => {
      if (err) {
        console.error('Hiba történt az edzéstípusok lekérdezésekor:', err);
        return res.status(500).send('Hiba történt az edzéstípusok lekérdezésekor.');
      }
      res.status(200).json(rows); // Edzéstípusok visszaadása
    });
    connection.end();
  });
*/
  
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
  const { bevitel1, bevitel2 } = req.body;

  // Check if username already exists
  kapcsolat();
  connection.query(
    'SELECT felh_email FROM felhasznalok WHERE felh_email = ?',
    [bevitel1],
    (err, rows, fields) => {
      if (err) {
        console.log(err);
        res.status(500).send('Hiba');
      } else {
        if (rows.length !== 0) {
          res.status(500).send('A felhasználónév már létezik!');
        } else {
          // Hash the password before inserting
          bcrypt.hash(bevitel2, 10, (err, hashedPassword) => {
            if (err) {
              console.log(err);
              res.status(500).send('Hiba a jelszó hash-elés során');
            } else {
              // Insert new user with hashed password
              kapcsolat();
              connection.query(
                `INSERT INTO felhasznalok VALUES (null, ?, ?, "",0,0,1,"","")`,
                [bevitel1, hashedPassword],
                (err, rows, fields) => {
                  if (err) {
                    console.log(err);
                    res.status(500).send('Hiba');
                  } else {
                    console.log(rows);
                    res.status(200).send('Sikeres regisztráció!');
                  }
                }
              );
            }
          });
        }
      }
    }
  );
  connection.end();
});

app.post('/beleptetes', (req, res) => {
  const { bevitel1, bevitel2 } = req.body;

  kapcsolat();
  connection.query(
    'SELECT fel_id, felh_email, felh_jelszo FROM felhasznalok WHERE felh_email = ?',
    [bevitel1],
    (err, rows, fields) => {
      if (err) {
        console.log(err);
        res.status(500).send([]);
      } else {
        if (rows.length === 0) {
          res.status(400).send('Felhasználó nem található!');
        } else {
          const hashedPassword = rows[0].felh_jelszo;
          
          // Compare the provided password with the hashed one
          bcrypt.compare(bevitel2, hashedPassword, (err, isMatch) => {
            if (err) {
              console.log(err);
              res.status(500).send('Hiba a jelszó összehasonlítás során');
            } else if (isMatch) {
              res.status(200).send(rows);
            } else {
              res.status(400).send('Hibás jelszó');
            }
          });
        }
      }
    }
  );
  connection.end();
});

  app.get('/felhasznalok', (req, res) => {
    kapcsolat();
    connection.query(`SELECT * FROM felhasznalok INNER JOIN nemek ON felhasznalok.felh_nem = nemek.id`, (err, rows) => {
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

app.put('/felhasznalokmodositas', (req, res) => {
    kapcsolat()
      connection.connect()    
      connection.query(`UPDATE felhasznalok SET felh_nev= "${req.body.felh_nev}", felh_mag=${req.body.felh_mag}, felh_suly=${req.body.felh_suly}, felh_nem=${req.body.felh_nem}, felh_nemszeret="${req.body.felh_nemszeret}", felh_kep="${req.body.felh_kep}", WHERE fel_id= ${req.body.fel_id}`, (err, rows, fields) => {
        if (err) 
          res.send("Hiba") 
        else 
        res.send("A felhasznalok módosítás sikerült")
      })    
      connection.end()
});

app.post('/uzenetfelvitel', (req, res) => {
       
  
    // Új edzés adat rögzítése
    const query = 'INSERT INTO uzenet  VALUES (null,?,?,?,?)';
    const values = [req.body.bevitel1,req.body.bevitel2,req.body.bevitel3,req.body.bevitel4];
  
    kapcsolat();
    connection.query(query, values, (err, result) => {
      if (err) {
        console.error('Hiba történt az üzenet rögzítésekor:', err);
        return res.status(500).send('Hiba történt az üzenet rögzítésekor.');
      }
      res.status(200).send({ message: 'Üzenet rögzítve!' });
    });
    connection.end();
  });

//Webes---------------------------------------------------------------------------------------------------------------------------------------------------
app.post('/web/login', (req, res) => {
  const { username, password } = req.body;

  kapcsolat()

  const query = 'SELECT felh_email, felh_jelszo FROM felhasznalok inner join rang on rang_felhasznalo=fel_id WHERE felh_email = ? and rang_ertek=1';
  connection.query(query, [username], (err, rows) => {
    if (err) {
      console.error('Adatbázis hiba:', err);
      res.status(500).json({ message: 'Szerverhiba' });
    } else if (rows.length === 0) {
      res.status(404).json({ message: 'Felhasználó nem található' });
    } else {
      const hashedPassword = rows[0].felh_jelszo;

      // Jelszó ellenőrzése bcrypt-tel
      bcrypt.compare(password, hashedPassword, (err, isMatch) => {
        if (err) {
          console.error('Hiba a jelszó ellenőrzésekor:', err);
          res.status(500).json({ message: 'Szerverhiba' });
        } else if (isMatch) {
          const token = jwt.sign({ username: rows[0].felh_email }, SECRET_KEY, {
            expiresIn: '1h',
          });
          res.json({ token });
        } else {
          res.status(401).json({ message: 'Hibás jelszó' });
        }
      });
    }
  });

  connection.end();
});


app.get('/Rangok', (req, res) => {
  kapcsolat()
  connection.query(`
      SELECT felh_email, rang_ertek
      FROM felhasznalok
      INNER JOIN rang
      ON fel_id=rang_felhasznalo
    `, (err, rows, fields) => {
    if (err) {
      console.log("Hiba")
      console.log(err)
      res.status(500).send("Hiba")
    }
    else {
      console.log(rows)
      res.status(200).send(rows)
    }
  })
  connection.end()
})

app.put('/RangokModosit', (req, res) => {
  kapcsolat()
  connection.query(`
    UPDATE rang SET rang_ertek = ? where rang_felhasznalo = ? 
    `,[req.body.bevitel1, req.body.bevitel2], (err, rows, fields) => {
    if (err) {
      console.log("Hiba")
      console.log(err)
      res.status(500).send("Hiba")
    }
    else {
      console.log("Sikeres módosítás!")
      res.status(200).send("Sikeres módosítás!")
    }
  })
  connection.end()
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})