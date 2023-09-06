<template>
    <div id="main">
        <form id="form" @submit="login">
            <input type="text" placeholder="Логин" name="username">
            <input type="password" placeholder="Пароль" name="password">
            <button type="submit">asd</button>
        </form>
    </div>
</template>
<script>
    let md5 = require('md5')

    module.exports = {
        methods:{
            login(e) {
                e.preventDefault()
                let form = e.target
                
                if (form.username.value == "Administration" && md5(form.password.value) == "4c20785f305a410495b6076454e2772c") {
                    localStorage.authtorize = true
                    this.$router.push(this.$route.query.nextroute.slice(1))
                }
            }
        }
    }
</script>