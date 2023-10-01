<template>
    <div v-if="repertoire">
        <div id="repertoire_info">
            <div id="repertoire_info_wrapper">
                <div id="repertoire_info_allotted">
                    <p id="repertoire_info_title">{{ repertoire.title }}</p>
                    <p>{{ repertoire.author }}</p>
                </div>
                <p v-for="head in cast_head">{{head.role_person}} - {{head.name}}</p>
                <p>{{ repertoire.description }}</p>

                <p  v-if="repertoire.duration">{{ time_format(repertoire.duration) }}</p>
            </div>
            <img :src="'../upload/' + repertoire.image" onerror="this.src = '../upload/not_found.png'">
        </div>
        <div id="gallery" ref="asd" v-show="show">
            <img v-for="image in gallery" :src="'../upload/' + image.image" alt="">
            <button class="more" v-show="mini" @click="show_more">Больше<br>↓</button>
            <button class="more mini" v-show="maxi" @click="show_mini">↑<br>Сжать</button>
        </div>
        <titles title="Состав" v-if="cast!=''"/>
        <div id="cast" v-if="cast != ''">
            <div v-for="person in cast"
                :key="person.id_cast"
                class="cast_wrapper"
            >
            <img :src="'../upload/' + person.image" onerror="this.src = '../upload/not_found.png'">
                <div>
                    <p class="name">{{person.name}}</p>
                    <p>{{person.role_person}}</p>
                </div>
            </div>
        </div>
    </div>
    <err404 v-else/>
</template>
<script>
    let err404 = require("../page/components/err/err404.vue")
    let titles = require("./samples/title.vue")

    module.exports = {
        components: {
            titles,
            err404
        },
        data: function() {
            return {
                repertoire: '',
                gallery: '',
                cast: '',
                cast_head: '',
                show: false,
                mini: false,
                maxi: false
            }
        },
        methods: {
            show_mini(){
                this.$refs.asd.classList.remove('activety')
                this.$refs.asd.classList.add('disactivety')
                this.$refs.asd.classList.add('mini')
                this.maxi = false
                this.mini = true
            },
            show_more(){
                this.$refs.asd.classList.remove('disactivety')
                this.$refs.asd.classList.remove('mini')
                this.$refs.asd.classList.add('activety')
                this.mini = false
                this.maxi = true
            },
            ismini() {
                if (this.$refs.asd.clientHeight - 100 > 510){
                    this.$refs.asd.style.setProperty('--first-height', this.$refs.asd.clientHeight - 100 + 'px')
                    this.$refs.asd.classList.add('mini')
                    this.mini = true
                }
            },
            connect_db: function(id) {
                this.$http.get(`/repertoireAPI/${id}`)
                    .then(function(res) {
                        this.repertoire = res.body
                        this.set_title(this.repertoire.title)

                        this.$http.get(`/galleryAPI/${id}`)
                            .then((res) => {
                                this.gallery = res.body
                                this.show = true
                                setTimeout(this.ismini, 100)
                            })

                        this.$http.get(`/castHeadAPI/${id}`)
                            .then(function(res) {
                                this.cast_head = res.body
                            })

                        this.$http.get(`/castAPI/${id}`)
                            .then(function(res) {
                                this.cast = res.body
                            })
                    })
                    .catch((res) => {
                        this.repertoire = null
                        this.set_title("Ошибка 404")
                    })
            }
        },
        mounted() {
            this.connect_db(this.$route.params['id'])
        },
        beforeRouteUpdate(to, from, next)  {
            this.connect_db(to.params.id)
            next()
        }
    }
</script>