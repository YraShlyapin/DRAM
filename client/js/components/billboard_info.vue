<template>
    <div>
        <div id="repertoire_info">
            <div id="repertoire_info_wrapper">
                <div id="repertoire_info_allotted">
                    <p id="repertoire_info_title">КАК Я ПОЗНАКОМИЛСЯ С ОТЦОМ</p>
                    <p>Джанибек Джанибекович</p>
                </div>
                <p>Пытаясь получше узнать долго отсутствующего в его жизни отца, Лука совершает длинный и непростой путь... к себе. Эта дорога без конца полна лёгких разочарований и трудных приобретений. Душевные искания и неожиданные откровения - главные спутники на этой дороге. И всё ради наполненного светлой грусти итога.</p>
            </div>
            <img src="https://dummyimage.com/1096x1065/777/000" alt="">
        </div>
        <titles title="Состав"/>
        <div id="cast">
            <div class="cast_wrapper">
                <img src="https://dummyimage.com/150x150/777/000" alt="">
                <div>
                    <p class="name">Матвей Семагин</p>
                    <p>Отец отца</p>
                </div>
            </div>
            <div class="cast_wrapper">
                <img src="https://dummyimage.com/150x150/777/000" alt="">
                <div>
                    <p class="name">Матвей Семагин</p>
                    <p>Отец отца</p>
                </div>
            </div>
            <div class="cast_wrapper">
                <img src="https://dummyimage.com/150x150/777/000" alt="">
                <div>
                    <p class="name">Матвей Семагин</p>
                    <p>Отец отца</p>
                </div>
            </div>
            <div class="cast_wrapper">
                <img src="https://dummyimage.com/150x150/777/000" alt="">
                <div>
                    <p class="name">Матвей Семагин</p>
                    <p>Отец отца</p>
                </div>
            </div>
            <div class="cast_wrapper">
                <img src="https://dummyimage.com/150x150/777/000" alt="">
                <div>
                    <p class="name">Матвей Семагин</p>
                    <p>Отец отца</p>
                </div>
            </div>
            <div class="cast_wrapper">
                <img src="https://dummyimage.com/150x150/777/000" alt="">
                <div>
                    <p class="name">Матвей Семагин</p>
                    <p>Отец отца</p>
                </div>
            </div>
        </div>
        <div id="time_place">
            <titles title="29 Февраля 25:99" is_mini="true"/>
            <titles title="ул. Ленина 78, Квартал" is_mini="true"/>
        </div>
        <iframe src="https://yandex.ru/map-widget/v1/?um=constructor%3Ae9b9fb91d381c327105aefacfae0dd342eeb6ee2336488891e223bea1d2edec3&amp;source=constructor" width="1000" height="500" frameborder="0"></iframe>
    </div>
</template>
<script>
    let titles = require("./samples/title.vue")

    module.exports = {
        components: {
            titles
        }
    }
</script>