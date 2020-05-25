<template>
    <div class="h-screen flex flex-col w-full h-full items-center justify-center bg-gray-300">
        <field
            :value="puzzle"
            @input="onInput"
        />
        <button
            class="card text-gray-600 mt-10 rounded-lg py-4 px-6"
            @click="solve"
        >Solve</button>
    </div>
</template>

<script>
    import Field from "./Field";

    export default {
        /**
         * Component name.
         */
        name: "Game",

        /**
         * Registered components.
         */
        components: {
            Field,
        },

        data () {
            return {
                size: 9,
                puzzle: [],
                errors: [],
            };
        },

        created () {
            this.puzzle = this.generateEmptyPuzzle(this.size);
        },

        methods: {
            generateEmptyPuzzle (size) {
                const puzzle = [];

                for (let rowIndex = 0; rowIndex < size; rowIndex++) {
                    const row = [];

                    for (let colIndex = 0; colIndex < size; colIndex++) {
                        row.push(0); // set zero as an empty value
                    }

                    puzzle.push(row);
                }

                return puzzle;
            },

            onInput (puzzle) {
                puzzle.forEach((row, index) => {
                    this.$set(this.puzzle, index, row);
                });
            },

            solve () {
                const solution = this.solvePuzzle(this.puzzle);

                if (solution) {
                    this.onInput(solution);
                } else {
                    console.error('Solution is not found!');
                }
            },

            solvePuzzle (puzzle) {
                let solution = [];
                puzzle.forEach(row => {
                    solution.push([...row]);
                });

                for (let row = 0; row < puzzle.length; row++) {
                    for (let col = 0; col < puzzle[row].length; col++) {
                        if (solution[row][col]) {
                            continue;
                        }

                        let valid = false;

                        for (let option = 1; option <= 9; option++) {
                            solution[row][col] = option;

                            if (! this.isCellValid(solution, row, col)) {
                                continue;
                            }

                            const nextSolution = this.solvePuzzle(solution);
                            if (nextSolution) {
                                solution = nextSolution;
                                valid = true;
                                break;
                            } else {
                                valid = false;
                            }
                        }

                        if (! valid) {
                            return null;
                        }
                    }
                }

                return solution;
            },

            isPuzzleValid (puzzle) {
                for (let row = 0; row < puzzle.length; row++) {
                    for (let col = 0; col < puzzle[row].length; col++) {
                        if (! this.isCellValid(puzzle, row, col)) {
                            return false;
                        }
                    }
                }

                return true;
            },

            isCellValid (puzzle, row, col) {
                return this.isRowValid(puzzle, row)
                    && this.isColValid(puzzle, col)
                    && this.isSubGridValid(puzzle, row, col);
            },

            isRowValid (puzzle, row) {
                const unique = {};

                for (let col = 0; col < puzzle[row].length; col++) {
                    const value = puzzle[row][col];

                    if (value && Object.prototype.hasOwnProperty.call(unique, value)) {
                        return false;
                    }

                    unique[value] = value;
                }

                return true;
            },

            isColValid (puzzle, col) {
                const unique = {};

                for (let row = 0; row < puzzle.length; row++) {
                    const value = puzzle[row][col];

                    if (value && Object.prototype.hasOwnProperty.call(unique, value)) {
                        return false;
                    }

                    unique[value] = value;
                }

                return true;
            },

            isSubGridValid (puzzle, row, col) {
                const unique = {};

                const rowStart = row - row % 3;
                const colStart = col - col % 3;

                for (let rowIndex = 0; rowIndex < 3; rowIndex++) {
                    for (let colIndex = 0; colIndex < 3; colIndex++) {
                        const value = puzzle[rowStart + rowIndex][colStart + colIndex];

                        if (value && Object.prototype.hasOwnProperty.call(unique, value)) {
                            return false;
                        }

                        unique[value] = value;
                    }
                }

                return true;
            },
        },
    }
</script>

<style scoped>

</style>
