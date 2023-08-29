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
            <img :src="'../upload/' + repertoire.image" onerror="this.src = '../upload/not_found.png'">
        </div>
        <titles title="Состав" v-if="cast!=''"/>
        <div id="cast">
            <div v-for="person in cast"
                :key="person.id_cast"
                class="cast_wrapper"
            >
                <img src="https://dummyimage.com/150x150/777/000" alt="">
                <div>
                    <p class="name">{{person.name}}</p>
                    <p>{{person.role_person}}</p>
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
                repertoire: '',
                cast: ''
            }
        },
        methods: {
            connect_db: function() {
                this.$http.get(`/repertoireAPI/${this.$route.params['id']}`)
                    .then(function(res) {
                        this.repertoire = res.body

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