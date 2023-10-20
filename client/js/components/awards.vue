<template>
    <div id="award">
        <titles title="Награды"/>
        <div id="award_wrapper">
            <a v-for="award in awards"
            v-if="award.image"
            :href="'../upload/' + award.image"
            download
            title="Cкачать"
            class="award_element"
        >
            <img :src="'../upload/' + award.image" alt="" title="скачать">
            <p>{{award.description}}</p>
        </a>  
        </div>  
    </div>
</template>
<script>
    let titles = require("./samples/title.vue")

    module.exports = {
        components: {
            titles
        },
        data(){
            return {
                awards: []
            }
        },
        methods: {
            connect_db(){
                this.set_title("Награды")
                this.$http.get("/awardsAPI")
                    .then(function(res) {
                        this.awards = res.body
                    })
            }
        },
        mounted(){
            this.connect_db()
        }
    }
</script>