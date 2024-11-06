///@function		textbox_set_sound(sound,volume,interval)
///@description		Set the sound of the textbox
///@arg sound		The sound
///@arg [volume]	Volume of the sound
///@arg [interval]	Interval of the sound in steps

function textbox_set_sound(_sound,_volume,_interval) {
	
	with(textbox) {
		textsound = _sound;
		text_sound = true;
		if (!is_undefined(_volume)) {
			text_sound_volume = _volume;
		}
		if (!is_undefined(_interval)) {
			text_sound_interval = _interval;
		}
	}

}

//Example:
//textbox_set_sound(sound_typewriter,global.volume,10);
//This sets the text sound to a sound called sound_typewriter, volume to global.volume variable and interval to 10 steps.