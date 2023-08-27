let repertoire = require("./components/repertoire.vue")
let person = require("./components/person.vue")
let billboard = require("./components/billboard.vue")
let main = require("./components/main.vue")

let repertoire_info = require("./components/repertoire_info.vue")
let billboard_info = require("./components/billboard_info.vue")

let repertoire_a = require("./components/admin_repertoire.vue")

module.exports = [
    {path: "/", component: main},
    {path: "/repertoire", component: repertoire},
    {path: "/billboard", component: billboard},
    {path: "/persons", component: person},

    {path: "/repertoire/:id", component: repertoire_info},
    {path: "/billboard/:id", component: billboard_info},

    {path: "/ADMIN", component: repertoire_a},
    {path: "/editRepertoireAPI/:id", component: repertoire}
]

/*
TODO:
для вложенных путей
let App = require("./page/App.vue")

{   
        path: "/",
        component: App,
        children:[
            {
                path: '',
                component: repertoire
            }
        ]
    },
*/