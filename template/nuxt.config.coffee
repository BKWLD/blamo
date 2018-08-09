# Load .env vars
require('dotenv').config() if require('fs').existsSync '.env'

# Config object
module.exports =

	# HTML head
	head:
		title: '{{ name }}'
		meta: [
			{ charset: 'utf-8'}
			{ name: 'viewport', content: 'width=device-width, initial-scale=1' }
			{ 'http-equiv': 'X-UA-Compatible', content: 'IE=edge' }
			{ name: 'msapplication-tap-highlight', content:'no' }
		]
		link: [
			{ rel: 'icon', 	type: 'image/x-icon', href: '/favicon.ico' }
		]

	# Global styles
	css: [
		'normalize.css'
		'~/assets/app.styl'
	]

	# Nuxt modules
	modules: [
		'blamo'
	]
