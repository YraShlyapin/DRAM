<template>
    <div id="menu">
        <div class="hamburger" @click="activate"><span></span></div>
        <div id="menu_wrapper" @click="activate">
            <router-link to="/" class="menu_link">На Главную</router-link>
            <router-link to="/ADMIN/repertoire" class="menu_link">Репертуар</router-link>
            <router-link to="/ADMIN/person" class="menu_link">Труппа</router-link>
            <router-link to="/ADMIN/cast" class="menu_link">Состав</router-link>
            <router-link to="/ADMIN/billboard" class="menu_link">Афиша</router-link>
            <router-link to="/ADMIN/gallery" class="menu_link">Галлерея</router-link>
            <router-link to="/ADMIN/awards" class="menu_link">Награды</router-link>
            <router-link to="/ADMIN/news" class="menu_link">Новости</router-link>
            <router-link to="/ADMIN/images" class="menu_link">Картинки</router-link>
        </div>
    </div>
</template>
<script>
    module.exports = {
        methods: {
            activate: function(){
                if (window.innerWidth <= 1290){
                    document.querySelector("html").classList.toggle("lock")
                    document.querySelector("#menu_wrapper").classList.toggle("activate")
                }
            }
        }
    }
</script>