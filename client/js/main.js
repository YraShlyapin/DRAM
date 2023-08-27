let Vue = require("vue")
let VueRouter = require("vue-router")
let VueResource = require("vue-resource")
// let sss = require("./page/sss.vue")  TODO: пустышка
let App = require("./page/App.vue")
let routes = require("./routes.js")

Vue.use(VueResource)
Vue.use(VueRouter)

new Vue({
    el: "#app",
    // router: new VueRouter({hashbang: false, mode: 'history', routes: routes}),
    router: new VueRouter({routes: routes, scrollBehavior (to, from, savedPosition) {
        return { x: 0, y:0 }
    }}),
    render: function(a){
        return a(App)
    }
})