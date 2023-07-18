--[[
	@title types
	@author Lanred
	@version 1.0.0
]]

type neverMethod = <a>(self: a) -> never

export type events = "create" | "createOnJoin" | "play" | "stop" | "scrub" | "destroy"

export type updateMethod = "RenderStepped" | "Stepped" | "Heartbeat"

export type targets = { any }
export type tweenTargets = Instance | targets

export type info = {
	easing: string?,
	duration: number?,
	delay: number?,
}

export type tweenInfo = info & {
	reverses: boolean?,
	repeatCount: number?,
	destroyOnComplete: boolean?,
}

export type normalTweenInfo = tweenInfo & {
	method: updateMethod,
}

export type serverTweenInfo = tweenInfo & {
	updateSteps: number?,
}

export type dataTypeNoFunction = Color3 | CFrame | Vector3 | Vector2 | UDim2 | UDim | number
export type dataTypeWithFunction = dataTypeNoFunction & (instance: targets, index: number) -> any

type propertyParametersInfo = info & {
	addValue: boolean?,
}
export type propertyParameters = propertyParametersInfo & {
	value: dataTypeWithFunction | { dataTypeNoFunction },
}

export type property = dataTypeWithFunction | propertyParameters

export type properties = {
	[string]: property,
}

export type baseTween = {
	-- Public
	-- Variables
	targets: tweenTargets,
	reverses: boolean,
	repeatCount: number,
	duration: number,
	destroyOnComplete: boolean,
	updateSteps: number,

	-- Events
	completed: RBXScriptSignal,
	stopped: RBXScriptSignal,
	stateChanged: RBXScriptSignal,
	resumed: RBXScriptSignal,
	update: RBXScriptSignal,
	destroyed: RBXScriptSignal,

	-- Methods
	play: <a>(self: a, forceRestart: boolean?) -> never,
	stop: neverMethod,
	scrub: <a>(self: a, position: number) -> never,
	destroy: neverMethod,
	Destroy: neverMethod,

	-- Private
	-- Variables
	_startTime: number,
	_elapsedTime: number,
	_reversed: boolean,
	_state: Enum.PlaybackState,
	_properties: {
		start: { [targets]: properties },
		target: { [targets]: properties },
		lerpers: { [targets]: { [string]: () -> () -> any } },
		parameters: { [string]: info? },
	},

	-- Methods
	_updateState: <a>(self: a, state: Enum.PlaybackState) -> never,
	_update: <a>(self: a, customDelta: number?) -> never,
	_reverse: neverMethod,
	_complete: neverMethod,
	_updatePropertiesOnInstance: <a>(self: a, instance: targets, customDelta: number?) -> never,
}

export type normalTween = baseTween & {
	-- Private
	-- Variables
	_updateMethod: RBXScriptSignal,

	-- Methods
	_startMethod: neverMethod,
	_endMethod: neverMethod,
}

export type serverTween = baseTween & {
	-- Private
	-- Variables
	_updaterStart: number,
	_tweenID: string,

	-- Methods
	_startUpdater: neverMethod,
	_endUpdater: neverMethod,
}

return nil
