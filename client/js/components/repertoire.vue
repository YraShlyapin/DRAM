<template>
    <div id="repertoire">
        <titles title="Репертуар"/>
        <div id="repertoire_wrapper">
            <router-link  v-for="(repertoire, index) in repertoires"
                :key="repertoire.id_repertoire"
                class="block_repertoire"
                :class="{revers: (index % 2 === 0)}"
                :to="'/repertoire/' + repertoire.id_repertoire"
            >
                <img :src="'../upload/' + repertoire.image" onerror="this.src = '../upload/not_found.png'">
                <!-- <img src="https://dummyimage.com/800x777/777/000" alt="" > -->
                <div class="about_repertoire">
                    <p class="about_repertoire_title">{{ repertoire.title }}</p>
                    <p class="about_repertoire_author about_repertoire_title">{{ repertoire.author }}</p>
                    <p class="description">{{ repertoire.description }}</p>
                    <p class="time">{{ time_format(repertoire.duration) }}</p>
                </div>
            </router-link>
        </div>
    </div>
</template>
<script>
    let titles = require("./samples/title.vue")

    module.exports = {
        components:{
            titles
        },
        data: function() {
            return {
                repertoires: []
            }
        },
        methods: {
            connect_db: function() {
                this.$http.get("/repertoireAPI")
                    .then(function(res) {
                        this.repertoires = res.body
                    })
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
        },
        //updated() {
        //    this.$nextTick(function () {
        //        this.connect_db()
        //    })
        //}
    }
</script>