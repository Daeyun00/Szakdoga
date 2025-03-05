extends AnimatedSprite2D


@export var items : Array[Item]

func interact():
	ShopUi.open_mode(ShopUi.MODE.SHOP, items)
