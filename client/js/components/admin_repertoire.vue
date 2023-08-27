<template>
    <div id="main">
        <p id="title">Репертуар</p>
        <hr id="applicant">
        <div id="content">
            <div v-for="(repertoire, index) in repertoires"
                :key="repertoire._id"
                class="block_repertoire"
                :class="{revers: (index % 2 === 0)}"
            >
                <img :src="repertoire.image" alt="" >
                <div class="about">
                    <p class="title-repertoire">{{ repertoire.title }}</p>
                    <p class="author-repertoire">{{ repertoire.author }}</p>
                    <p class="description">{{ repertoire.description }}</p>
                    <p>{{ repertoire.time }}</p>
                    <button v-on:click="deleted(repertoire._id)">удалить</button>
                    <router-link :to="'/editRepertoireAPI/'+reperoire._id">редактировать</router-link>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    module.exports = {
        data: function() {
            return {
                repertoires: []
            }
        },
        methods: {
            deleted: function(id) {
                fetch(`/repertoireAPI/${id}`, {method: "DELETE"}).then(console.log)
            },
            connect_db: function() {
                this.$http.get("/repertoireAPI")
                    .then(function(res) {
                        this.repertoires = res.body
                    })
            },
        },
        mounted: function() {
            this.connect_db()
        },
    }
</script>