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
/*app.get('/video', (req, res) => {
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

  app.post('/edzes', (req, res) => {
    const { felhasznalo_id, edzes_datum, edzes_tipus, edzes_idotartam, edzes_intenzitas } = req.body;

    if (!felhasznalo_id || !edzes_datum || !edzes_tipus || !edzes_idotartam || !edzes_intenzitas) {
        return res.status(400).send('Hiányzó edzésadatok.');
    }

    kapcsolat();

    const query = 'INSERT INTO edzes (felhasznalo_id, edzes_datum, edzes_tipus, edzes_idotartam, edzes_intenzitas) VALUES (?, ?, ?, ?, ?)';
    connection.query(query, [felhasznalo_id, edzes_datum, edzes_tipus, edzes_idotartam, edzes_intenzitas], (err, result) => {
        if (err) {
            console.error(err);
            res.status(500).send('Hiba történt az edzés adatainak rögzítésekor.');
        } else {
            res.status(200).send('Edzésadat sikeresen rögzítve!');
        }
    });

    connection.end();
});



           

 
app.post('/video', (req, res) => {
    const { felhasznalo_id, video_link } = req.body;

    if (!felhasznalo_id || !video_link) {
        return res.status(400).send('Hiányzó videó adat.');
    }

    kapcsolat();

    const query = 'INSERT INTO video (video_felhasznalo, video_link) VALUES (?, ?)';
    connection.query(query, [felhasznalo_id, video_link], (err, result) => {
        if (err) {
            console.error(err);
            res.status(500).send('Hiba történt a videó adatainak rögzítésekor.');
        } else {
            res.status(200).send('Videó sikeresen rögzítve!');
        }
    });

    connection.end();
});

app.post('/EdzesFelvitel', (req, res) => {
    const { workoutType, workoutDuration, workoutDate, userId } = req.body;
  
    if (!workoutType || !workoutDuration || !workoutDate || !userId) {
      return res.status(400).send('Hiányzó adatok.');
    }
  
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
    connection.query('SELECT * FROM tanacsok', (err, rows) => {
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
