module types

pub struct RawLanguage {
pub: 
	name  string   [json: name]
	mode  string   [json: mode]
	mimes []string [json: mimes]
	ext   []string [json: ext]
	color string   [json: color]
}