function fn() {
    var env = karate.env; // get java system property 'karate.env'
    karate.log('karate.env system property was:', env);
    if (!env) {
        env = 'dev'; // a custom 'intelligent' default
    }
    var config = { // base config JSON
        Route: Java.type('at.htl.junglehunter.entity.Route'),
        Trail: Java.type('at.htl.junglehunter.entity.Trail'),
        ControlPoint: Java.type('at.htl.junglehunter.entity.ControlPoint'),
        createRoute: function (name) {
            var Route = Java.type('at.htl.junglehunter.entity.Route');
            var route = new Route(name, 'aaaaa', 'bbbb', 'cccc');
            return route;
        },
        nString: function (length) {
            var result = '';
            var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
            var charactersLength = characters.length;
            for (var i = 0; i < length; i++) {
                result += characters.charAt(Math.floor(Math.random() * charactersLength));
            }
            return result;
        }
    };
    if (env == 'stage') {

    } else if (env == 'e2e') {

    }
    // don't waste time waiting for a connection or if servers don't respond within 5 seconds
    karate.configure('connectTimeout', 5000);
    karate.configure('readTimeout', 5000);
    return config;
}
