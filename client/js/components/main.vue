<template>
    <div id="main">
        <div class="viewer">
            <div class="slider_wrapper" style="width: 300vw;">
                <div class="slider">
                    <div class="about_slider">
                        <p class="about_slider_title">Как я познакомился с отцом Джанибек Джанибекович</p>
                        <p class="about_slider_text">1Пытаясь получше узнать долго отсутствующего в его жизни отца, Лука совершает длинный и непростой путь... к себе. Эта дорога без конца полна лёгких разочарований и трудных приобретений. Душевные искания и неожиданные откровения - главные спутники на этой дороге. И всё ради наполненного светлой грусти итога.</p>
                        <p class="about_slider_more">Подробнее...</p>
                    </div>
                    <img src="https://dummyimage.com/1096x1065/777/000" alt="">
                </div>
                <div class="slider">
                    <div class="about_slider">
                        <p class="about_slider_title">Как я познакомился с отцом Джанибек Джанибекович</p>
                        <p class="about_slider_text">2Пытаясь получше узнать долго отсутствующего в его жизни отца, Лука совершает длинный и непростой путь... к себе. Эта дорога без конца полна лёгких разочарований и трудных приобретений. Душевные искания и неожиданные откровения - главные спутники на этой дороге. И всё ради наполненного светлой грусти итога.</p>
                        <p class="about_slider_more">Подробнее...</p>
                    </div>
                    <img src="https://dummyimage.com/1096x1065/777/000" alt="">
                </div>
                <div class="slider">
                    <div class="about_slider">
                        <p class="about_slider_title">Как я познакомился с отцом Джанибек Джанибекович</p>
                        <p class="about_slider_text">3Пытаясь получше узнать долго отсутствующего в его жизни отца, Лука совершает длинный и непростой путь... к себе. Эта дорога без конца полна лёгких разочарований и трудных приобретений. Душевные искания и неожиданные откровения - главные спутники на этой дороге. И всё ради наполненного светлой грусти итога.</p>
                        <p class="about_slider_more">Подробнее...</p>
                    </div>
                    <img src="https://dummyimage.com/1096x1065/777/000" alt="">
                </div>
            </div>
            <div class="nav_slider">
                <svg @click="prev" class="prev" xmlns="http://www.w3.org/2000/svg" width="32" height="56" viewBox="0 0 42 74" fill="none">
                    <path d="M10 42C12.7614 42 15 39.7614 15 37C15 34.2386 12.7614 32 10 32V42ZM1.46447 33.4645C-0.488155 35.4171 -0.488155 38.5829 1.46447 40.5355L33.2843 72.3553C35.2369 74.308 38.4027 74.308 40.3553 72.3553C42.308 70.4027 42.308 67.2369 40.3553 65.2843L12.0711 37L40.3553 8.71573C42.308 6.76311 42.308 3.59728 40.3553 1.64466C38.4027 -0.307961 35.2369 -0.307961 33.2843 1.64466L1.46447 33.4645ZM10 32H5L5 42H10V32Z" fill="#5F0006"/>
                </svg>
                <div id="points">
                    <div class="point active_point"></div>
                    <div class="point"></div>
                    <div class="point"></div>
                </div>
                <svg @click="next" class="next" xmlns="http://www.w3.org/2000/svg" width="32" height="56" viewBox="0 0 42 74" fill="none">
                    <path d="M10 42C12.7614 42 15 39.7614 15 37C15 34.2386 12.7614 32 10 32V42ZM1.46447 33.4645C-0.488155 35.4171 -0.488155 38.5829 1.46447 40.5355L33.2843 72.3553C35.2369 74.308 38.4027 74.308 40.3553 72.3553C42.308 70.4027 42.308 67.2369 40.3553 65.2843L12.0711 37L40.3553 8.71573C42.308 6.76311 42.308 3.59728 40.3553 1.64466C38.4027 -0.307961 35.2369 -0.307961 33.2843 1.64466L1.46447 33.4645ZM10 32H5L5 42H10V32Z" fill="#5F0006"/>
                </svg>
            </div>
        </div>
        
        <div id="mini_repertoire">
            <titles title="Репертуар"/>
            <div id="mini_repertoire_wrapper">
                <router-link v-for="repertoire in repertoires"
                    :key="repertoire.id_repertoire"
                    class="block_mini_repertoire"
                    :to="'/repertoire/' + repertoire.id_repertoire"
                >
                    <img :src="'../upload/' + repertoire.image" onerror="this.src = '../upload/not_found.png'">
                    <div>
                        <p class="mini_repertoire_title">{{ repertoire.title }}</p>
                        <p class="mini_repertoire_title mini_repertoire_author">{{ repertoire.author }}</p>
                        <p class="mini_repertoire_text">{{ repertoire.description }}</p>
                    </div>
                </router-link>
            </div>
        </div>
    </div>
</template>
<script type="module">
    let titles = require("./samples/title.vue")

    module.exports = {
        data: function() {
            return {
                offset: 0,
                repertoires: '',
                billboards: ''
            }
        },
        components: {
            titles
        },
        methods: {
            render_view: function(){
                if (this.offset < 0) {
                    this.offset = 0
                } else if (this.offset > 2) {
                    this.offset = 2
                }
                document.querySelector(".slider_wrapper").style.transform = `translateX(${this.offset*-100}vw)`

                document.querySelector(".active_point").classList.remove("active_point")
                document.querySelectorAll(".point")[this.offset].classList.add("active_point")
            },
            next: function(){
                this.offset += 1
                this.render_view()
            },
            prev: function(){
                this.offset -= 1
                this.render_view()
            },
            connect_db: function() {
                this.$http.get(`/repertoireAPI`)
                    .then(function(res) {
                        this.repertoires = res.body.slice(0,4)
                    })
                this.$http.get(`/billboardAPI`)
                    .then(function(res) {
                        this.billboards = res.body
                    })
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>