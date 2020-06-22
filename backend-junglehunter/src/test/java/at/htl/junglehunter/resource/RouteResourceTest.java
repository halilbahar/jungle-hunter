package at.htl.junglehunter.resource;

import com.intuit.karate.junit5.Karate;

public class RouteResourceTest {

    @Karate.Test
    Karate testRoute() {
        return Karate.run("route").relativeTo(getClass());
    }
}
