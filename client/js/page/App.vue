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

    module.exports = {
        data: function(){
            return {
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