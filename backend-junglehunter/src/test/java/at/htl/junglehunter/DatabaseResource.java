package at.htl.junglehunter;

import io.quarkus.test.common.QuarkusTestResourceLifecycleManager;
import org.testcontainers.containers.PostgreSQLContainer;

import java.util.Collections;
import java.util.Map;

public class DatabaseResource implements QuarkusTestResourceLifecycleManager {

    public static final PostgreSQLContainer<?> DATABASE = new PostgreSQLContainer<>("postgres:10.5")
            .withDatabaseName("junglehunter_db")
            .withUsername("junglehunter")
            .withPassword("junglehunter");

    @Override
    public Map<String, String> start() {
        DATABASE.start();
        return Collections.singletonMap("quarkus.datasource.jdbc.url", DATABASE.getJdbcUrl());
    }

    @Override
    public void stop() {
        DATABASE.stop();
    }
}
