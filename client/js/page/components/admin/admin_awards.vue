<template>
    <div id="main">
        <form v-if="!edite_mode" v-on:submit="post_method" id="form">
            <div id="draggble" @dragover.prevent @drop.stop.prevent="onDrop">
                <img :src="srcc">
                <input type="file" ref="image_input" name="file" id="file" accept="image/*" @change="loadPreview">
            </div>
            <textarea name="description" cols="30" rows="10" placeholder="Описание награды"></textarea>
            <button type="submit">отправить</button>
        </form>
        <form v-else v-on:submit="edite_method" id="form">
            <div id="draggble" @dragover.prevent @drop.stop.prevent="onDrop">
                <img :src="srcc">
                <input type="file" ref="image_input" name="file" id="file" accept="image/*" @change="loadPreview">
            </div>
            <textarea name="description" cols="30" rows="10" placeholder="Описание награды" :value="comp_edite.description"></textarea>
            <button type="submit">отправить</button>
            <button @click="nullebl" type="button">отмена</button>
        </form>
        <div>
            <div id="mini_repertoire1">
                <div v-for="award in awards"
                    class="block_mini_repertoire"
                >
                    <img :src="'../upload/' + award.image" onerror="this.src = '../upload/not_found.png'">
                    <div>
                        <p class="mini_repertoire_text">{{ award.description }}</p>
                    </div>
                    <button @click="delete_method(award.id_awards)">удалить</button>
                    <button @click="edite_scroll(award.id_awards)">редактировать</button>
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
                awards: [],
                edite_mode: false,
                comp_edite: {},
                id_edite: 0
            }
        },
        methods: {
            delete_method(id){
                this.$http.delete(`/awardsAPI/${id}`)
                    .then(function(res) {
                        this.connect_db()
                    })
            },
            post_method: function(e) {
                e.preventDefault()
                let form = e.target
                let formData = new FormData(form)
                this.$http.post("/awardsAPI", formData)
                    .then(function(res) {
                        form.reset()
                        this.connect_db()
                        this.srcc = "../upload/not_found.png"
                    })
            },
            edite_method(e) {
                e.preventDefault()
                let form = e.target
                let formData = new FormData(form)
                this.$http.put(`/awardsAPI/${this.id_edite}`, formData)
                    .then(function(res) {
                        this.connect_db()
                        form.reset()
                        this.edite_mode = false
                        this.srcc = "../upload/not_found.png"
                    })
            },
            edite_scroll(id) {
                this.edite_mode = true
                this.comp_edite = this.awards.find(
                    (el) => {
                        return el.id_awards == id
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
            loadPreview(){
                let sf = this.$refs.image_input.files[0]
                let self = this
                let reader = new FileReader()
                reader.onload = function(re){
                    self.srcc = re.target.result
                }
                reader.readAsDataURL(sf)
            },
            async connect_db() {
                this.$http.get("/awardsAPI")
                    .then(function(res) {
                        this.awards = res.body
                    })
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>