<template>
    <div id="main">
        <form v-if="!edite_mode" v-on:submit="post_method" id="form">
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
        <form v-else v-on:submit="edite_method" id="form">
            <div id="draggble" draggable="true" @@dragover.prevent @drop.stop.prevent="onDrop">
                <img :src="srcc"  @dragover.prevent @drop.stop.prevent="onDrop">
                <input type="file" name="file" id="file" accept="image/*" @change="loadPreview">
            </div>
            <input type="text" name="title" placeholder="Название" :value="comp_edite.title">
            <input type="text" name="author" placeholder="Автор" :value="comp_edite.author">
            <textarea name="description"  cols="30" rows="10" placeholder="Описание" :value="comp_edite.description"></textarea>
            <input type="number" name="duration" min="0" max="255" step="1" placeholder="Длительность до 255 мин" :value="comp_edite.duration">
            <input type="datetime-local" name="creation_time_repertoire" :value="date_get_edite(comp_edite.creation_time_repertoire)">
            <button type="submit">отправить</button>
            <button @click="nullebl" type="button">отмена</button>
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
                    <button @click="edite_scroll(repertoire.id_repertoire)">редактировать</button>
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
                repertoires: [],
                edite_mode: false,
                comp_edite: {},
                id_edite: 0
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
                        this.srcc = "../upload/not_found.png"
                    })
            },
            delete_method: function(id) {
                this.$http.delete(`/repertoireAPI/${id}`)
                    .then(function(res) {
                        this.connect_db()
                    })
            },
            loadPreview(){
                let sf = document.querySelector("input[type='file']").files[0]
                let self = this
                let reader = new FileReader()
                reader.onload = function(re){
                    self.srcc = re.target.result
                }
                reader.readAsDataURL(sf)
            },
            edite_method(e) {
                e.preventDefault()
                let form = e.target
                console.log(form)
                let formData = new FormData(form)
                this.$http.put(`/repertoireAPI/${this.id_edite}`, formData)
                    .then(function(res) {
                        this.connect_db()
                        form.reset()
                        this.edite_mode = false
                        this.srcc = "../upload/not_found.png"
                    })
            },
            edite_scroll(id) {
                this.edite_mode = true
                this.comp_edite = this.repertoires.find(
                    (el) => {
                        return el.id_repertoire == id
                    }
                )
                this.id_edite = id

                this.srcc = '../upload/' + (this.comp_edite.image ? this.comp_edite.image : 'not_found.png')

                window.scrollTo({
                    top: 0,
                    left: 0,
                    behavior: 'smooth'
                })
            },
            nullebl(){
                this.edite_mode = false
                this.comp_edite = {}
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