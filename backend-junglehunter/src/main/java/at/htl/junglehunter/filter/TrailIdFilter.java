package at.htl.junglehunter.filter;

import at.htl.junglehunter.entity.Trail;

import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.Provider;
import java.io.IOException;
import java.util.List;

@Provider
@ExistingTrail
public class TrailIdFilter implements ContainerRequestFilter {

    @Override
    public void filter(ContainerRequestContext requestContext) {
        List<String> valuesList = requestContext.getUriInfo().getPathParameters().get("trail-id");
        if (valuesList == null) {
            requestContext.abortWith(Response.status(Response.Status.BAD_REQUEST).build());
            return;
        }

        String value = valuesList.get(0);
        long l = Long.parseLong(value);
        if (Trail.findById(l) == null) {
            requestContext.abortWith(Response.status(Response.Status.NOT_FOUND).build());
        }
    }
}
