<template>
    <div>
        <div id="repertoire_info">
            <div id="repertoire_info_wrapper">
                <div id="repertoire_info_allotted">
                    <p id="repertoire_info_title">{{ billboard.title }}</p>
                    <p>{{ billboard.author }}</p>
                </div>
                <p v-for="head in cast_head">{{head.role_person}} - {{head.name}}</p>
                <p>{{ billboard.description }}</p>

                <p>{{ time_format(billboard.duration) }}</p>
            </div>
            <img :src="'../upload/' + billboard.image" onerror="this.src = '../upload/not_found.png'">
        </div>
        <titles title="Состав" v-if="cast!=''"/>
        <div id="cast">
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
        <iframe :src="billboard.src_on_map" width="1000" height="500" frameborder="0"></iframe>
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
                billboard: '',
                cast: '',
                cast_head: ''
            }
        },
        methods: {
            connect_db: function() {
                this.$http.get(`/billboardAPI/${ this.$route.params['id'] }`)
                    .then(function(res) {
                        this.billboard = res.body

                        this.$http.get(`/castHeadAPI/${this.billboard.id_repertoire}`)
                            .then(function(res) {
                                this.cast_head = res.body
                            })

                        this.$http.get(`/castAPI/${ this.billboard.id_repertoire }`)
                            .then(function(res) {
                                this.cast = res.body
                            })
                    })
            },
            date_format: function(date) {
                let formatter_Date = new Date(date)

                let day = formatter_Date.getDate()
                let month = formatter_Date.toLocaleString('ru',{month: 'long'})
                let year = formatter_Date.getFullYear()
                let weekday = formatter_Date.toLocaleString('ru',{weekday: 'long'})
                let Hours = formatter_Date.getHours()
                let minutes = formatter_Date.getMinutes()

                return `${day} ${month} ${year}, в ${Hours}:${minutes}`
            },
            time_format: function(time) {
                let str = `длительность `
                if (time > 70){
                    str += `${~~(time/60)} часов ${time%60} минут`
                } else {
                    str += `${time} минут`
                }
                return str
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>