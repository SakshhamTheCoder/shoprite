import e from 'express';
import c from 'cors';

import { searchProducts as searchFlipkartProducts } from './flipkart/scraper.js';
import { searchProducts as searchAmazonProducts } from './amazon/scraper.js';

const app = e();
const PORT = process.env.PORT || 3000;

app.use(c());
app.use(e.json());

app.get('/', (req, res) => {
    res.json({
        message: 'Multi-Vendor Scraper API',
        endpoints: {
            flipkart: {
                search: '/api/flipkart/search?q=query',
            },
            amazon: {
                search: '/api/amazon/search?q=query',
            },
        },
        disclaimer: 'This API is for educational purposes only. Not affiliated with any vendor.',
    });
});

app.get('/api/flipkart/search', async (req, res) => {
    try {
        const { q } = req.query;
        if (!q) {
            return res.status(400).json({ error: 'Query parameter "q" is required' });
        }

        const products = await searchFlipkartProducts(q);
        res.json({ products });
    } catch (error) {
        console.error('Flipkart Search API error:', error);
        res.status(500).json({ error: 'Failed to search Flipkart products' });
    }
});

app.get('/api/amazon/search', async (req, res) => {
    try {
        const { q } = req.query;
        if (!q) {
            return res.status(400).json({ error: 'Query parameter "q" is required' });
        }

        const products = await searchAmazonProducts(q);
        res.json({ products });
    } catch (error) {
        console.error('Amazon Search API error:', error);
        res.status(500).json({ error: 'Failed to search Amazon products' });
    }
});

app.get('/api/search', async (req, res) => {
    try {
        const { q } = req.query;
        if (!q) {
            return res.status(400).json({ error: 'Query parameter "q" is required' });
        }

        const [flipkartProducts, amazonProducts] = await Promise.allSettled([
            searchFlipkartProducts(q),
            searchAmazonProducts(q),
        ]);

        const combinedProducts = [
            ...(flipkartProducts.status === 'fulfilled' ? flipkartProducts.value.map((product) => ({ ...product, vendor: 'Flipkart' })) : []),
            ...(amazonProducts.status === 'fulfilled' ? amazonProducts.value.map((product) => ({ ...product, vendor: 'Amazon' })) : []),
        ];

        res.json({ products: combinedProducts });
    } catch (error) {
        console.error('Search API error:', error);
        res.status(500).json({ error: 'Failed to search products across platforms' });
    }
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});

