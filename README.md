# Leiriplás Website Project

This project is a static website for **Leiriplás**, showcasing their plastic product catalog. It is built using **Vite**, **Vanilla JavaScript**, **CSS**, and **HTML**.

## 🏗️ Architecture

The website is a Modern Static Site (JAMstack style) that does not require a dynamic backend server to run.

-   **Frontend Framework**: None (Vanilla JS for maximum performance and simplicity).
-   **Bundler**: [Vite](https://vitejs.dev/) - handles dev server, hot reloading, and optimized production builds.
-   **Styling**: Pure CSS (`style.css`) with CSS variables for theming.
-   **Routing**: Multi-page application (`index.html` and `catalog.html`).

### 📂 Project Structure

-   `index.html`: The main landing page.
-   `catalog.html`: The products catalog page, which dynamically renders products.
-   `products.js`: The "database" for the frontend. It exports an array of product objects used by `catalog.html`.
-   `style.css`: Global styles, themes, and responsive design rules.
-   `src/assets/`: Contains static images (logo, hero background, products).
    -   `src/assets/products/`: Optimized product images.

## ⚙️ How It Works

1.  **Product Data**:
    The distinct feature of this site is that it runs off a static JSON-like structure. `products.js` contains all product data (Name, Reference, Capacity, Image Path, etc.).
    
2.  **Catalog Rendering**:
    The `catalog.html` file includes a module script that:
    -   Imports the `products` array.
    -   Extracts unique categories for the filter buttons.
    -   Renders product cards into the DOM.
    -   Uses `IntersectionObserver` to lazy-load animations (fade-in effects).

3.  **Image Optimization**:
    Images are stored locally in `src/assets/products/` to ensure fast loading and no dependency on external scrapers during runtime.

## 🚀 How to Run Locally

You need **Node.js** installed.

1.  **Install Dependencies**:
    ```bash
    npm install
    ```

2.  **Start Development Server**:
    ```bash
    npm run dev
    ```
    This will start a local server at `http://localhost:5173`. Changes to files will automatically reload the page.

## 📦 How to Deploy

Since this is a static site, it can be deployed to any static hosting provider (Netlify, Vercel, GitHub Pages, Apache, Nginx, etc.).

### 1. Build for Production

Run the build command to generate the optimized static files:

```bash
npm run build
```

This will create a `dist/` folder containing:
-   Minified HTML files.
-   Bundled and hashed CSS/JS assets.
-   Optimized images.

### 2. Deploy the `dist/` folder

-   **Netlify/Vercel**: Simply drag and drop the `dist` folder or connect your Git repository and set the build command to `npm run build` and publish directory to `dist`.
### 3. Deploy to GitHub Pages

This project is configured for automated deployment to GitHub Pages using GitHub Actions.

1.  **Initialize Git**:
    ```bash
    git init
    git add .
    git commit -m "Initial commit"
    git branch -M main
    git remote add origin https://github.com/rduquematos-debug/someplasticstore.git
    git push -u origin main
    ```

2.  **Enable GitHub Pages**:
    -   Go to your repository settings on GitHub.
    -   Navigate to "Pages".
    -   Under "Build and deployment", select "GitHub Actions" as the source.
    -   The workflow will automatically build and deploy your site.

3.  **Access the Site**:
    -   Your site will be available at: `https://rduquematos-debug.github.io/someplasticstore/`

## 🛠️ Maintenance Scripts

The project includes Python scripts for maintenance (in the root folder), though they are not needed for the live site:

-   `map_categories.py`: Helper to crawl categories (for scraping).
-   `download_images_final.py`: Helper to download images from the original site.
-   `cleanup_unused_images.py`: Removes images from assets that aren't referenced in `products.js`.

---
© 2025 Leiriplás
