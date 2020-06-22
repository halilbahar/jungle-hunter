package at.htl.junglehunter.resource;

import com.intuit.karate.junit5.Karate;

public class ControlPointResourceTest {

    @Karate.Test
    public Karate testControlPoint() {
        return Karate.run("control-point").relativeTo(getClass());
    }
}
