<template>
    <div id="wrapper">
        <logo></logo>
        <menus></menus>
        <router-view></router-view>
        <footers></footers>
    </div>
</template>
<script>
    let Logo = require("./components/logo.vue")
    let Menu = require("./components/menu.vue")
    let Footer = require("./components/footer.vue")

    let ModelPerson = require("../components/person.vue")
     
    let db = require("../db/repertoire.js")

    module.exports = {
        data: function(){
            return {
                dbs: db
            }
        },
        components:{
            logo:Logo,
            menus: Menu,
            footers: Footer,

            persons: ModelPerson 
        }
    }
</script>
<style>

</style>