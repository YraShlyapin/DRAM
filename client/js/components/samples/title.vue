<template>
    <div class="section_name_wrapper">
        <p class="section_name">{{ title }}</p>
        <hr class="applicant" :class="{ mini: is_mini }">
    </div>
</template>
<script>
    module.exports = {
        props: {
            title: {
                type: String,
            },
            is_mini: {
                default: false
            }
        },
    }
</script>