<template>
    <button
        type="button"
        class="field-cell w-16 h-16 text-gray-600 text-lg transition duration-300 hover:bg-gray-200 focus:outline-none focus:bg-gray-200"
        @keydown="onKeyUp"
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
            value: {
                type: Number,
                default () {
                    return 0;
                },
            },
        },

        methods: {
            onKeyUp (e) {
                const keyCode = e.keyCode;

                if (keyCode >= 48 && keyCode <= 57) {
                    this.onInput(keyCode - 48);
                }

                if (keyCode === 8) {
                    this.onInput(0);
                }
            },

            onInput (value) {
                this.$emit('input', value);
            }
        },
    }
</script>

<style scoped>
</style>
