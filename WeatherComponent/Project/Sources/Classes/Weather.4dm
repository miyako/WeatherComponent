// ----------------------------------
// Class WeatherAPI
// Wrapper for WeatherAPI.com REST API
// ----------------------------------
property _url:="http://api.weatherapi.com/v1"
property _key:=""

Class constructor($key : Text)
	This._key:=$key#"" ? $key : This._key
	
	// Get current weather conditions
Function current($place : Text) : Object
	return This._httpRequest("/current.json"; "q="+$place)
	
	// Get astronomy data (sunrise, sunset, moon phase)
	// $date format: YYYY-MM-DD
Function astronomy($place : Text; $date : Text) : Object
	return This._httpRequest("/astronomy.json"; "q="+$place+"&dt="+$date)
	
	
	// Perform 4D.HTTPRequest to WeatherAPI
	// $api: endpoint path (ex: /current.json)
	// $param: query string parameters (without key)
Function _httpRequest($api : Text; $param : Text) : Object
	var $url : Text
	var $response : Text
	
	// Build request URL
	$url:=This._url+$api+"?key="+This._key
	If ($param#"")
		$url+="&"+$param
	End if 
	
	var $request:=4D.HTTPRequest.new($url).wait()
	If (($request.response#Null) && ($request.response.status=200))
		return {success: True; response: $request.response.body}
	Else 
		return {success: False; response: {}; errors: $request.response.body.error; status: $request.response.status; statusText: $request.response.statusText}
	End if 
	