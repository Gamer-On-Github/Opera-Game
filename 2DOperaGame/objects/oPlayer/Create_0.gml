global.x_speed_ = 0;
global.y_speed_ = 0;
global.max_speed_ = 2;
global.accelaration = 0.5;
global.maxhp = 10
hp = global.maxhp
walkspeed = 3.5;
collisionSpeed =  walkspeed + 2;
tilemap = layer_tilemap_get_id("WallTiles")

instance_create_layer(x, y, "Instances", oCamera);

