
// Bind javascript to processing instance

function bindJavascript()
{
	var pjs = Processing.getInstanceById("mysketch");
	if (pjs !== null)
	{
		try { pjs.bindJavascript(this); }
		catch(e) { console.log(e); }
	}
	else setTimeout(bindJavascript, 250);
}

// Access to processing (top-level functions only)

function toggleFlock()
{
	var pjs = Processing.getInstanceById("mysketch");
	pjs.flockClick();
}

function toggleTrails()
{
	var pjs = Processing.getInstanceById("mysketch");
	pjs.trailClick();
}