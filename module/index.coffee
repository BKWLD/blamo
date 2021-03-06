# General deps
webpack = require 'webpack'

# Load .env file
dotenv = require 'dotenv'
fs = require 'fs'
dotenv.config() if fs.existsSync '.env'

# Sentry related deps
SentryCliPlugin = require '@sentry/webpack-plugin'
git = require 'git-rev-sync'
releaseName = process.env.COMMIT_REF || git.long() # COMMIT_REF is from Netlify

# Bootstrap boilerplate stuff
module.exports = (options) ->
	
	# Set the default loading color to Bukwild purple (it is "black" by default)
	@options.loading.color = '#9478b1' if @options.loading.color == 'black'
	
	# Add Coffeescript support
	@addModule 'nuxt-coffeescript-module', true
	
	# Prepend definitions.styl to all stylus styles
	@addModule ['nuxt-stylus-resources-loader', './assets/definitions.styl'], true

	# Toggle CJS support in Vue
	unless options.noCjsVue

		# Find the vue-loader and disable esModule exports so child components
		# can be one liners
		@extendBuild (config) ->
			rule = config.module.rules.find (rule) -> rule.loader == 'vue-loader'
			rule.options.esModule = false
			return
	
		# Use the CJS version of Vue
		@extendBuild (config) ->
			config.resolve = { alias: {} } unless config.resolve
			config.resolve.alias.vue$ = 'vue/dist/vue.common.js'
			return
	
	# Toggle Sentry
	unless options.noSentry
	
		# Enable Sentry by default
		@addModule '@nuxtjs/sentry', true
		
		# Sentry.io config
		@options.sentry = config:
			release: releaseName
			environment: process.env.SENTRY_ENV || process.env.APP_ENV
			extra: # Netlify env variables
				url: process.env.URL
				deploy_url: process.env.DEPLOY_URL
		
		# Configure Sentry source map handling
		@extendBuild (config, { isDev }) ->
			if process.env.SENTRY_DSN and not isDev
				config.devtool = 'hidden-source-map' # Enable maps on prod
				config.plugins.push new SentryCliPlugin
					include: './.nuxt/dist' # ... js and maps are directly within here
					urlPrefix: '~/_nuxt/' # ... because this is where assets live in /dist
					release: releaseName
			return
	
	# Provide common utils to all modules so they don't need to be expliclity
	# required.
	@options.build.plugins.push new webpack.ProvidePlugin
		Vue:       'vue'
		axios:     'axios'
	
	# Watch these files for changes
	@options.build.watch.push './nuxt.config.coffee'
	@options.build.watch.push './assets/definitions.styl'
	
	# Prevent big vendors file
	# https://github.com/nuxt/nuxt.js/pull/2687
	unless options.noMaxChunkSize
		@options.build.maxChunkSize = 300000 if @options.mode != 'spa'
	
	# Generate a robots.txt
	unless options.noRobots
		@addModule [ 'nuxt-robots-module', do ->
			if 'production' == (process.env.APP_ENV || process.env.SENTRY_ENV)
				'User-Agent': '*'
				Allow: '/'
			else
				'User-Agent': '*'
				Disallow: '/'
		], true
	
	# Common, simple plugins
	@addModule 'vue-balance-text/nuxt/module', true unless options.noBalanceText
	@addModule 'vue-unorphan/nuxt/module', true unless options.noUnorphan
	
	# Return an exit code of 1 if there is an error during generation.  This
	# forces platforms like Netlify to prevent promoting a build with an error.
	unless options.noFailCodeOnGenerateError
		@nuxt.hook 'generate:done', (generator, errors) ->
			process.exit(1) if errors.length

# Exporta meta for Nuxt internals
module.exports.meta = require '../package.json'
