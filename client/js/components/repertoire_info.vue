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
    </div>
    <div v-else class="err404">
        Увы, но данной странички не существует<br>
        Ошибка 404
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
                repertoire: '',
                cast: '',
                cast_head: ''
            }
        },
        methods: {
            connect_db: function() {
                this.$http.get(`/repertoireAPI/${this.$route.params['id']}`)
                    .then(function(res) {
                        this.repertoire = res.body

                        this.$http.get(`/castHeadAPI/${this.$route.params['id']}`)
                            .then(function(res) {
                                this.cast_head = res.body
                            })

                        this.$http.get(`/castAPI/${this.$route.params['id']}`)
                            .then(function(res) {
                                this.cast = res.body
                            })
                    })
            }
        },
        mounted: function() {
            this.connect_db()
        },
        //updated() {
        //    this.$nextTick(function () {
        //        this.connect_db()
        //    })
        //}
    }
</script>