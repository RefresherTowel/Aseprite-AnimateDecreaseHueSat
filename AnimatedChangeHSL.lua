local dlg = Dialog()
dlg:entry{ id="hue_amount", label="Hue Change:", text="0" }
dlg:entry{ id="sat_amount", label="Saturation Change:", text="0" }
dlg:entry{ id="light_amount", label="Lightness Change:", text="0" }
dlg:entry{ id="alpha_amount", label="Alpha Change:", text="0" }
dlg:entry{ id="frame_number", label="Number of Frames:", text="10" }
dlg:button{ id="confirm", text="Confirm" }
dlg:button{ id="cancel", text="Cancel" }
dlg:show()
local data = dlg.data
if data.confirm then

	local cel = app.activeCel
	if not cel then
		return app.alert("There is no active cel")
	end
	
	local img = cel.image
	if not img then
		return app.alert("There is no active image")
	end
	local sprite = img:clone()
	if not sprite then
		return app.alert("There is no active sprite")
	end
	
	for i=1,data.frame_number-1 do
		app.command.NewFrame()
		local newFrame = app.activeFrame
		local cel = app.activeCel
		cel.image = sprite
		app.command.HueSaturation {
			ui=false,
			mode='hsl',
			hue = data.hue_amount,
			saturation = data.sat_amount,
			lightness = data.light_amount,
			alpha = data.alpha_amount
		}
		sprite = cel.image:clone()
	end
end