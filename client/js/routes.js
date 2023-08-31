let App = require("./page/App.vue")
let Admin = require("./page/Admin.vue")

let repertoire = require("./components/repertoire.vue")
let person = require("./components/person.vue")
let billboard = require("./components/billboard.vue")
let main = require("./components/main.vue")

let repertoire_info = require("./components/repertoire_info.vue")
let billboard_info = require("./components/billboard_info.vue")

let a_repertoire = require("./page/components/admin/admin_repertoire.vue")
let a_person = require("./page/components/admin/admin_person.vue")
let a_billboard = require("./page/components/admin/admin_billboard.vue")

let err404 = require("./page/components/err/err404.vue")

module.exports = [
    {
        path: "/",
        component: App,
        children: [
            {path: "", component: main},
            {path: "repertoire", component: repertoire},
            {path: "billboard", component: billboard},
            {path: "persons", component: person},

            {path: "repertoire/:id", component: repertoire_info},
            {path: "billboard/:id", component: billboard_info},

        ],
        meta: { requiresAuth: false }
    },
    {
        path: "/ADMIN",
        component: Admin,
        children: [
            {path: "", component: a_repertoire},
            {path: "person", component: a_person},
            {path: "billboard", component: a_billboard},

        ],
        meta: { requiresAuth: true }
    },
    {
        path: '',
        component: App,
        children: [
            {path: "/:pathMatch(.*)*", component: err404}
        ]
    }
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