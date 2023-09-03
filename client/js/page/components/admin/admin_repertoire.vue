<template>
    <div id="main">
        <form v-on:submit="post_method" id="form">
            <div id="draggble" draggable="true" @@dragover.prevent @drop.stop.prevent="onDrop">
                <img :src="srcc"  @dragover.prevent @drop.stop.prevent="onDrop">
                <input type="file" name="file" id="file" accept="image/*" @change="loadPreview">
            </div>
            <input type="text" name="title" placeholder="Название">
            <input type="text" name="author" placeholder="Автор">
            <textarea name="description"  cols="30" rows="10" placeholder="Описание"></textarea>
            <input type="number" name="duration" min="0" max="255" step="1" placeholder="Длительность до 255 мин">
            <input type="datetime-local" name="creation_time_repertoire" :value="date_get()">
            <button type="submit">отправить</button>
        </form>
        <div>
            <div id="mini_repertoire1">
                <div v-for="repertoire in repertoires"
                    class="block_mini_repertoire"
                >
                    <img :src="'../upload/' + repertoire.image" onerror="this.src = '../upload/not_found.png'">
                    <div>
                        <p class="mini_repertoire_title">{{ repertoire.title }}</p>
                        <p class="mini_repertoire_title mini_repertoire_author">{{ repertoire.author }}</p>
                        <p class="mini_repertoire_text">{{ repertoire.description }}</p>
                    </div>
                    <button @click="delete_method(repertoire.id_repertoire)">удалить</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    module.exports = {
        data: function() {
            return {
                srcc: "../upload/not_found.png",
                repertoires: []
            }
        },
        methods: {
            post_method: function(e) {
                e.preventDefault()
                let form = e.target
                console.log(form)
                let formData = new FormData(form)
                this.$http.post("/repertoireAPI", formData)
                    .then(function(res) {
                        this.connect_db()
                        form.reset()
                    })
            },
            delete_method: function(id) {
                this.$http.delete(`/repertoireAPI/${id}`)
                    .then(function(res) {
                        this.connect_db()
                    })
            },
            connect_db: function() {
                this.$http.get("/repertoireAPI")
                    .then(function(res) {
                        this.repertoires = res.body
                    })
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>