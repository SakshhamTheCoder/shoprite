import axios from 'axios';
import * as cheerio from 'cheerio';

const BASE_URL = 'https://www.flipkart.com';

const headers = {
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/118.0",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
    "Accept-Language": "en-US,en;q=0.5",
    "Upgrade-Insecure-Requests": "1",
    "Sec-Fetch-Dest": "document",
    "Sec-Fetch-Mode": "navigate",
    "Sec-Fetch-Site": "none",
    "Sec-Fetch-User": "?1",
    "Sec-GPC": "1"
};

export async function searchProducts(query) {
    const searchUrl = `${BASE_URL}/search?q=${encodeURIComponent(query)}`;
    const response = await axios.get(searchUrl, { headers });
    const $ = cheerio.load(response.data);

    let products = [];

    $('div[data-id]').each((i, el) => {
        const productLink = $(el).find('a').attr('href');
        const absoluteLink = productLink ? `${BASE_URL}${productLink}` : '';

        const thumbnail = $(el).find('img').attr('src') || $(el).find('img').attr('data-src');

        const productName = $(el).find('a[title]').attr('title') || $(el).find('img[alt]').attr('alt');

        let currentPrice = null;
        let originalPrice = null;

        const current = $(el)
            .find('div:contains("₹")')
            .filter(function () {
                return $(this).find('div:contains("₹")').length === 0;
            })[0];
        currentPrice = parseFloat($(current).text().trim().replace('₹', '').replace(',', ''));

        const original = $(current).siblings('div:contains("₹")')[0];
        originalPrice = parseFloat($(original).text().trim().replace('₹', '').replace(',', ''));
        if (!originalPrice) {
            originalPrice = currentPrice;
        }

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

