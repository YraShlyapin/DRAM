import express from "express"
import cors from "cors"
import bodyParser from "body-parser"

import * as db from "./db.js"


const port = 8080 || 25565
const host = '192.168.33.63' || 'localhost'

let app = express()

app.use(express.static("../client"))
app.use(cors())

let urlencodedParser  = bodyParser.urlencoded({ extended: false })
let jsonParser = bodyParser.json()

app.get("/", function(req,res) {
    res.redirect("index.html")
})

//NOTE: repertoire API
app.get("/repertoireAPI", async (req,res) => {
    const result = await db.get_all_repertoire()
    res.send(result)
})

app.get("/repertoire_filtered_API", async (req,res) => {
    const result = await db.get_all_repertoire_new()
    res.send(result)
})

app.get("/repertoireAPI/:id", async (req,res) => {
    const result = await db.get_one_repertoire(req.params.id)
    res.send(result)
})

app.post("/repertoireAPI", jsonParser, async (req,res) => {
    const result = await db.post_repertoire(req.body)
    res.send(result)
})

app.delete("/repertoireAPI/:id", async (req,res) => {
    const result = await db.delete_repertoire(req.params.id)
    res.send(result)
})

app.put("/repertoireAPI/:id", jsonParser, async (req,res) => {
    const result = await db.update_repertoire(req.params.id,req.body)
    res.send(result)
})

//NOTE: cast API
app.get("/castAPI/:id", async (req,res) => {
    const result = await db.get_cast_for(req.params.id)
    res.send(result)
})

//NOTE: billboard API
app.get("/billboardAPI", async (req,res) => {
    const result = await db.get_all_billboard()
    res.send(result)
})

app.get("/billboardAPI/:id", async (req,res) => {
    const result = await db.get_one_billboard(req.params.id)
    res.send(result)
})



app.listen(port, host, function(){
    console.log(`сервер запущен на http://${host}:${port}`)
})