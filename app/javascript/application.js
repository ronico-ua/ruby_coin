// Entry point for the build script in your package.json
import "./jquery"
import "./toggle"
import "./controllers"

import "@hotwired/turbo-rails"
import 'bootstrap/js/dist/dropdown'
import 'bootstrap/js/dist/collapse'
import 'bootstrap5-toggle/js/bootstrap5-toggle.jquery'
import * as ActiveStorage from "@rails/activestorage"

ActiveStorage.start()
