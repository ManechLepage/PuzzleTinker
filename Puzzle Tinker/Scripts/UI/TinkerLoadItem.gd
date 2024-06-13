extends Button

var item: Item

func load_item(_item: Item):
	item = _item
	get_child(0).text = item.name

func clear():
	item = null
	get_child(0).text = ""
