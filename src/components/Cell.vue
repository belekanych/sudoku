<template>
    <button
        type="button"
        class="field-cell w-16 h-16 text-gray-600 text-lg transition duration-300 hover:bg-gray-200 focus:outline-none"
        :class="{ 'bg-gray-200': isActive }"
        @click="onClick"
    >
        {{ value || '' }}
    </button>
</template>

<script>
    export default {
        /**
         * Component name.
         */
        name: "Cell",

        props: {
            active: {
                type: Object,
                default () {
                    return {};
                },
            },

            row: {
                type: Number,
                required: true,
            },

            col: {
                type: Number,
                required: true,
            },

            value: {
                type: Number,
                default () {
                    return 0;
                },
            },
        },

        computed: {
            isActive () {
                return this.active.row === this.row && this.active.col === this.col;
            },
        },

        methods: {
            onClick () {
                this.$emit('click', {
                    row: this.row,
                    col: this.col,
                });
            },
        },
    }
</script>

<style scoped>
</style>
