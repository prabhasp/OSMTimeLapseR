(function($) {
    $(document).ready(function() {
	
	$('#timelapse_year_els').scianimator({
	    'images': ['year/timelapse_year_els1.png', 'year/timelapse_year_els2.png', 'year/timelapse_year_els3.png', 'year/timelapse_year_els4.png', 'year/timelapse_year_els5.png', 'year/timelapse_year_els6.png', 'year/timelapse_year_els7.png'],
	    'width': 1000,
	    'delay': 500,
	    'loopMode': 'loop',
 'controls': ['first', 'previous', 'play', 'next', 'last', 'speed'], 'delayMin': 0
	});
	$('#timelapse_year_els').scianimator('play');
    });
})(jQuery);
