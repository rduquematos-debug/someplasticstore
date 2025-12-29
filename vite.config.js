import { defineConfig } from 'vite'
import { resolve } from 'path'

export default defineConfig({
    base: '/someplasticstore/',
    build: {
        rollupOptions: {
            input: {
                main: resolve(__dirname, 'index.html'),
                catalog: resolve(__dirname, 'catalog.html'),
            },
        },
    },
})
