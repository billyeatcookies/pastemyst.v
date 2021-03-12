module tests

import billyeatcookies.pastemyst.endpoints
import billyeatcookies.pastemyst.types

const created_pastes = []types.Paste{}

const sample_pasty = types.Pasty{
	title: "Test Pasty",
	language: "plain text",
	code: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
}
const api_token = $env('API_TOKEN')

fn test_get_public_paste () {
	mut paste := endpoints.get_paste(id: "99is6n23") ?

	assert paste !is bool
	assert paste.title == "public paste example title" 
}

fn test_get_private_paste () {
	mut paste := endpoints.get_paste(id: "grajzo1h", token: api_token) ?

	assert paste !is bool
	assert paste.title == "private paste example title" 
}

fn test_create_public_paste () {
	mut title     := "[pastemyst.v] Public Paste Create Test"
	mut new_paste := types.Paste {
		title      : title,
		expires_in : "1h",
		pasties    : [sample_pasty]
	}

	mut created_paste := endpoints.create_paste(paste: new_paste) ?

	assert created_paste !is bool
	if created_paste !is bool {
		assert created_paste.title == title
		
		created_pastes << created_paste
	}
}

fn test_create_private_paste () {
	mut title     := "[pastemyst.v] Private Paste Create Test"
	mut new_paste := types.Paste {
		title      : title,
		expires_in : "1h",
		is_private : true
		pasties    : [sample_pasty]
	}

	created_paste := endpoints.created_paste(paste: new_paste, token: api_token) ?

	assert created_paste !is bool
	if created_paste !is bool {
		assert created_paste.title == title
		assert created_paste.is_private == true

		created_pastes << created_paste
	}
}


fn test_delete_paste () {
	mut new_paste := types.Paste {
		pasties   : [sample_pasty]
	}
	mut created_paste := endpoints.create_paste(paste: new_paste) ?

	assert created_paste !is bool
	if created_paste !is bool {
		mut is_paste_deleted := endpoints.delete_paste(id: created_paste.id, token: api_token) ?
		assert is_paste_deleted == true
	}
}

fn test_edit_paste () {
	mut new_paste := types.Paste {
		pasties   : [sample_pasty]
	}
	mut created_paste := endpoints.create_paste(paste: new_paste) ?

	assert created_paste !is bool

	if created_paste !is bool {
		mut desired_title := "[pastemyst.v] Paste Edit Test"
		mut desired_edit  := types.Edit {
			title      : desired_title,
			tags       : "edit, test",
			pasties    : [sample_pasty]
		}
		mut edited_paste = endpoints.edit_paste(id: paste._id, edit: desired_edit, token: api_token) ?

		assert edited_paste !is bool
		if edited_paste !is bool {
			assert editedPaste.title == desiredTitle

			created_pastes << edited_paste
		}
	}
}


fn testsuite_end () {
	if created_pastes.len > 0 {
		println("==== Paste Cleanup ====")
		for create_paste in created_pastes {
			println("Cleaning up paste with id: $created_paste.id, title: $created_paste.title")
			mut is_paste_deleted := endpoints.delete_paste(id: created_paste.id, token: api_token) ?
		}
		println("=======================")
	}
}