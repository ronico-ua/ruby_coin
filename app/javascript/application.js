// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as ActiveStorage from "@rails/activestorage"

import 'bootstrap/js/dist/dropdown'
import 'bootstrap/js/dist/collapse'

ActiveStorage.start()
