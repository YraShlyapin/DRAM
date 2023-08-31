let Vue = require("vue")
let VueRouter = require("vue-router")
let VueResource = require("vue-resource")
let empty = require("./page/empty.vue")
let App = require("./page/App.vue")
let routes = require("./routes.js")

Vue.use(VueResource)
Vue.use(VueRouter)

let router = new VueRouter({
    routes: routes,
    scrollBehavior (to, from, savedPosition) {
        return { x: 0, y:0 }
    }
})

// router.beforeEach((to, from, next) => {
//     if (to.matched.some((record) => record.meta.requiresAuth)) {
//       if (!(this.$auth.isAuthenticated())) {
//         router.push({ path: '/pages/login', name: 'page-login', component: App })
//       }
//     } else {
//       next()
//     }
// })

new Vue({
    el: "#app",
    router,
    render: function(a){
        return a(empty)
    }
})