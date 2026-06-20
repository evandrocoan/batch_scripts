// ==UserScript==
// @name         Remove crunchyroll simulcastcalendar dub videos
// @namespace    *
// @version      0.4
// @description  https://webapps.stackexchange.com/questions/145612/how-to-stop-the
// @author       You
//
// @include https://*crunchyroll*/simulcastcalendar*
// @require http://code.jquery.com/jquery-3.4.1.min.js
// ==/UserScript==

(function() {
    'use strict';

    // =======================================================================
    // CONFIGURATION: Languages to HIDE (dubbed versions you don't want to see)
    // Comment out or remove any language you want to KEEP
    // =======================================================================
    const languagesToHide = [
        'English',
        'Deutsch',
        'Français',
        'Español (América Latina)',
        'Español (España)',
        'Português (Brasil)',
        'Italiano',
        'Русский',
        'العربية',
        'हिंदी',
        'தமிழ்',
        'తెలుగు',
        'ไทย',
        'Bahasa Indonesia',
        // '中文 (普通话)',  // Chinese - keep this for donghua (Chinese anime)
    ];

    // Build a regex pattern to match titles ending with (Language)
    const langPattern = languagesToHide.map(lang => lang.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')).join('|');
    const dubbedRegex = new RegExp(`\\((${langPattern})\\)\\s*$`);

    let keepclosing = async () => {
        // Find all season name cite elements
        $('h1.season-name cite[itemprop="name"]').each(function() {
            let title = $(this).text().trim();

            // Check for old format " Dub)" or new format "(Language)"
            if (title.includes(' Dub)') || dubbedRegex.test(title)) {
                let parent = $(this).closest('li');
                if (parent.length) {
                    // use hide instead of remove to avoid mass flickering of the page
                    parent.hide();
                }
            }
        });
        // Deduplicate episodes that share the same group+episode but differ only by URL language code.
        // When multiple versions exist, prefer JAJP or no-suffix over other language codes.
        // If only one version exists (any code), always keep it.
        const groups = {};
        $('article.js-release').each(function() {
            const groupId = $(this).data('group-id');
            const episodeNum = $(this).data('episode-num');
            if (groupId === undefined || episodeNum === undefined) return;
            const key = `${groupId}_${episodeNum}`;
            if (!groups[key]) groups[key] = [];
            groups[key].push(this);
        });

        Object.values(groups).forEach(articles => {
            if (articles.length <= 1) return;

            const tagged = articles.map(article => {
                const link = $(article).find('a.available-episode-link').first();
                const href = link.attr('href') || '';
                const match = href.match(/\/watch\/([^/]+)\//);
                const code = match ? match[1] : null;
                const suffixMatch = code && code.match(/([A-Z]{4})$/);
                const suffix = suffixMatch ? suffixMatch[1] : null;
                return { article, code, suffix };
            });

            // Priority: JAJP or no suffix (bare ID) > any other language code
            let preferred = tagged.find(a => a.suffix === 'JAJP');
            if (!preferred) preferred = tagged.find(a => !a.suffix);
            if (!preferred) preferred = tagged[0];

            tagged.forEach(({ article }) => {
                if (article !== preferred.article) {
                    const li = $(article).closest('li');
                    if (li.length) li.hide();
                    else $(article).hide();
                }
            });
        });

        // console.log("running");
        // setTimeout(keepclosing, 500);
    }
    setTimeout(keepclosing, 1500);
})();
