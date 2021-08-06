  
target_ = oPlayer;
width_ = camera_get_view_width(view_camera[1]);
height_ = camera_get_view_height(view_camera[1]);
scale_ = width_ / view_get_wport(1);
show_debug_message(scale_);
