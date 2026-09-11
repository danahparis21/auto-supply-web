import defaultTheme from 'tailwindcss/defaultTheme';
import forms from '@tailwindcss/forms';

/** @type {import('tailwindcss').Config} */
export default {
    darkMode: 'class',

    content: [
        './vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php',
        './storage/framework/views/*.php',
        './resources/views/**/*.blade.php',
    ],

    theme: {
        extend: {
            fontFamily: {
                sans: ['Plus Jakarta Sans', ...defaultTheme.fontFamily.sans],
                mono: ['JetBrains Mono', ...defaultTheme.fontFamily.mono],
            },
            colors: {
                brand: {
                    50:  '#fff1f1',
                    100: '#ffe0e0',
                    200: '#ffc5c5',
                    300: '#ff9d9d',
                    400: '#ff6464',
                    500: '#f83535',
                    600: '#e51313',
                    700: '#c20d0d',
                    800: '#a00f0f',
                    900: '#841414',
                    950: '#480505',
                },
            },
        },
    },

    plugins: [forms],
};
