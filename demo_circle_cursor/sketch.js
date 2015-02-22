function setup()
{
  canvas = createCanvas(windowWidth - 20, windowHeight - 20);
  //pg = createGraphics( width, height);
  smooth();
  angleMode(DEGREES);
}

function draw()
{
  //var c = randomColor();
  //var xStep = width/15;
  var yStep = height/50;
  var w = width;
  var theta = 0.0;
  var amp = width/15;
  var period = 300;
  var dy = (TWO_PI / period) * yStep;
  xvalues = [];

  // For every x value, calculate a y value with sine function
  y = theta;
  for (i = 0; i < xvalues.length; i++)
  {
    xvalues[i] = sin(y)*amp;
    y+=dy;
    theta += 0.02;
  }

  stroke(0);
  fill(gaussianColor());
  // A simple way to draw the wave with an ellipse at each location
  for (y = 0; y < xvalues.length; x++)
  {
    ellipse(y*yStep, width/2+xvalues[y], 16, 16);
  }
  
  // for (var x = 0; (x - 1) * xStep < width; x++)
  // {
  //   for (var y = 0; (y - 1) * yStep < height; y++)
  //   {
      
  //     gx = randomGaussian(0, 10);
  //     gy = randomGaussian(0, 10);
  //     //c = randomColor();
  //     f = gaussianColor();
  //     fill(f);
  //     stroke(0);
  //     ellipse((x * xStep) + cos(theta) * 200, (y * yStep) + sin(theta) * 100, 80, 80);
  //     theta += 0.05;
  //   }
  //   y = 1;
  // }
  noLoop();
  
  //pg.ellipse(mouseX, mouseY, 80, 80);
  //image(pg, 0, 0, width, height);
}

function gaussianColor()
{
    c = color( randomGaussian(127, 5), randomGaussian(127, 5), randomGaussian(127, 5)  );
  return c;
}

function randomColor()
{
  c = color( random(0, 255), random(0, 255), random(0, 255)  );
  return c;
}


function calcWave()
{
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.02;

  // For every x value, calculate a y value with sine function
  y = theta;
  for (i = 0; i < xvalues.length; i++)
  {
    xvalues[i] = sin(y)*amplitude;
    y+=dy;
  }
}

function renderWave() {
  noStroke();
  fill(255);
  // A simple way to draw the wave with an ellipse at each location
  for (y = 0; y < xvalues.length; x++)
  {
    ellipse(y*yStep, width/2+xvalues[y], 16, 16);
  }
}





// RESIZE TO BROWSER //
// function doResize()
// {
//   var w = window.innerWidth - 20;
//   var h = window.innerHeight - 20;
//   canvas.size(w, h);
//   //pg.width = w;
//   //pg.height = h;
// }

// $(window).resize(doResize);