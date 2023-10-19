<template>
    <div id="main">
        <form v-on:submit="post_method" id="form">
            <select name="id_repertoire">
                <option value="" disabled selected hidden>выберить спектакль из репертуара</option>
                <option v-for="repertoire in repertoires"
                    :value="repertoire.id_repertoire"
                >
                    {{ repertoire.title }}
                </option>
            </select>
            <div id="draggble" draggable="true" @@dragover.prevent @drop.stop.prevent="onDrop">
                <div v-for="(src_one, index) in srcc" class="many_img">
                    <img :src="src_one" @dragover.prevent @drop.stop.prevent="onDrop">
                    <button @click="file_edit(index)" class="del_btn" v-show="!(src_one == '../upload/not_found.png')">x</button>
                </div>
                <input type="file" name="file" id="file" accept="image/*" @change="loadPreview" ref="image_input" multiple>
            </div>
            <button type="submit">отправить</button>
        </form>
        <div>
            <div id="mini_repertoire1">
                <div v-for="(item_gallery, key_gallery) in gallery"
                    class="block_mini_repertoire"
                >
                    <div class="images_gallery">
                        <div v-for="(image, index) in item_gallery" class="wrapper_image">
                            <img :src="'../upload/' + image.image" onerror="this.src = '../upload/not_found.png'">
                            <button @click="file_delete(index, key_gallery)" class="del_btn">x</button>
                        </div>
                    </div>
                    <div>
                        <p class="mini_repertoire_title">{{ key_gallery }}</p>
                    </div>
                </div>
            </div>
        </div>
        <button @click="clear_delete" class="save_all">отмена</button>
        <button @click="save_all" class="save_all">сохранить</button>
    </div>
</template>
<script>
    module.exports = {
        data: function() {
            return {
                srcc: ["../upload/not_found.png"],
                repertoires: [],
                gallery: {},
                deleted: []
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
                        form.reset()
                        this.connect_db()
                        this.srcc = ["../upload/not_found.png"]
                    })
            },
            loadPreview(){
                let files = this.$refs.image_input.files
                let self = this
                this.srcc = []
                for (let file of files) {
                    let reader = new FileReader()
                    reader.onload = function(re){
                        self.srcc.push(re.target.result)
                    }
                    reader.readAsDataURL(file)
                }
            },
            file_edit(index) {
                let dataTransfer = new ClipboardEvent("").clipboardData || new DataTransfer()
                let all_files = [...this.$refs.image_input.files]
                all_files.splice(index, 1)
                this.srcc.splice(index, 1)
                for (let file1 of all_files){
                    dataTransfer.items.add(file1)
                }
                if (dataTransfer.files.length == 0){
                    this.srcc = ["../upload/not_found.png"]
                }
                document.querySelector("#file").files = dataTransfer.files
            },
            file_delete(ind, key_gallery) {
                this.deleted.push(this.gallery[key_gallery].splice(ind, 1))
            },
            save_all(){
                let form_data = new FormData()

                form_data.append('delete', this.deleted)

                let a = [...this.deleted.map(x => x[0]['id_gallery'])]

                this.$http.delete(`/galleryAPI?d=${a}`)
                    .then(function(res) {
                        this.connect_db()
                    })
            },
            clear_delete(){
                this.deleted = []
                this.connect_db()
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