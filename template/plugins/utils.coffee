# Same as setTimeout / delay but with the interval first
export wait = (ms, func) -> setTimeout func, ms

# Inject utils
export default ({ app }, inject) ->
	inject 'wait', wait
