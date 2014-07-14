// bind javascript to all Processing instances
// function bindJavascript()
// {
// 	var canvaslist = document.getElementsByTagName("canvas");
// 	for(var c=0; c<canvaslist.length; c++)
// 	{
// 		console.log('foo');
// 		var pjs = Processing.getInstanceById(canvaslist[c]);
// 		try { pjs.bindJavascript(this); }
// 		catch(e) { setTimeout(bindJavascript, 10); }
// 	}
// }



// Access to Processing (top-level functions only)

function toggleFlock()
{
	var mysketch = Processing.getInstanceById("mysketch");
	mysketch.flockClick();
}

function toggleTrails()
{
	var mysketch = Processing.getInstanceById("mysketch");
	mysketch.trailClick();
}