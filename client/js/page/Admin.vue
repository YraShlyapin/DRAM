<template>
    <div>
        <menus></menus>
        <router-view></router-view>
    </div>
</template>
<script>
    let men = require("./components/admin/admin_menu.vue")

    module.exports = {
        components:{
            menus: men,
        }
    }
</script>