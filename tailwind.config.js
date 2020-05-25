const { colors } = require('tailwindcss/defaultTheme');

module.exports = {
    theme: {
        extend: {
            colors: {
                gray: {
                    ...colors.gray,
                    '300': '#e0e5ec',
                    '500': '#a3b1c6',
                },
            },
        },
    },
};
