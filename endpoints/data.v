module endpoints

import json
import net.http

import billyeatcookies.pastemyst
import billyeatcookies.pastemyst.types

const data_language_endpoint_name           = "$pastemyst.main_endpoint/data/language"
const data_language_endpoint_extension      = "$pastemyst.main_endpoint/data/languageExt"

type GetLanguageReturnType = types.RawLanguage | bool

pub struct GetLanguageConfig {
	name      string
	extension string
}

pub fn get_language (config GetLanguageConfig) ?GetLanguageReturnType {
	if config.name != "" {
		mut request := http.new_request(.get, data_language_endpoint_name + "?name=" + config.name, "") ?
		response := request.do() ?

		if response.status_code == int(http.Status.ok) {
			return json.decode(types.RawLanguage, response.text)
		} else {
			println("Error while fetching language details")
			return false
		}
	} else if config.extension != "" {
		mut request := http.new_request(.get, data_language_endpoint_extension + "?extension=" + config.extension, "") ?
		response := request.do() ?

		if response.status_code == int(http.Status.ok) {
			return json.decode(types.RawLanguage, response.text)
		} else {
			println("Error while fetching language details")
			return false
		}
	}
		
}
