///@function					textbox_add_voice(volume,syncText?,syncSprite?,sound1,sound2,sound3,sound4,etc.)
///@description					Add voice acting - If not enough arguments are provided or some of them is noone, no sound will be played for that text
///@arg {bool} volume
///@arg {bool} syncText?		If true, the text speed is synced with the voice. This overrides speed set with textbox_set_speed (except if you call it later probably).
///@arg {bool} syncSprite?		If true, it stops character sprite animation when the sound has been played
///@arg {Asset.GMSound} sound1
///@arg {Asset.GMSound} [sound2]
///@arg {Asset.GMSound} [sound3]
///@arg {Asset.GMSound} [sound4]
///@arg {Asset.GMSound} [etc.]

function textbox_add_voice() {
	
	with(textbox) {
		
		voice_volume = argument[0];
		voice_sync_text = argument[1];
		voice_sync_sprite = argument[2]; //If I can't fix this, remove/comment it everywhere

		var _max_msg = array_length(msg);
		for (var _i = 0; _i < _max_msg; _i ++;) { //_i = 3 or 2 or 4?
		   // Set the voice with all provided arguments
		   if (argument_count+3 > _i) {
			   voice[_i] = argument[_i+3];
		   }else{
			 // But if there are less arguments than messages in the dialogue, set the rest to noone
			 voice[_i] = noone;
		   }
			// Sync voice with text speed
			if (voice_sync_text == true) {
				//var voice_progress = audio_sound_get_track_position(voice[_i])/audio_sound_length(voice[_i]);
				//characters = voice_progress;
				if (voice[_i] != noone) {
					var _voice_length = audio_sound_length(voice[_i]);
					message_speed[_i] = _voice_length/string_width(msg[_i])*game_get_speed(gamespeed_fps);
				}else{
					message_speed[_i] = 0.5; //Change this? For example to the speed provided with textbox_set_speed?
				}
				speed_set = true;
			}
		}
	}
	
}

//Example:
//textbox_add_voice(1,false,false,sound_voice1,sound_voice2);