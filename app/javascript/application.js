// Entry point for the build script in your package.json
import "./common"

import "@hotwired/turbo-rails"
Turbo.session.drive = false
import 'bootstrap/js/dist/dropdown'
import 'bootstrap/js/dist/modal'
import 'bootstrap/js/dist/collapse'
import 'bootstrap5-toggle/js/bootstrap5-toggle.ecmas'

import * as ActiveStorage from "@rails/activestorage"

ActiveStorage.start()
