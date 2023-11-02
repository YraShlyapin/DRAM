let Vue = require("vue")
let VueRouter = require("vue-router")
let VueResource = require("vue-resource")
let empty = require("./page/empty.vue")
let routes = require("./routes.js")

let MyPlugin = require("./global_func.js")

window.addEventListener('popstate', () => {
    document.querySelector('html').classList.remove('lock_person')
}, false)

Vue.use(MyPlugin)
Vue.use(VueResource)
Vue.use(VueRouter)

let router = new VueRouter({
    mode: 'history',
    routes: routes,
    scrollBehavior (to, from, savedPosition) {
        return { x: 0, y:0 }
    }
})

router.beforeEach((to, from, next) => {
    if (to.meta.requiresAuth && !localStorage.authtorize) {
        next({name: "login", query: {nextroute: to.path}})
    } else {
        next()
    }
})

Vue.config.devtools = false
Vue.config.productionTip = false

new Vue({
    el: "#app",
    router,
    render: function(a){
        return a(empty)
    }
})