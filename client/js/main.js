let Vue = require("vue")
let VueRouter = require("vue-router")
let VueResource = require("vue-resource")
let empty = require("./page/empty.vue")
let routes = require("./routes.js")

let MyPlugin = require("./global_func.js")

Vue.use(MyPlugin)
Vue.use(VueResource)
Vue.use(VueRouter)

let router = new VueRouter({
    // mode: 'history',
    routes: routes,
    scrollBehavior (to, from, savedPosition) {
        return { x: 0, y:0 }
    }
})

router.beforeEach((to, from, next) => {
    if (to.meta.requiresAuth && !localStorage.authtorize) {
        console.log(to.path)
        next({name: "login", query: {nextroute: to.path}})
    } else {
        next()
    }
})

new Vue({
    el: "#app",
    router,
    render: function(a){
        return a(empty)
    }
})