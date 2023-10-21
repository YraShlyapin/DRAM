<template>
    <div v-if="billboard">
        <div id="repertoire_info">
            <div id="repertoire_info_wrapper">
                <div id="repertoire_info_allotted">
                    <p id="repertoire_info_title">{{ billboard.title }}</p>
                    <p>{{ billboard.author }}</p>
                    <p>{{ billboard.marker }}</p>
                </div>
                <p v-for="head in cast_head">{{head.role_person}} - {{head.name}}<br></p>
                <p>{{ billboard.description }}</p>

                <p>Премьера - {{ date_format_first(billboard.creation_time_repertoire) }}</p>

                <p  v-if="billboard.duration">{{ time_format(billboard.duration) }}</p>
            </div>
            <img :src="'../upload/' + billboard.image" onerror="this.src = '../upload/not_found.png'">
        </div>
        <div id="gallery" ref="asd" v-show="show">
            <img v-for="image in gallery" :src="'../upload/' + image.image_gallery" alt="" class="targeter" onerror="this.src = '../upload/not_found.png'">
            <button class="more" v-show="mini" @click="show_more">Больше<br>↓</button>
            <button class="more mini" v-show="maxi" @click="show_mini">↑<br>Сжать</button>
        </div>
        <titles title="Состав" v-if="cast!=''"/>
        <div id="cast" v-if="cast!=''">
            <div v-for="person in cast"
                :key="person.id_cast"
                class="cast_wrapper"
            >
                <img :src="'../upload/' + person.image" onerror="this.src = '../upload/not_found.png'">
                <div>
                    <p>{{person.role_person}}</p>
                    <p class="name">{{person.name}}</p>
                </div>
            </div>
        </div>
        <div id="time_place">
            <titles :title="date_format(billboard.date_time)" is_mini="true"/>
            <titles :title="billboard.place" is_mini="true"/>
        </div>
        <iframe v-if="billboard.src_on_map" id="map" :src="'https://yandex.ru/map-widget/v1/?um=constructor%' + billboard.src_on_map + '&amp;source=constructor'" height="500" frameborder="0"></iframe>
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
                billboard: '',
                cast: '',
                cast_head: '',
                gallery: '',
                show: false,
                mini: false,
                maxi: false,
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
                if (this.$refs.asd.clientHeight - 120 > 510){
                    this.$refs.asd.style.setProperty('--first-height', this.$refs.asd.clientHeight - 120 + 'px')
                    this.$refs.asd.classList.add('mini')
                    this.mini = true
                }
            },
            connect_db: function(id) {
                this.$http.get(`/billboardAPI/${ id }`)
                    .then(function(res) {
                        this.billboard = res.body

                        this.set_title(this.billboard.title)

                        this.$http.get(`/galleryAPI/${this.billboard.id_repertoire}`)
                            .then((res) => {
                                this.gallery = res.body
                                this.show = true
                                setTimeout(this.ismini, 100)
                            })
                            .catch((res) => {
                            })

                        this.$http.get(`/castHeadAPI/${this.billboard.id_repertoire}`)
                            .then(function(res) {
                                this.cast_head = res.body
                            })

                        this.$http.get(`/castAPI/${ this.billboard.id_repertoire }`)
                            .then(function(res) {
                                this.cast = res.body
                            })
                    })
                    .catch((res) => {
                        this.billboard = null
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