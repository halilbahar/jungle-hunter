package at.htl.junglehunter.resource;

import at.htl.junglehunter.dto.RouteDto;
import at.htl.junglehunter.entity.Route;
import at.htl.junglehunter.filter.ExistingEntity;
import at.htl.junglehunter.model.FailedField;
import at.htl.junglehunter.service.ValidationService;

import javax.inject.Inject;
import javax.transaction.Transactional;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.net.URI;
import java.util.List;

@Path("/route")
@Consumes("application/json")
@Produces("application/json")
public class RouteResource {

    @Inject
    ValidationService validationService;

    @GET
    public Response getAll() {
        return Response.ok(Route.getDtos()).build();
    }

    @POST
    @Transactional
    public Response create(RouteDto routeDto) {
        List<FailedField> failedFields = this.validationService.getFailedFields(routeDto);
        if (!failedFields.isEmpty()) {
            return Response.status(422).entity(failedFields).build();
        }

        Route route = routeDto.map();
        route.persist();

        return Response.created(URI.create("route/" + route.id)).build();
    }

    @GET
    @Path("/{route-id}")
    @ExistingEntity
    public Response getById(@PathParam("route-id") Long routeId) {
        RouteDto routeDto = Route.getDto(routeId);
        return Response.ok(routeDto).build();
    }

    @DELETE
    @Path("/{route-id}")
    @ExistingEntity
    @Transactional
    public Response delete(@PathParam("route-id") Long routeId) {
        Route route = Route.findById(routeId);
        RouteDto routeDto = RouteDto.map(route);
        route.delete();
        return Response.ok(routeDto).build();
    }

    @PUT
    @Path("/{route-id}")
    @ExistingEntity
    @Transactional
    public Response update(@PathParam("route-id") Long routeId, RouteDto routeDto) {
        Route route = Route.findById(routeId);

        List<FailedField> failedFields = this.validationService.getFailedFields(routeDto);
        if (!failedFields.isEmpty()) {
            return Response.status(422).entity(failedFields).build();
        }

        route.update(routeDto);

        return Response.noContent().build();
    }
}
