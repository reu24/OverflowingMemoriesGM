///@description Variables
itstime = true; //For managing sound (helps to make the text sound less often)
itstime2 = false; //For managing text skipping
itstime3 = true; //Used with the delay
alarm[1] = 10; //So it doesn't skip text when starting to speak
delay = true; //For a delay after the text has been drawn to prevent skipping text accidentally
called = false; // Used with alarm[4]

// Mouse related
mouse_on_option = false;
mouse_xprevious = 0;
mouse_yprevious = 0;
mouse_moved = false;

// Controller related
pressing = false;
pressing2 = false;
axis_action_down = false;
axis_action_up = false;

//Maybe move these variables to textbox_create script?



/*----------------------------
[Dialogue Engine]
Made by Pikku-a

People who have bought it can freely use it, even for commercial use.
No need to credit me. However, you can, if you want to.

Only restriction is that you should not share or sell the Dialogue Engine itself.
------------------------------*/