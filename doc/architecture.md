# Arachnivania Architecture

![Arachnivania Architecture](doc/images/Arachnivania_Architecture.png)

## Purpose

The purpose of this document is to layout out the architecture of the 2D Metrovania game, Arachnivania by Coffee Capo Games, built in the Godot 3.2.3 open source engine.

## Scope

The scope of the project is fairly small. A small number of assets will be imported into the Godot Engine. Those 2D assets are then used when needed for game functions, such as player avatars and map textures.

Scripting is used whenever a function, either by the player, enemy, or the map itself is needed. 

## Engine

The engine's main architecture is built around forming .tscn files, or scenes. These scenes are formed from nodes. A scene is a main idea, such as a player or level. Child nodes are added to the scene, such as tilemaps for levels, and avatar .pngs for players. Player scenes are added to level scenes, and level scenes are linked together for form the game.

## Components

Compontents, also known as nodes, are the building blocks on the scenes. The largest node is the scene node, and all other nodes present are that node's children.

The direct children of the level node are the player, enemy, tilemap, and prop scenes (such as health orbs and portals)

The children of the player and enemy scenes are collision shapes, sprites, and animations.

The node organizion in Arachnivania follows this structure for the most part, with added nodes such as:

	-Player node as a camera controller node and enemy detector node
	-Prop nodes (health orbs and portal scenes) have been added in the lastest level scenes

### Player

The player scene consists of multiple child nodes, including collision detectors, animated sprite, and scripting for movement, attacks, and collision settings. The gravity and size are also controlled.

The player scene in Arachnivania has all the previously mentioned nodes, along with:
	
	-A speed calculation of (x: 135, y: 230)
	-A gravity level of 500
	-A stomp impulse of 230
	-Scripting for stomp impulse, velocity, gravity, and enemy detector

### Level

The level scene consists of a multiple child nodes, including the player scene, tilemap (which has the 2D assets), fallzones (which teleport the player back to the level if they fall out of bounds), and scene transitions (which are like doors the transport the player to the next level)

In Arachnivania, the levels consist of a cave and grass levels; though currently only the cave levels have been made. The purple cave texture detects collision from both player and enemy scenes. The black texture doesn't detect either (hence acting as a background)

The cave structure is very metroid inspired, one level being based on brinstar depths from methoid NES. The grass level is planned to be megaman inspired.

### Tileset

The tileset a childnode of the level scene. It accepts .png files, and allows the user to divide them into tiles to build levels. The tile size can be adjusted, though it starts at 64x64.

The collision settings for each individual tile are also controlled within the tileset node, as well as the collision setting for the player and enemy scenes. Player and enemy collisions can be different.

The tileset in Arachnivania are sized at (16x16), and currently consist of basic 
purple cave textures with a black background. Picture nodes outside of the tileset were also imported to act as the background in the lasted levels.

### User Interface

The user interface consists of a large window in the middle showing the current scene. Scenes are represented by tabs, so users can switch between scenes by clicking on the appropriate tab (Once the scene's been opened in the file explorer)

The top left lists all the main and child nodes (Nodes can be rearraged by clicking and dragging) New nodes ccan be created and deleted here.

The bottom left features the file explorer. This is where assets and scenes can be selected for use.

The very top of the screen has the project settings, which button map controls are control resolution, among other things. The middle area also has icons that switch between 2D view and scipt view (to edit the 2D scene and script for said scene)

The right collume has the inspector, which changes depending on the current selected node. The tilemap node enables the inspector to adjust the tile size, while the player node allows the inspector adjust the collision settings; speed; and gravity settings of the player.

## References

Ref#60
