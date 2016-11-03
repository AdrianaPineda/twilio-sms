import Vapor

let drop = Droplet()

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("hello") { request in
    let name = request.data["name"]?.string ?? "stranger"

    return try drop.view.make("hello", [
      "name": name
    ])
}

drop.resource("posts", PostController())

drop.run()
