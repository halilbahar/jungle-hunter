package at.htl.junglehunter.resource;

import at.htl.junglehunter.dto.FileDto;
import at.htl.junglehunter.dto.TrailDto;
import at.htl.junglehunter.entity.Route;
import at.htl.junglehunter.entity.Trail;
import at.htl.junglehunter.model.FailedField;
import at.htl.junglehunter.service.FileService;
import at.htl.junglehunter.service.ValidationService;
import org.jboss.resteasy.annotations.providers.multipart.MultipartForm;

import javax.inject.Inject;
import javax.transaction.Transactional;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.net.URI;
import java.util.List;

@Path("/trail")
@Consumes("application/json")
@Produces("application/json")
public class TrailResource {

    @Inject
    ValidationService validationService;

    @Inject
    FileService fileService;

    @GET
    @Path("/route/{route-id}")
    public Response getAll(@PathParam("route-id") Long routeId) {
        Route route = Route.findById(routeId);
        if (route == null) {
            return Response.status(404).build();
        }

        return Response.ok(Trail.getDtos(route.trails.stream())).build();
    }

    @POST
    @Path("/route/{route-id}")
    @Transactional
    public Response create(@PathParam("route-id") Long routeId, TrailDto trailDto) {
        Route route = Route.findById(routeId);
        if (route == null) {
            return Response.status(404).build();
        }

        List<FailedField> failedFields = this.validationService.getFailedFields(trailDto);
        if (!failedFields.isEmpty()) {
            return Response.status(422).entity(failedFields).build();
        }

        Trail trail = trailDto.map();
        trail.route = route;
        trail.persist();

        return Response.noContent().build();
    }

    @DELETE
    @Path("/{trail-id}")
    @Transactional
    public Response delete(@PathParam("trail-id") Long trailId) {
        Trail trail = Trail.findById(trailId);
        if (trail == null) {
            return Response.status(404).build();
        }

        TrailDto trailDto = TrailDto.map(trail);
        trail.delete();

        return Response.ok(trailDto).build();
    }

    @PUT
    @Path("/{trail-id}")
    @Transactional
    public Response update(@PathParam("trail-id") Long trailId, TrailDto trailDto) {
        Trail trail = Trail.findById(trailId);
        if (trail == null) {
            return Response.status(404).build();
        }

        List<FailedField> failedFields = this.validationService.getFailedFields(trailDto);
        if (!failedFields.isEmpty()) {
            return Response.status(422).entity(failedFields).build();
        }

        trail.update(trailDto);

        return Response.noContent().build();
    }

    @PATCH
    @Path("/{trail-id}")
    @Consumes("multipart/form-data")
    @Transactional
    public Response uploadGpx(@PathParam("trail-id") Long trailId, @MultipartForm FileDto fileDto) {
        Trail trail = Trail.findById(trailId);
        if (trail == null) {
            return Response.status(404).build();
        }

        if (fileDto.getData() == null) {
            return Response.status(400).build();
        }

        trail.hasGpx = true;

        this.fileService.uploadFile(fileDto, String.format("/gpx/%d.xml", trailId));
        return Response.noContent().build();
    }

}
