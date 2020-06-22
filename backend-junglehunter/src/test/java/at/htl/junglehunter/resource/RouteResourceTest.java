package at.htl.junglehunter.resource;

import at.htl.junglehunter.DatabaseResource;
import com.intuit.karate.junit5.Karate;
import io.quarkus.test.common.QuarkusTestResource;
import io.quarkus.test.junit.QuarkusTest;

@QuarkusTestResource(DatabaseResource.class)
@QuarkusTest
public class RouteResourceTest {

    @Karate.Test
    Karate testRoute() {
        return Karate.run("route").relativeTo(getClass());
    }
}
