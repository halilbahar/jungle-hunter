package at.htl.junglehunter.resource;

import com.intuit.karate.junit5.Karate;

public class TrailResourceTest {

    @Karate.Test
    public Karate testTrail() {
        return Karate.run("trail").relativeTo(getClass());
    }
}
