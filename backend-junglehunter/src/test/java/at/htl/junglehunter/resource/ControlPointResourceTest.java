package at.htl.junglehunter.resource;

import at.htl.junglehunter.DatabaseResource;
import com.intuit.karate.junit5.Karate;
import io.quarkus.test.common.QuarkusTestResource;
import io.quarkus.test.junit.QuarkusTest;

@QuarkusTestResource(DatabaseResource.class)
@QuarkusTest
public class ControlPointResourceTest {

    @Karate.Test
    public Karate testControlPoint() {
        return Karate.run("control-point").relativeTo(getClass());
    }
}

