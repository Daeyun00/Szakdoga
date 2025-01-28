shader_type canvas_item;

uniform float speed = .1;


void vertex(){
	UV.s += TIME * speed;
	UV.r += TIME * speed;
}	