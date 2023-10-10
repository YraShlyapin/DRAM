<template>
    <div id="menu">
        <div class="hamburger" @click="activate"><span></span></div>
        <div id="menu_wrapper" @click="activate">
            <router-link to="/main" class="menu_link">Главная</router-link>
            <router-link to="/billboard" class="menu_link">Афиша</router-link>
            <router-link to="/repertoire" class="menu_link">Репертуар</router-link>
            <router-link to="/persons" class="menu_link">Труппа</router-link>
            <router-link to="/contact" class="menu_link">Новости</router-link>
            <router-link to="/contact" class="menu_link">Награды</router-link>
            <router-link to="/contact" class="menu_link">Контакты</router-link>
            <div id="menu_social_wrapper">
                <svg width="35" height="35" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill="#EFEBE9" class="change_color" fill-rule="evenodd" clip-rule="evenodd" d="M2.8 2.8C0 5.62667 0 10.1467 0 19.2V20.8C0 29.84 0 34.36 2.8 37.2C5.62667 40 10.1467 40 19.2 40H20.8C29.84 40 34.36 40 37.2 37.2C40 34.3733 40 29.8533 40 20.8V19.2C40 10.16 40 5.64 37.2 2.8C34.3733 0 29.8533 0 20.8 0H19.2C10.16 0 5.64 0 2.8 2.8ZM6.74666 12.1733C6.96 22.5733 12.16 28.8133 21.28 28.8133H21.8133V22.8667C25.16 23.2 27.6933 25.6533 28.7067 28.8133H33.44C32.9545 27.0177 32.0939 25.3454 30.9149 23.9067C29.7359 22.4679 28.2652 21.2955 26.6 20.4667C28.0922 19.558 29.381 18.3513 30.3858 16.922C31.3906 15.4928 32.0899 13.8717 32.44 12.16H28.1467C27.2133 15.4667 24.44 18.4667 21.8133 18.7467V12.1733H17.5067V23.6933C14.84 23.0267 11.48 19.8 11.3333 12.1733H6.74666Z"/>
                </svg>
                <svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="40" height="40" viewBox="0 0 50 50">
                    <path fill="#EFEBE9" class="change_color" d="M25,2c12.703,0,23,10.297,23,23S37.703,48,25,48S2,37.703,2,25S12.297,2,25,2z M32.934,34.375	c0.423-1.298,2.405-14.234,2.65-16.783c0.074-0.772-0.17-1.285-0.648-1.514c-0.578-0.278-1.434-0.139-2.427,0.219	c-1.362,0.491-18.774,7.884-19.78,8.312c-0.954,0.405-1.856,0.847-1.856,1.487c0,0.45,0.267,0.703,1.003,0.966	c0.766,0.273,2.695,0.858,3.834,1.172c1.097,0.303,2.346,0.04,3.046-0.395c0.742-0.461,9.305-6.191,9.92-6.693	c0.614-0.502,1.104,0.141,0.602,0.644c-0.502,0.502-6.38,6.207-7.155,6.997c-0.941,0.959-0.273,1.953,0.358,2.351	c0.721,0.454,5.906,3.932,6.687,4.49c0.781,0.558,1.573,0.811,2.298,0.811C32.191,36.439,32.573,35.484,32.934,34.375z"></path>
                </svg>                   
            </div>
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