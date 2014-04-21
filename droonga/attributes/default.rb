nodejs["npm"] = "1.4.7"

default.droonga.engine.user_name  = "droonga-engine"
default.droonga.engine.group_name = "droonga-engine"
default.droonga.engine.home       = "/home/droonga-engine"
default.droonga.engine.ruby       = "ruby"
default.droonga.engine.host       = node.name
default.droonga.engine.port       = 10031
default.droonga.engine.tag        = "droonga"
default.droonga.engine.template.cookbooks = {}

default.droonga.http_server.user_name  = "droonga-http-server"
default.droonga.http_server.group_name = "droonga-http-server"
default.droonga.http_server.home       = "/home/droonga-http-server"
default.droonga.http_server.node       = "node"
default.droonga.http_server.host       = node.name
default.droonga.http_server.port       = 13000
default.droonga.http_server.tag        = "droonga"
default.droonga.http_server.default_dataset = "Droonga"
default.droonga.http_server.cache_size = 100
