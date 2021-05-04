local ui_get = ui.get
local client_userid_to_entindex = client.userid_to_entindex
local entity_get_player_name = entity.get_player_name
local client_log = client.log
local vote_option = { }
local team_name = ""
local menu_view_votes = ui.new_checkbox("VISUALS", "other esp", "View Votes")

local function on_vote_options(event)
	vote_option[0] = event.option1
	vote_option[1] = event.option2
	vote_option[2] = event.option3
	vote_option[3] = event.option4
	vote_option[4] = event.option5
end

local function on_vote_cast(event)
	local userid = event.entityid
	if userid == nil then
		return
	end

	if event.team == 3 then
		team_name = "CT"
	elseif event.team == 2 then
		team_name = "T"
	else
		team_name = "Spectator"
	end

	if ui_get(menu_view_votes) then
		local player_name = entity_get_player_name(userid)		
		client_log(player_name, " voted ", vote_option[event.vote_option], " on ", team_name)
	end
end
client.set_event_callback("vote_options", on_vote_options)
client.set_event_callback("vote_cast", on_vote_cast)