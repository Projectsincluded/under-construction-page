require('dotenv').config();                                         // Config
const express = require('express')
const router = express.Router()
const path = require('path');
const port = 8080

const app = express()
const IP = process.env.EXPRESS_IP;
const PORT = process.env.EXPRESS_PORT;

app.use(express.static(path.join(__dirname, 'public')));           // Set the folder to wherever we will store our static content
app.use(router)

router.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
})

app.listen(port, () => {
    console.log(`Listening on http://${IP}:${PORT}`)
})