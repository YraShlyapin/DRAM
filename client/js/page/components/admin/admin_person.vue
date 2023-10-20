<template>
    <div id="main">
        <form v-on:submit="post_method" id="form" v-if="!edite_mode">
            <div id="draggble" draggable="true" @@dragover.prevent @drop.stop.prevent="onDrop">
                <img :src="srcc"  @dragover.prevent @drop.stop.prevent="onDrop">
                <input type="file" name="file" id="file" accept="image/*" @change="loadPreview" ref="image">
            </div>
            <input type="text" name="name" placeholder="Имя и Фамилия">
            <textarea name="description" cols="30" rows="10" placeholder="Описание"></textarea>
            <input type="date" name="birthday" :value="date_get().split(' ')[0]">
            <div>
                <label for="real">Состоит ли в антрепризе </label>
                <input type="checkbox" name="real" checked>
            </div>
            <button type="submit">отправить</button>
        </form>
        <form v-on:submit="edite_method" id="form" ref="form_edite" v-else>
            <div id="draggble" draggable="true" @@dragover.prevent @drop.stop.prevent="onDrop">
                <img :src="srcc"  @dragover.prevent @drop.stop.prevent="onDrop">
                <input type="file" name="file" id="file" accept="image/*" @change="loadPreview" ref="image">
            </div>
            <input type="text" name="name" placeholder="Имя и Фамилия" :value="comp_edite.name">
            <textarea name="description" cols="30" rows="10" placeholder="Описание" :value="comp_edite.description"></textarea>
            <input type="date" name="birthday" :value="date_get_edite(comp_edite.birthday).split(' ')[0]">
            <div>
                <label for="real">Состоит ли в антрепризе </label>
                <input type="checkbox" name="real" :checked="comp_edite.real">
            </div>
            <button type="submit">отправить</button>
            <button @click="nullebl" type="button">отмена</button>
        </form>
        <div>
            <div id="mini_repertoire1">
                <div v-for="person in persons"
                    class="block_mini_repertoire"
                >
                    <img :src="'../upload/' + person.image" onerror="this.src = '../upload/not_found.png'">
                    <div>
                        <p class="mini_repertoire_title">{{ person.name }}</p>
                        <p class="mini_repertoire_title mini_repertoire_author">{{ birthday(person.birthday) }}</p>
                        <p class="mini_repertoire_text">{{ person.description }}</p>
                        <p>{{ person.real === 1 ? "участник антрепризы" : "не участник антрепризы" }}</p>
                    </div>
                    <button @click="delete_method(person.id_person)">удалить</button>
                    <button @click="edite_scroll(person.id_person)">редактировать</button>
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
                persons: [],
                edite_mode: false,
                comp_edite: {},
                id_edite: 0
            }
        },
        methods: {
            post_method: function(e) {
                e.preventDefault()
                let form = e.target
                let formData = new FormData(form)
                this.$http.post("/personAPI", formData)
                    .then(function(res) {
                        this.connect_db()
                        form.reset()
                        this.srcc = "../upload/not_found.png"
                    })
            },
            loadPreview(){
                if (this.edite_mode){
                    let formData = new FormData(this.$refs.form_edite)
                    let form_obj = {}
                    formData.forEach((val, key) => {
                        form_obj[key] = val
                    })
                    this.comp_edite = form_obj
                }
                let sf = this.$refs.image.files[0]
                let self = this
                let reader = new FileReader()
                reader.onload = function(re){
                    self.srcc = re.target.result
                }
                reader.readAsDataURL(sf)
            },
            delete_method: function(id) {
                this.$http.delete(`/personAPI/${id}`)
                    .then(function(res) {
                        this.connect_db()
                    })
            },
            birth(date){
                return new Date(date).toISOString().split('T')[0]
            },
            edite_method(e) {
                e.preventDefault()
                let form = e.target
                let formData = new FormData(form)
                this.$http.put(`/personAPI/${this.id_edite}`, formData)
                    .then(function(res) {
                        this.connect_db()
                        form.reset()
                        this.edite_mode = false
                        this.srcc = "../upload/not_found.png"
                    })
            },
            edite_scroll(id) {
                this.edite_mode = true
                this.comp_edite = this.persons.find(
                    (el) => {
                        return el.id_person == id
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
                this.$http.get("/personAllAPI")
                    .then(function(res) {
                        this.persons = res.body
                    })
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>