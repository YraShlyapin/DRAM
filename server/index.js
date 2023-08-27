let express = require("express")
let cors = require("cors")
let bodyParser = require("body-parser")
let { ObjectId } = require("mongodb")
let { MongoClient } = require("mongodb")

const port = 8080
const url = "mongodb://localhost:27017/"


let app = express()
let mongoClient = new MongoClient(url)

app.use(express.static("../client"))
app.use(cors())

let urlencodedParser  = bodyParser.urlencoded({ extended: false })
let jsonParser = bodyParser.json()

app.get("/", function(req,res) {
    res.redirect("index.html")
})

//NOTE: repertoire API
app.get("/repertoireAPI", function(req,res) {
    repertoire.find().toArray(function(err, results){
        console.log(results)
        res.send(results)
    })
})

app.post("/repertoireAPI", jsonParser, function(req,res) {
    repertoire.insertOne(req.body)
})

app.delete("/repertoireAPI/:id", function(req,res) {
    repertoire.deleteOne({ _id: ObjectId(req.params.id) })
})

app.put("/repertoireAPI/:id", jsonParser, function(req,res) {
    repertoire.updateOne({ _id: ObjectId(req.params.id) }, {$set: req.body} )
})

//NOTE: person API
app.get("/personAPI", function(req,res) {
    person.find().toArray(function(err, results){
        res.send(results)
    })
})

app.post("/personAPI", jsonParser, function(req,res) {
    person.insertOne(req.body)
})

app.delete("/personAPI/:id", function(req,res) {
    person.deleteOne({ _id: ObjectId(req.params.id) })
})

app.put("/personAPI/:id", jsonParser, function(req,res) {
    person.updateOne({ _id: ObjectId(req.params.id) }, {$set: req.body} )
})

//NOTE: billboard API
app.get("/billboardAPI", function(req,res) {
    billboard.find().toArray(function(err, results){
        res.send(results)
    })
})

app.post("/billboardAPI", jsonParser, function(req,res) {
    billboard.insertOne(req.body)
})

app.delete("/billboardAPI/:id", function(req,res) {
    billboard.deleteOne({ _id: ObjectId(req.params.id) })
})

app.put("/billboardAPI/:id", jsonParser, function(req,res) {
    billboard.updateOne({ _id: ObjectId(req.params.id) }, {$set: req.body} )
})

mongoClient.connect(function(err,client) {
    if (err) return console.log(err)

    clientMG = client

    let db = client.db("Dram")

    repertoire = db.collection("repertoire")
    person = db.collection("person")
    billboard = db.collection("billboard")

    app.listen(port, function(){
        console.log(`сервер запущен на http://localhost:${port}`)
    })
})

process.on("SIGINT", function() {
    clientMG.close()
    process.exit()
})

//fetch("/billboardAPI", {method: "POST", headers: {"Content-Type": "application/json"}, body: JSON.stringify({idRepertoire: 2,time: "2:00",date: "88.09.2023",image: "hhh"})}).then(console.log)