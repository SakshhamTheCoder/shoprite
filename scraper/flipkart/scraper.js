import axios from 'axios';
import * as cheerio from 'cheerio';

const BASE_URL = 'https://www.flipkart.com';

const headers = {
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/118.0',
    Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Upgrade-Insecure-Requests': '1',
    'Sec-Fetch-Dest': 'document',
    'Sec-Fetch-Mode': 'navigate',
    'Sec-Fetch-Site': 'none',
    'Sec-Fetch-User': '?1',
    'Sec-GPC': '1',
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

        const productName = $(el).find('a').attr('title');

        let currentPrice = null;
        let originalPrice = null;

        const original = $(el)
            .find('div:contains("₹")')
            .filter(function () {
                return $(this).css('color') === 'rgb(135, 135, 135)';
            })[1];
        originalPrice = original.text().trim();

        const current = $(el)
            .find('div:contains("₹")')
            .filter(function () {
                return $(this).find('div:contains("₹")').length === 0;
            })[0];
        currentPrice = current.text().trim();

        // if (productName && absoluteLink && thumbnail) {
        products.push({ productName, productLink: absoluteLink, thumbnail, currentPrice, originalPrice });
        // }
    });

    return products;
}

export async function getProductDetails(productUrl) {
    const response = await axios.get(productUrl, { headers });
    const $ = cheerio.load(response.data);

    const details = {
        title: $('span.B_NuCI').text().trim(),
        price: $('div._30jeq3._16Jk6d').text().trim(),
        rating: $('div._3LWZlK').first().text().trim(),
        description: $('div._1mXcCf.RmoJUa').text().trim(),
        image: $('img._396cs4').attr('src') || $('img._396cs4').attr('data-src'),
    };

    return details;
}

