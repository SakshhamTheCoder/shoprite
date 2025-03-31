import e from 'express';
import c from 'cors';

import { searchProducts, getProductDetails } from './flipkart/scraper.js';

const app = e();
const PORT = process.env.PORT || 3000;

app.use(c());
app.use(e.json());

app.get('/', (req, res) => {
    res.json({
        message: 'Flipkart Scraper API',
        endpoints: {
            search: '/api/search?q=query',
            product: '/api/product?url=productUrl',
        },
        disclaimer: 'This API is for educational purposes only. Not affiliated with Flipkart.',
    });
});

app.get('/api/search', async (req, res) => {
    try {
        const { q } = req.query;
        if (!q) {
            return res.status(400).json({ error: 'Query parameter "q" is required' });
        }

        const products = await searchProducts(q);
        res.json({ products });
    } catch (error) {
        console.error('Search API error:', error);
        res.status(500).json({ error: 'Failed to search products' });
    }
});

app.get('/api/product', async (req, res) => {
    try {
        const { url } = req.query;
        if (!url) {
            return res.status(400).json({ error: 'Query parameter "url" is required' });
        }

        if (!url) return res.status(400).json({ error: 'URL must be from flipkart.com' });

        const productDetails = await getProductDetails(url);
        res.json({ product: productDetails });
    } catch (error) {
        console.error('Product API error:', error);
        res.status(500).json({ error: 'Failed to get product details' });
    }
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});

