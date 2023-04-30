package hx_webserver;


class Query {

    private var params: Map<String, String> = [];

    public function new(queryString: String) {
        if (queryString.charAt(0) == "?") {
            queryString = queryString.substr(1);
        }

        var params = queryString.split("&");
        for (param in params) {
            var items = param.split("=");
            var key = items[0];
            var val = if (items.length > 1) items[1] else null;
            this.params[key] = val;
        }
    }

    public static function fromRequest(request: HTTPRequest) {
        return new Query(request.queryString);
    }

    public function get(key: String, def:String=null) {
        if (!this.has(key)) return def;
        return this.params.get(key);
    }

    public function has(key: String) {
        return this.params.exists(key);
    }

    public function iterator() {
        return this.params.keyValueIterator();
    }

}
