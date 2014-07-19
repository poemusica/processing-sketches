
// Bind javascript to processing instance

function bindJavascript()
{
	var pjs = Processing.getInstanceById("mysketch");
	if (pjs)
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

function toggleFlow()
{
	var pjs = Processing.getInstanceById("mysketch");
	pjs.flowClick();
}

function toggleWalls()
{
	var pjs = Processing.getInstanceById("mysketch");
	pjs.wallClick();
}

function toggleAttract()
{
	var pjs = Processing.getInstanceById("mysketch");
	pjs.attractClick();
}

function toggleRepel()
{
	var pjs = Processing.getInstanceById("mysketch");
	pjs.repelClick();
}

function toggleTrails()
{
	var pjs = Processing.getInstanceById("mysketch");
	pjs.trailClick();
}