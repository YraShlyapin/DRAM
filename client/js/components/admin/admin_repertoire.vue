<template>
    <div id="main">
        <form v-on:submit="upload">
            <input type="file" name="file" id="" accept="image/*">
            <input type="text" name="title">
            <input type="text" name="author">
            <input type="text" name="description">
            <button type="submit">asd</button>
        </form>
    </div>
</template>
<script>
    module.exports = {
        methods: {
            upload: function(e) {
                e.preventDefault()
                let form = e.target
                let formData = new FormData(form)
                this.$http.post("/saveImage", formData)
            }
        }
    }
</script>