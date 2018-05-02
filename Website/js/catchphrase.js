var sp_qoutes = [
	"<p class=&#34;lead&#34;>Enrich your life with the splendor of nature</p>",
    "<p class=&#34;lead&#34;>The earth has music for those who listen.</p>",
    "<p class=&#34;lead&#34;>Explore the Earth like nothing else.</p>",
    "<p class=&#34;lead&#34;>He is richest who is content with the least, for content is the wealth of nature.</p>",
    "<p class=&#34;lead&#34;>Taste the flavors of nature</p>"
];

var sp_quotes_index = Math.floor(Math.random() * 5); 


function random_sp_qoutes() {
	document.getElementById("catchphrase").innerHTML = sp_qoutes[sp_quotes_index];
}

window.onload = random_sp_quotes;