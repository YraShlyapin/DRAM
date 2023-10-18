let App = require("./page/App.vue")
let Admin = require("./page/Admin.vue")

let main = require("./components/main.vue")
let repertoire = require("./components/repertoire.vue")
let billboard = require("./components/billboard.vue")
let person = require("./components/person.vue")
let news = require("./components/news.vue")
let awards = require("./components/awards.vue")
let contact = require("./components/contact.vue")

let repertoire_info = require("./components/repertoire_info.vue")
let billboard_info = require("./components/billboard_info.vue")

let login = require("./page/components/login.vue")

let a_repertoire = require("./page/components/admin/admin_repertoire.vue")
let a_person = require("./page/components/admin/admin_person.vue")
let a_billboard = require("./page/components/admin/admin_billboard.vue")
let a_cast = require("./page/components/admin/admin_cast.vue")
let a_awards = require("./page/components/admin/admin_awards.vue")
let a_gallery = require("./page/components/admin/admin_gallery.vue")
let a_image = require("./page/components/admin/all_image.vue")

let err404 = require("./page/components/err/err404.vue")

module.exports = [
    {
        path: "/",
        component: App,
        children: [
            {path: "", redirect: {name: "MAIN"}},
            {path: "main", name: "MAIN", component: main},
            {path: "repertoire", component: repertoire},
            {path: "billboard", component: billboard},
            {path: "persons", component: person},
            {path: "news", component: news},
            {path: "awards", component: awards},
            {path: "contact", component: contact},

            {path: "repertoire/:id", component: repertoire_info},
            {path: "billboard/:id", component: billboard_info},

            {path: 'login', name: 'login', component: login}

        ],
    },
    {
        path: "/ADMIN",
        component: Admin,
        children: [
            {path: "", redirect: {name: "ADMINrepertoire"}, meta: { requiresAuth: true }},
            {path: "repertoire", name: "ADMINrepertoire", component: a_repertoire, meta: { requiresAuth: true }},
            {path: "person", component: a_person, meta: { requiresAuth: true }},
            {path: "billboard", component: a_billboard, meta: { requiresAuth: true }},
            {path: "cast", component: a_cast, meta: { requiresAuth: true }},
            {path: "awards", component: a_awards, meta: { requiresAuth: true }},
            {path: "gallery", component: a_gallery, meta: { requiresAuth: true }},
            {path: "images", component: a_image, meta: { requiresAuth: true }},
        ],
    },
    {
        path: '',
        component: App,
        children: [
            {path: "/:pathMatch(.*)*", component: err404}
        ],
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