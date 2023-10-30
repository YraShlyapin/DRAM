<template>
    <div v-if="loading">
        Загрузка...
    </div>
    <div id="main" v-else>
        <div class="viewer" v-if="billboards.length > 0">
            <div class="slider_wrapper" :style="{width: + billboards.length * 100 + 'vw'}">
                <router-link v-for="billboard in billboards"
                    class="slider"
                    :to="'/billboard/' + billboard.id_billboard"
                >
                    <div class="about_slider">
                        <p class="about_slider_title">{{ billboard.title }}
{{ billboard.author }}
{{ billboard.marker }}</p>
                        <p class="about_slider_text">
                            {{ date_format(billboard.date_time) }}
                            <br>
                            {{ billboard.place }}
                        </p>
                        <p class="about_slider_text">{{ billboard.description }}</p>

                        <p class="about_slider_more">Подробнее...</p>
                    </div>
                    <img :src="'../upload/' + billboard.image" onerror="this.src = '../upload/not_found.png'">
                </router-link>
            </div>
            <div class="nav_slider" v-if="billboards.length > 1">
                <svg @click="prev" class="prev" xmlns="http://www.w3.org/2000/svg" width="31" height="55" viewBox="0 0 42 74" fill="none">
                    <path d="M6 42C8.76142 42 11 39.7614 11 37C11 34.2386 8.76142 32 6 32L6 42ZM1.46447 33.4645C-0.488155 35.4171 -0.488155 38.5829 1.46447 40.5355L33.2843 72.3553C35.2369 74.308 38.4027 74.308 40.3553 72.3553C42.308 70.4027 42.308 67.2369 40.3553 65.2843L12.0711 37L40.3553 8.71573C42.308 6.76311 42.308 3.59728 40.3553 1.64466C38.4027 -0.307961 35.2369 -0.307961 33.2843 1.64466L1.46447 33.4645ZM6 32H5L5 42H6L6 32Z" fill="#5F0006"/>
                </svg>
                <div id="points">
                    <div v-for="(b, ind) in billboards"
                        class="point"
                        :class="{active_point: ind == 0}"
                        @click="go_to(ind)"
                    ></div>
                </div>
                <svg @click="next" class="next" xmlns="http://www.w3.org/2000/svg" width="31" height="55" viewBox="0 0 42 74" fill="none">
                    <path d="M6 42C8.76142 42 11 39.7614 11 37C11 34.2386 8.76142 32 6 32L6 42ZM1.46447 33.4645C-0.488155 35.4171 -0.488155 38.5829 1.46447 40.5355L33.2843 72.3553C35.2369 74.308 38.4027 74.308 40.3553 72.3553C42.308 70.4027 42.308 67.2369 40.3553 65.2843L12.0711 37L40.3553 8.71573C42.308 6.76311 42.308 3.59728 40.3553 1.64466C38.4027 -0.307961 35.2369 -0.307961 33.2843 1.64466L1.46447 33.4645ZM6 32H5L5 42H6L6 32Z" fill="#5F0006"/>
                </svg>
            </div>
        </div>
        <div v-else class="slidera">
            <div class="center_of_center">
                <p>В ближайшее время спектаклей нет</p>
            </div>
            <img src="../image/text_full.png">
        </div>
        
        <div id="mini_repertoire">
            <titles title="Репертуар"/>
            <div id="mini_repertoire_wrapper">
                <router-link v-for="repertoire in repertoires"
                    :key="repertoire.id_repertoire"
                    v-if="repertoire.is_show"
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
                repertoires: [],
                billboards: '',
                loading: true
            }
        },
        components: {
            titles
        },
        methods: {
            render_view: function(){
                if (this.offset < 0) {
                    this.offset = 0
                } else if (this.billboards == []) {
                    
                    this.offset = 0
                }else if (this.billboards.length == 0) {
                    this.offset = 0
                }else if (this.offset > this.billboards.length-1) {
                    this.offset = this.billboards.length - 1
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
            go_to(ind){
                this.offset = ind
                this.render_view()
            },
            async connect_db() {
                this.set_title("Главная")
                this.$http.get(`/repertoireAPI`)
                    .then(function(res) {
                        this.repertoires = res.body.slice(0,4)
                    })
                this.$http.get(`/billboardAPI`)
                    .then(function(res) {
                        this.billboards = res.body.slice(0,4)
                    })
                this.loading = false
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>