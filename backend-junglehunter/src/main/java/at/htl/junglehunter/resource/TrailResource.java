package at.htl.junglehunter.resource;

import at.htl.junglehunter.dto.FileDto;
import at.htl.junglehunter.dto.TrailDto;
import at.htl.junglehunter.entity.Route;
import at.htl.junglehunter.entity.Trail;
import at.htl.junglehunter.filter.ExistingEntity;
import at.htl.junglehunter.service.FileService;
import org.jboss.resteasy.annotations.providers.multipart.MultipartForm;

import javax.inject.Inject;
import javax.transaction.Transactional;
import javax.validation.Valid;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;

@Path("/trail")
@Consumes("application/json")
@Produces("application/json")
public class TrailResource {

    @Inject
    FileService fileService;

    @GET
    @Path("/route/{route-id}")
    @ExistingEntity
    public Response getAll(@PathParam("route-id") Long routeId) {
        Route route = Route.findById(routeId);

        return Response.ok(Trail.getDtos(route.trails)).build();
    }

    @POST
    @Path("/route/{route-id}")
    @ExistingEntity
    @Transactional
    public Response create(@PathParam("route-id") Long routeId, @Valid TrailDto trailDto) {
        Route route = Route.findById(routeId);
        Trail trail = trailDto.map();
        trail.route = route;
        trail.persist();

        return Response.noContent().build();
    }

    @DELETE
    @Path("/{trail-id}")
    @ExistingEntity
    @Transactional
    public Response delete(@PathParam("trail-id") Long trailId) {
        Trail trail = Trail.findById(trailId);
        TrailDto trailDto = TrailDto.map(trail);
        trail.delete();

        return Response.ok(trailDto).build();
    }

    @PUT
    @Path("/{trail-id}")
    @ExistingEntity
    @Transactional
    public Response update(@PathParam("trail-id") Long trailId, @Valid TrailDto trailDto) {
        Trail trail = Trail.findById(trailId);
        trail.update(trailDto);

        return Response.noContent().build();
    }

    @PATCH
    @Path("/{trail-id}")
    @Consumes("multipart/form-data")
    @ExistingEntity
    @Transactional
    public Response uploadGpx(@PathParam("trail-id") Long trailId, @MultipartForm FileDto fileDto) {
        Trail trail = Trail.findById(trailId);

        if (fileDto.getData() == null) {
            return Response.status(400).build();
        }

        trail.hasGpx = true;

        this.fileService.uploadFile(fileDto, String.format("/gpx/%d.xml", trailId));
        return Response.noContent().build();
    }
}
