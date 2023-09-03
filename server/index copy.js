import express from "express"
import cors from "cors"
import bodyParser from "body-parser"
import multer from "multer"

import * as db from "./db.js"
import my_multer from "./multer.js"


const port = 8080 || 25565
const host = 'localhost' || '192.168.33.63'

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
    const result = await db.get_all_repertoire_new()
    res.send(result)
})

app.get("/repertoireAPI/:id", async (req,res) => {
    const result = await db.get_one_repertoire(req.params.id)
    if (result) {
        res.send(result)
    }else{
        res.sendStatus(404)
    }
})

app.post("/repertoireAPI", my_multer.single('file'), async (req,res) => {
    let obj = req.body
    obj.image = 'not_found.png'
    if (req.file){
        obj.image = req.file.filename
    }
    const result = await db.post_repertoire(obj)
    res.send(result)
})

app.delete("/repertoireAPI/:id", async (req,res) => {
    const result = await db.delete_repertoire(req.params.id)
    res.send(result)
})

app.put("/repertoireAPI/:id", my_multer.single('file'), async (req,res) => {
    let obj = req.body
    if (req.file){
        obj.image = req.file.filename
    }
    const result = await db.update_repertoire(req.params.id, obj)
    res.send(result)
})

//NOTE: person API
app.get("/personAPI", async (req,res) => {
    const result = await db.get_real_person()
    res.send(result)
})

app.get("/personAllAPI", async (req,res) => {
    const result = await db.get_all_person()
    res.send(result)
})

app.post("/personAPI", my_multer.single('file'), async (req,res) => {
    let obj = req.body
    obj.image = 'not_found.png'
    if (req.file){
        obj.image = req.file.filename
    }
    const result = await db.post_person(obj)
    res.send(result)
})

app.delete("/personAPI/:id", async (req,res) => {
    const result = await db.delete_person(req.params.id)
    res.send(result)
})

//NOTE: cast API
app.get("/castAPI", async (req,res) => {
    const result = await db.get_all_cast()
    res.send(result)
})

app.post("/castAPI", multer().array(), async (req,res) => {
    await db.post_cast(req.body)
    res.send('ok')
})

app.delete("/castAPI/:id", async (req,res) => {
    await db.delete_cast(req.params.id)
    res.send('ok')
})

app.get("/castAPI/:id", async (req,res) => {
    const result = await db.get_cast_for(req.params.id)
    res.send(result)
})

app.get("/castHeadAPI/:id", async (req,res) => {
    const result = await db.get_cast_head_for(req.params.id)
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

app.post("/billboardAPI", multer().array(), async (req,res) => {
    let obj = req.body
    if (obj.src_on_map.includes('https')) {
        let url = obj.src_on_map.split('?um=constructor%')[1].split('&source=')[0]
        obj.src_on_map = url
    }
    const result = await db.post_billboard(obj)
    res.send(result)
})

app.put("/billboardAPI/:id", multer().array(), async (req,res) => {
    let obj = req.body
    if (obj.src_on_map.includes('https')) {
        let url = obj.src_on_map.split('?um=constructor%')[1].split('&source=')[0]
        obj.src_on_map = url
    }
    const result = await db.edite_billboard(req.params.id, obj)
    res.send(result)
})

app.delete("/billboardAPI/:id", async (req,res) => {
    const result = await db.delete_billboard(req.params.id)
    res.send(result)
})

/*app.post("/upload", multer.single('file'), async (req,res) => {
    let obj = req.body
    if (req.file){
        obj.image = req.file.filename
    }
    const result = await db.post_repertoire(obj)
    res.send(result)
})*/

app.post("/saveImage", my_multer.single('file'), async (req,res) => {
    if (req.file){
        console.log(req.file.filename)
    }
})

app.listen(port, host, function(){
    console.log(`сервер запущен на http://${host}:${port}`)
})