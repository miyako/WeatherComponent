// ----------------------------------
// Class AITools
// Creation of the description of the functions of the Weather class for the 4D AIKit tools
// ----------------------------------
property _key : Text
Class constructor($key : Text)
	This._key:=$key
	
Function all() : Collection
	var $tools:=[]
	$tools.push(This.alerts())
	$tools.push(This.astronomy())
	$tools.push(This.current())
	
	
	return $tools
	
	// Get current weather conditions
Function current() : Object
	var $key:=This._key
	var $mytool:={tool: {}; handler: Formula(cs.Weather.new($key).current($1.place))}
	$mytool.tool.name:="current"
	$mytool.tool.description:="Current weather or realtime weather API method allows a user to get up to date current weather information in json. The data is returned as a Current Object. "
	$mytool.tool.parameters:={type: "object"; properties: {}}
	$mytool.tool.parameters.properties.place:={type: "string"; description: "city name"}
	
	return $mytool
	
	
	// Get astronomy data (sunrise, sunset, moon phase)
	// $date format: YYYY-MM-DD
Function astronomy() : Object
	var $key:=This._key
	var $mytool:={tool: {}; handler: Formula(cs.Weather.new($key).astronomy($1.place; $1.date))}
	$mytool.tool.name:="astronomy"
	$mytool.tool.description:="Astronomy API method allows a user to get up to date information for sunrise, sunset, moonrise, moonset, moon phase and illumination in json."
	$mytool.tool.parameters:={type: "object"; properties: {}}
	$mytool.tool.parameters.properties.place:={type: "string"; description: "city name"}
	$mytool.tool.parameters.properties.date:={type: "string"; description: "date in YYYY-MM-DD format"}
	
	return $mytool