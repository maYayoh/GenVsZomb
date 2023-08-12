extends Control

@onready var money : RessourcePanel = RessourcePanel.new($MoneyHolder)
@onready var energy : RessourcePanel = RessourcePanel.new($EnergyHolder)
var should_hide : bool = false
const SPEED : int = 30

class RessourcePanel:
	var state : Menu.SlideState = Menu.SlideState.HIDDEN
	var timer : float = 0
	var holder : ColorRect
	
	func _init(holder : ColorRect):
		self.holder = holder



func on_day():
	should_hide = false

func on_night():
	should_hide = true


func _process(delta):
	handler(money, delta)
	handler(energy, delta)

func handler(panel : RessourcePanel, delta):
	var pos : float = panel.holder.position.y
	
	match(panel.state):
		Menu.SlideState.HIDDEN:
			if not should_hide:
				panel.state = Menu.SlideState.SLIDEIN
		
		Menu.SlideState.SLIDEIN:
			if pos < 0:
				pos += delta * SPEED
			else:
				pos = floor(pos)
				panel.state = Menu.SlideState.SHOWN
				panel.timer = 2.0
		
		Menu.SlideState.SLIDEOUT:
			if pos > -7:
				pos -= delta * SPEED
			else:
				pos = floor(pos)
				panel.state = Menu.SlideState.HIDDEN
		
		Menu.SlideState.SHOWN:
			panel.timer -= delta
			if panel.timer <= 0 && should_hide:
				panel.state = Menu.SlideState.SLIDEOUT
	
	panel.holder.position.y = pos

func shake(rect : ColorRect):
	var child1 : Sprite2D = rect.get_child(0)
	var child2 : Sprite2D = rect.get_child(1)
	child1.position.x -= 1
	child2.position.x -= 1
	await get_tree().process_frame
	await get_tree().process_frame
	child1.position.x += 1
	child2.position.x += 1
	await get_tree().process_frame
	await get_tree().process_frame
	child1.position.x += 1
	child2.position.x += 1
	await get_tree().process_frame
	await get_tree().process_frame
	child1.position.x -= 1
	child2.position.x -= 1


func update_states(money : bool, energy : bool):
	if money:
		if self.money.state != Menu.SlideState.SHOWN:
			self.money.state = Menu.SlideState.SLIDEIN
		else:
			self.money.timer = 2.0
	
	if energy:
		if self.energy.state != Menu.SlideState.SHOWN:
			self.energy.state = Menu.SlideState.SLIDEIN
		else:
			self.energy.timer = 2.0
