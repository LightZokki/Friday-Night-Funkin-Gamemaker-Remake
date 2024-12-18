trueNoteSpeed = (curNoteSpeed) * global.deltaMultiplier;

y -= trueNoteSpeed;
if (yOff != 0) {y -= yOff; yOff = 0;}
if (switchTurn) sprite_index = sDebugNotes;

if (y > 1280) exit;

// mods
if (global.vanish) {
	if (y < 400) image_alpha -= global.noteSpeed / 100;
}

if (global.flashlight) { if (y < 600) image_alpha += global.noteSpeed / 200; }

if (!global.playVoice) {
	with (instance_place(x, y - 120, oArrowButton))
		if (enemy)
			global.playVoice = 1;
}

// detect for enemys
with (instance_place(x, y + 85, oArrowButton)) {
	if (enemy) or (global.auto) {
		if (other.notRealNote) exit;
		if (other.curNoteSpeed = 0) && (instance_exists(oReady)) exit;
		
		var obj = oEnemy;
		if (global.enemy = 0) obj = oGirlfriend;
		if (x > 1280 / 2) obj = oBoyfriend;
		obj.dir = other.image_index;
		obj.animationTimer = 70 + other.sliderLength / 8;
		
		if (other.sliderLength <= 0) {
			instance_destroy(other);
			obj.holdAnimation = false;
			obj.animationIndex = 0;
		} else {
			if (global.auto) && !(enemy) {
				other.heldAlready = true;
				other.sliderLength -= global.noteSpeed * global.deltaMultiplier;
				other.curNoteSpeed = 0;
				obj.holdAnimation = true;
			} else {			
				other.enemyHeld = true;
				obj.holdAnimation = true;
			}
		}
		
		if (enemy) {
			if (obj.sprite_index = sTankmanUgh) obj.sprite_index = obj.sprIdle;
			if (obj.sprite_index = sTankmanHey) obj.sprite_index = obj.sprIdle;
		}
		
		sprite_index = sprHit;
		image_speed = 1;
		
		if (obj = oBoyfriend) {
			if (other.sliderLength > 0) exit;
			// fake the game being played lol
			global.curScore += 350 * global.currentMultiplier;	
			global.hp += 1;
			global.combo++;
			
			var o = instance_create_depth(1254, 485, 400 - instance_number(oScoreText), oScoreText);
			o.image_index = 0;
		}
	}
}

if (beingHeld) {
	heldAlready = true;
	curNoteSpeed = 0;
	sliderLength -= global.noteSpeed * global.deltaMultiplier;
	global.hp += 0.08;
	with (oArrowButton) if (dir = other.image_index) && (image_index > 4) image_index = 0;
	oBoyfriend.holdAnimation = true;
	
	if (keyboard_check_released(keyPressedWith)) || (keyboard_check_released(altkeyPressedWith)) {
		beingHeld = false;
		curNoteSpeed = global.noteSpeed;
		oBoyfriend.holdAnimation = false;
	}
	
	if (sliderLength <= 0) {
		instance_destroy();	
		oBoyfriend.holdAnimation = false;
	}
}

if (enemyHeld) {
	heldAlready = true;
	curNoteSpeed = 0;
	sliderLength -= global.noteSpeed * global.deltaMultiplier;
	oEnemy.holdAnimation = true;
	
	if (sliderLength <= 0) {
		instance_destroy();	
		oEnemy.holdAnimation = false;
	}
}

if (y < 0 - sliderLength - 10) {
	instance_destroy();
	
	if (notRealNote) exit; 
	if (x < 600) exit;
	if (global.dead) exit;
	
	global.hp -= 3 + sliderLength / 80;
	if (global.fragile) global.hp = 0;
	
	global.playVoice = 0;	
	global.combo = 0;
	
	oHUD.missCount += 1;
}
if (switchTurn) or (bfHey) {
	if (y < 200) instance_destroy();
}
//if (fadeIn) && (image_alpha < 1) image_alpha += 0.1;