<template>
    <div id="footer">
        <div id="footer_first_segment" class="footer_segments">
            <img src="../image/text_full.png" alt="" width="100%">
        </div>
        <div id="footer_second_segment" class="footer_segments">
            <div>
                <p class="titl">Щедров Ярослав Олегович</p>
                <p>тел: +7 (951) 096-52-50</p>
                <p>тел: +7 (917) 611-08-67</p>
            </div>
            
            <div id="dev">
                <p class="titl">О разработчиках</p>
                <p>frontend и backend: Юрий Шляпин</p>
                <p>UX/UI дизайнер сайта: Егор Юдин</p>
            </div>
        </div>
        <div id="footer_third_segment" class="footer_segments">
            <p class="titl">Меню</p>
            <router-link to="/" class="menu_link">Главная</router-link>
            <router-link to="/billboard" class="menu_link">Афиша</router-link>
            <router-link to="/repertoire" class="menu_link">Репертуар</router-link>
            <router-link to="/persons" class="menu_link">Труппа</router-link>
            <router-link to="/contact" class="menu_link">Контакты</router-link>
        </div>
    </div>
</template>