<template>
    <div class="rounded-lg card bg-gray-300 overflow-hidden">
        <div
            v-for="(row, rowIndex) in value"
            :key="rowIndex"
            class="flex field-row"
        >
            <cell
                v-for="(col, colIndex) in row"
                :key="colIndex"
                :value="col"
                @input="cellValue => onInput(rowIndex, colIndex, cellValue)"
            />
        </div>
    </div>
</template>

<script>
    import Cell from "./Cell";

    export default {
        /**
         * Component name.
         */
        name: "Field",

        props: {
            value: {
                type: Array,
                required: true,
            },
        },

        components: {
            Cell,
        },

        methods: {
            onInput (row, col, value) {
                const puzzle = this.value;
                puzzle[row][col] = value;

                this.$emit('input', puzzle);
            },
        },
    }
</script>

<style scoped>
    .field-row .field-cell {
        @apply border border-gray-200 box-content;
    }

    .field-row .field-cell:nth-child(3n) {
        @apply border-r-8;
    }

    .field-row:nth-child(3n) .field-cell {
        @apply border-b-8;
    }

    .field-row .field-cell:first-child {
        @apply border-l-0;
    }

    .field-row .field-cell:last-child {
        @apply border-r-0;
    }

    .field-row:first-child .field-cell {
        @apply border-t-0;
    }

    .field-row:last-child .field-cell {
        @apply border-b-0;
    }
</style>
