<template>
    <div class="section_name_wrapper" :class="{ mini: is_mini }">
        <p class="section_name">{{ title }}</p>
        <hr class="applicant">
    </div>
</template>
<script>
    export default {
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