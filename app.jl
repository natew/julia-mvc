module App

  export model,
         controller,
         routes,
         run

  global _models = Dict(),
         _controllers = Dict(),
         _routes = Dict()

  function model(methods, name::String)
    println("Adding model $name")
    _models[name] = methods
  end

  module Controller
    function render(thing)
      println(thing)
    end
  end

  function controller(actions, name::String)
    println("Adding controller $name, $actions")
    _controllers[name] = actions
  end

  function routes(app_routes)
    # Flip routes around
    for route in app_routes
      controller, path = route
      _routes[path] = controller
    end
  end

  function run()
    # Main loop of web app
    # For now just to test, lets just call posts#index
    # run_route("/")
  end

  # this is totally wrong
  run_route(path::String) = exec(_routes[path])

end

# using App

### Routes
App.routes({
  # "post"           => [:create, :edit, :update, :destroy],
  # "post"           => :resource,
  "main#index"     => "/",
  "posts#index"    => "/posts"
})

### Models
App.model("Post") do
  # something
  function title()
    "Title of post"
  end
end

### Controllers
App.controller("posts") do
  using App.Controller

  function index()
    render(Post.title())
  end
end

App.run()