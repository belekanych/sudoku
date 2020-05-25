<template>
    <div
        class="rounded-lg card bg-gray-300 overflow-hidden"
        @keydown.prevent="onKeyDown"
    >
        <div
            v-for="(row, rowIndex) in value"
            :key="rowIndex"
            class="flex field-row"
        >
            <cell
                v-for="(col, colIndex) in row"
                :row="rowIndex"
                :col="colIndex"
                :active="active"
                :key="colIndex"
                :value="col"
                @click="onCellClick"
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

        data () {
            return {
                active: {
                    row: null,
                    col: null,
                },
            };
        },

        components: {
            Cell,
        },

        computed: {
            hasActive () {
                return this.active.row !== null && this.active.col !== null;
            },
        },

        methods: {
            onCellClick ({ row, col }) {
                this.active.row = row;
                this.active.col = col;
            },

            onKeyDown (e) {
                const keyCode = e.keyCode;

                if (keyCode >= 48 && keyCode <= 57) {
                    this.onInput(keyCode - 48);
                }

                if (keyCode === 8) {
                    this.onInput(0);
                }

                if (keyCode >= 37 && keyCode <= 40) {
                    this.onMove(e.key);
                }
            },

            onInput (value) {
                if (! this.hasActive) {
                    return;
                }

                const puzzle = this.value;
                puzzle[this.active.row][this.active.col] = value;

                this.$emit('input', puzzle);
            },

            onMove (direction) {
                switch (direction) {
                    case 'ArrowLeft':
                        this.active.col = Math.max(0, this.active.col - 1);
                        break;
                    case 'ArrowUp':
                        this.active.row = Math.max(0, this.active.row - 1);
                        break;
                    case 'ArrowRight':
                        this.active.col = Math.min(this.active.col + 1, this.value[0].length - 1);
                        break;
                    case 'ArrowDown':
                        this.active.row = Math.min(this.active.row + 1, this.value.length - 1);
                        break;
                }
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
