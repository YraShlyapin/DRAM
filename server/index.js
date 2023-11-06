import express from "express"
import cors from "cors"
import bodyParser from "body-parser"
import multer from "multer"
import fs from 'fs'
import path from 'path'
import 'dotenv/config'

import * as db from "./db.js"
import my_multer from "./multer.js"


const port = process.env.PORT || 8080
const host = process.env.HOST || 'localhost'

let app = express()

app.use(express.static("../client"))
app.use(cors())

let urlencodedParser  = bodyParser.urlencoded({ extended: false })
let jsonParser = bodyParser.json()

app.get("/", function(req,res) {
    res.send("index.html")
})

async function deleteEveryDay(){
    let allBillboardCheck = await db.get_all_billboard()
    let deleteBillboard = allBillboardCheck.filter(e => (new Date(e.date_time) < new Date()))
    deleteBillboard.forEach(e => db.delete_billboard(e.id_billboard))
}

let oneDay = 1000 * 60 * 60 * 1

setInterval(deleteEveryDay, oneDay)

//NOTE: image API
app.get("/imageAPI", async (req,res) => {
    const result = fs.readdirSync("../client/upload/", { withFileTypes: true })
    .filter(d => d.isFile() && d.name.indexOf('not_found') !== 0 )
    .map(d => d.name)
    res.send(result)
})

app.delete("/imageAPI/:name", async (req,res) => {
    
    fs.unlink(`../client/upload/${req.params.name}`, (err) => {
        if (err) return err
    })
    res.sendStatus(200)
})

//NOTE: gallery API
app.get("/galleryAPI", async (req,res) => {
    const result = await db.get_all_gallery()
    let obj = {}
    for (let one_result of result){
        if (one_result.title in obj){
            obj[one_result.title].push({
                image: one_result.image_gallery,
                id_gallery: one_result.id_gallery
            })
        } else{
            obj[one_result.title] = []
            obj[one_result.title].push({
                image: one_result.image_gallery,
                id_gallery: one_result.id_gallery
            })
        }
    }
    res.send(obj)
})

app.get("/galleryAPI/:id", async (req,res) => {
    const result = await db.get_gallery(req.params.id)
    if (result != ''){
        res.send(result)
    } else{
        res.sendStatus(404)
    }
    
})

app.post("/galleryAPI", my_multer.array('file'), async (req,res) => {
    let obj = req.body
    for (let file of req.files){
        obj.image = file.filename
        db.post_gallery(obj)
    }
    res.sendStatus(200)
})

app.delete("/galleryAPI", my_multer.array(), async (req,res) => {
    let gallery_ids = req.query.d.split(',')
    for (let id of gallery_ids){
        db.delete_gallery(id)
    }
    res.sendStatus(200)
})

//NOTE: repertoire API
app.get("/repertoireAPI", async (req,res) => {
    const result = await db.get_all_repertoire_new()
    res.send(result)
})

app.get("/repertoireAPI/:id", async (req,res) => {
    const result = await db.get_one_repertoire(req.params.id)
    if (result && result.is_show) {
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
    const result = await db.edite_repertoire(req.params.id, obj)
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

app.put("/personAPI/:id", my_multer.single('file'), async (req,res) => {
    let obj = req.body
    if (req.file){
        obj.image = req.file.filename
    }
    const result = await db.edite_person(req.params.id,obj)
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

app.put("/castAPI/:id", multer().array(), async (req,res) => {
    await db.edite_cast(req.params.id, req.body)
    res.send('ok')
})

app.get("/castAPI/:id", async (req,res) => {
    // const db_result = await db.get_cast_for(req.params.id)
    // if (db_result){
    //     let unique = []
    //     for (let role of db_result){
    //         if ([...unique.filter(x => x.role_person == role.role_person)].length == 0){
    //             unique.push(role)
    //         } else{
    //             let inx = unique.indexOf([...unique.filter(x => x.role_person == role.role_person)][0])
    //             let el = unique.splice(inx,1)[0]
    //             el.name = `${el.name} / ${role.name}`
    //             unique.push(el)
    //         }
    //     }
    //     res.send(unique)
    // }
    const db_result = await db.get_cast_for(req.params.id)
    res.send(db_result)
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
    console.log(result.date_time)
    console.log(typeof(result.date_time))
    if (result) {
        res.send(result)
    }else{
        res.sendStatus(404)
    }
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

//NOTE: awardsAPI
app.get("/awardsAPI", async (req,res) => {
    const result = await db.get_awards()
    if (result){
        res.send(result)
    }else {
        res.sendStatus(404)
    }
})

app.post("/awardsAPI", my_multer.single('file'), async (req,res) => {
    let obj = req.body
    obj.image = 'not_found.png'
    if (req.file){
        obj.image = req.file.filename
    }
    await db.post_awards(obj)
    res.sendStatus(200)
})

app.delete("/awardsAPI/:id", async (req,res) => {
    await db.delete_awards(req.params.id)
    res.sendStatus(200)
})

app.put("/awardsAPI/:id", my_multer.single('file'), async (req,res) => {
    let obj = req.body
    if (req.file){
        obj.image = req.file.filename
    }
    await db.edite_awards(req.params.id,obj)
    res.sendStatus(200)
})

//NOTE: newsAPI
app.get("/newsAPI", async (req,res) => {
    const result = await db.get_news()
    if (result){
        res.send(result)
    }else {
        res.sendStatus(404)
    }
})

app.post("/newsAPI", multer().array(), async (req,res) => {
    await db.post_news(req.body)
    res.sendStatus(200)
})

app.delete("/newsAPI/:id", async (req,res) => {
    await db.delete_news(req.params.id)
    res.sendStatus(200)
})

app.put("/newsAPI/:id", multer().array(), async (req,res) => {
    await db.put_news(req.body, req.params.id)
    res.sendStatus(200)
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

app.use(function(req,res) {
    res.sendFile(path.join(path.resolve(), '../client/index.html'))
})

app.listen(port, host, function(){
    console.log(`сервер запущен на http://${host}:${port}`)
})

process.on("SIGINT", () => {
    db.close()
    console.log('сервер выключен')
    process.exit()
})