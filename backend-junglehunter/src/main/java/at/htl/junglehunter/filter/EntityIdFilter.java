package at.htl.junglehunter.filter;

import io.quarkus.hibernate.orm.panache.runtime.JpaOperations;

import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.Provider;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.stream.Collectors;

@Provider
@ExistingEntity
public class EntityIdFilter implements ContainerRequestFilter {

    @Override
    public void filter(ContainerRequestContext requestContext) {
        List<String> valuesList = requestContext.getUriInfo().getPathParameters().get("trail-id");

        Map<String, Long> pathParameters = requestContext.getUriInfo().getPathParameters()
                .entrySet()
                .stream()
                .filter(entry -> entry.getKey().matches("[\\w-]+-id") && entry.getValue().get(0).matches("\\d+"))
                .collect(Collectors.toMap(Entry::getKey, value -> Long.parseLong(value.getValue().get(0))));

        if (pathParameters.size() == 0) {
            requestContext.abortWith(Response.status(Status.BAD_REQUEST).build());
            return;
        }

        pathParameters.forEach((paramString, id) -> {
            String[] segment = paramString.split("-");
            StringBuilder classNameBuilder = new StringBuilder("at.htl.junglehunter.entity.");
            for (int i = 0; i < segment.length; i++) {
                if (i != segment.length - 1) {
                    classNameBuilder
                            .append(segment[i].substring(0, 1).toUpperCase())
                            .append(segment[i].substring(1));
                }
            }
            String className = classNameBuilder.toString();
            try {
                Class<?> entityClass = Class.forName(className);
                if (JpaOperations.findById(entityClass, id) == null) {
                    requestContext.abortWith(Response.status(Status.NOT_FOUND).build());
                }
            } catch (ClassNotFoundException ignored) {
                requestContext.abortWith(Response.status(Status.INTERNAL_SERVER_ERROR).build());
            }
        });

    }
}
