image_speed = (global.bpm / 60) / 30 * global.deltaMultiplier;

audio_stop_all();
audio_play_sound(intro3, 10, false);

if (global.dead = true) {
	var o = instance_create_depth(0, 0, depth - 100, oFade);
	with (o) {
		fadeY = -199;
		moved = true;
	}
	global.dead = false;
}
global.playVoice = 1;
global.turn = 1;

global.musicSync = audio_create_sync_group(false);
audio_play_in_sync_group(global.musicSync, global.song);
if (global.voices != "") audio_play_in_sync_group(global.musicSync, global.voices);