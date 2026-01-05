// ==UserScript==
// @name         Remove crunchyroll simulcastcalendar dub videos
// @namespace    *
// @version      0.3
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
        // console.log("running");
        // setTimeout(keepclosing, 500);
    }
    setTimeout(keepclosing, 1500);
})();
