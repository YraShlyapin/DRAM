<template>
    <div id="main">
        <form v-if="!edite_mode" v-on:submit="post_method" id="form">
            <select name="id_repertoire">
                <option value="" disabled selected hidden>выберить спектакль из репертуара</option>
                <option v-for="repertoire in repertoires"
                    :value="repertoire.id_repertoire"
                >
                    {{ repertoire.title }}
                </option>
            </select>
            <div id="draggble" draggable="true" @@dragover.prevent @drop.stop.prevent="onDrop">
                <img :src="srcc" @dragover.prevent @drop.stop.prevent="onDrop">
                <input type="file" name="file" id="file" accept="image/*" @change="loadPreview">
            </div>
        </form>
    </div>
</template>
<script>
    module.exports = {
        data: function() {
            return {
                srcc: "../upload/not_found.png",
                repertoires: [],
                gallery: [],
                /*edite_mode: false,
                comp_edite: {},
                id_edite: 0*/
            }
        },
        methods: {
            post_method: function(e) {
                e.preventDefault()
                let form = e.target
                if (form.id_repertoire.value == ''){
                    return
                }
                let formData = new FormData(form)
                this.$http.post("/galleryAPI", formData)
                    .then(function(res) {
                        this.connect_db()
                    })
            },
            loadPreview(){
                let sf = document.querySelector("input[type=file]").files[0]
                let self = this
                let reader = new FileReader()
                reader.onload = function(re){
                    self.srcc = re.target.result
                }
                reader.readAsDataURL(sf)
            },
            async connect_db() {
                this.$http.get("/repertoireAPI")
                    .then(function(res) {
                        this.repertoires = res.body
                    })
                this.$http.get("/galleryAPI")
                    .then(function(res) {
                        this.gallery = res.body
                    })  
            }
        },
        mounted: function() {
            this.connect_db()
        }
    }
</script>