
# Bootstrap boilerplate stuff
module.exports = (options) ->
	
	# Prepend definitions.styl to all stylus styles
	@addModule ['nuxt-stylus-resources-loader', './assets/definitions.styl'], true

# Exporta meta for Nuxt internals
module.exports.meta = require '../package.json'
