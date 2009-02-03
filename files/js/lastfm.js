// Use these variables to control the user and number of albums displayed
var user = 'mdreid';
var limit = 8;
var coverwidth = 50;

// Do it!
$(document).ready(function(){
	var albumChartUrl = 'http://ws.audioscrobbler.com/2.0/?method=user.getweeklyalbumchart&user='+user+'&api_key=0853bfe04f9fe29c51fc7081fe1c4266&format=json&callback=?';
	$.getJSON(albumChartUrl, function(data) {
		$.each(data.weeklyalbumchart.album, function(i,item){
			// Only process the first `limit` items
			if(i >= limit) { return };

			// Put a placeholder list item in, identified by album rank
			var rank 	= item.rank;
			$("<a>").attr("id", "lastfm-"+rank).appendTo("#lastfm");

			// Build the call to get the album art
			var album 		= item.name;
			var artist	 	= item.artist["#text"];
			var playcount 	= item.playcount;
			
			var albumInfoUrl = 'http://ws.audioscrobbler.com/2.0/?method=album.getInfo&artist='+artist+'&album='+album+'&api_key=0853bfe04f9fe29c51fc7081fe1c4266&format=json&callback=?';
			$.getJSON(albumInfoUrl, function(info){
				var url 	= info.album.url;
				var image 	= info.album.image[1]["#text"];
				var title 	= '"' + album + '"' + ' by ' + artist + ' (plays: ' + playcount + ')'
				$("#lastfm-"+rank).attr("href",url).attr("title",title).html(
					$("<img>").attr("src",image).attr("width", coverwidth)
				);
			})
		});
	});
})
