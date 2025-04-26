import axios from 'axios';
import * as cheerio from 'cheerio';

const BASE_URL = 'https://www.amazon.in';

const headers = {
    'User-Agent':
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36',
    'Accept-Language': 'en-US,en;q=0.9',
    'Accept-Encoding': 'gzip, deflate, br',
    Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    Connection: 'keep-alive',
    Referer: 'https://www.amazon.in/',
    Host: 'www.amazon.in',
    TE: 'Trailers',
};

export async function searchProducts(query) {
    const url = `${BASE_URL}/s?k=${encodeURIComponent(query)}`;
    const response = await axios.get(url, { headers });
    const $ = cheerio.load(response.data);

    let products = [];

    $('div[data-component-type="s-search-result"]').each((i, el) => {
        if (i >= 10) return false;
        const productLink = $(el).find('a').attr('href');
        const absoluteLink = productLink ? `${BASE_URL}${productLink}` : '';

        const thumbnail = $(el).find('img').attr('src') || $(el).find('img').attr('data-src');

        const productName = $(el).find('h2[aria-label]').text().trim();

        let currentPrice = $(el).find('span.a-price > span.a-offscreen').first().text().trim();
        let originalPrice = $(el).find('span.a-price.a-text-price > span.a-offscreen').text().trim();

        products.push({
            productName,
            productLink: absoluteLink,
            thumbnail,
            currentPrice,
            originalPrice,
        });
    });
    return products;
}

