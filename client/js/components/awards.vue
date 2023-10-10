<template>
    <div id="award">
        <a v-for="award in awards"
            v-if="award.image"
            :href="'../upload/' + award.image"
            download
            title="Cкачать"
            class="award_element"
        >
            <img :src="'../upload/' + award.image" alt="">
            <p>{{award.description}}</p>
        </a>        
    </div>
</template>
<script>
    module.exports = {
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