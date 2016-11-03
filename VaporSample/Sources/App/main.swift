import Vapor
import HTTP

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

drop.post("person") { request in
  guard let name = request.data["name"]?.string, let city = request.data["city"]?.string else {
    throw Abort.badRequest
  }

  return try Response(status: .created, json: JSON(node: [
    "name": name,
    "city": city
   ]))
}

drop.resource("posts", PostController())

drop.run()
