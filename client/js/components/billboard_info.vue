<template>
    <div v-if="billboard">
        <div id="repertoire_info">
            <div id="repertoire_info_wrapper">
                <div id="repertoire_info_allotted">
                    <p id="repertoire_info_title">{{ billboard.title }}</p>
                    <p>{{ billboard.author }}</p>
                </div>
                <p v-for="head in cast_head">{{head.role_person}} - {{head.name}}<br></p>
                <p>{{ billboard.description }}</p>

                <p  v-if="billboard.duration">{{ time_format(billboard.duration) }}</p>
            </div>
            <img :src="'../upload/' + billboard.image" onerror="this.src = '../upload/not_found.png'">
        </div>
        <titles title="Состав" v-if="cast!=''"/>
        <div id="cast" v-if="cast!=''">
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
                cast_head: ''
            }
        },
        methods: {
            connect_db: function(id) {
                this.$http.get(`/billboardAPI/${ id }`)
                    .then(function(res) {
                        if (res.body){
                            this.billboard = res.body

                            this.set_title(this.billboard.title)

                            this.$http.get(`/castHeadAPI/${this.billboard.id_repertoire}`)
                                .then(function(res) {
                                    this.cast_head = res.body
                                })

                            this.$http.get(`/castAPI/${ this.billboard.id_repertoire }`)
                                .then(function(res) {
                                    this.cast = res.body
                                })
                        }else {
                            this.billboard = null
                            this.set_title("Ошибка 404")
                        }
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