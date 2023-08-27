<template>
    <div>
        <div id="repertoire_info">
            <div id="repertoire_info_wrapper">
                <div id="repertoire_info_allotted">
                    <p id="repertoire_info_title">{{ repertoire.title }}</p>
                    <p>{{ repertoire.author }}</p>
                </div>
                <p>{{ repertoire.description }}</p>
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
    </div>
</template>
<script>
    let titles = require("./samples/title.vue")

    module.exports = {
        components: {
            titles
        },
        data: function() {
            return {
                repertoire: ''
            }
        },
        methods: {
            connect_db: function() {
                this.$http.get(`/repertoireAPI/${this.$route.params['id']}`)
                    .then(function(res) {
                        this.repertoire = res.body
                    })
            }
        },
        mounted: function() {
            this.connect_db()
        },
        updated() {
            this.$nextTick(function () {
                this.connect_db()
            })
        }
    }
</script>

<!-- <div id="repertoire_item">
    <div id="repertoire_item_wrapper">
        <div id="repertoire_item_allotted">
            <p id="repertoire_item_title">КАК Я ПОЗНАКОМИЛСЯ С ОТЦОМ</p>
            <p>Джанибек Джанибекович</p>
        </div>
        <p>Пытаясь получше узнать долго отсутствующего в его жизни отца, Лука совершает длинный и непростой путь... к себе. Эта дорога без конца полна лёгких разочарований и трудных приобретений. Душевные искания и неожиданные откровения - главные спутники на этой дороге. И всё ради наполненного светлой грусти итога.</p>
    </div>
    <img src="https://dummyimage.com/1096x1065/777/000" alt="">
</div> -->