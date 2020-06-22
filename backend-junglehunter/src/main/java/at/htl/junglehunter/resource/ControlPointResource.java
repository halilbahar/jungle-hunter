package at.htl.junglehunter.resource;

import at.htl.junglehunter.dto.ControlPointDto;
import at.htl.junglehunter.dto.FileDto;
import at.htl.junglehunter.entity.ControlPoint;
import at.htl.junglehunter.entity.Trail;
import at.htl.junglehunter.entity.User;
import at.htl.junglehunter.filter.ExistingEntity;
import at.htl.junglehunter.service.FileService;
import org.jboss.resteasy.annotations.providers.multipart.MultipartForm;

import javax.inject.Inject;
import javax.transaction.Transactional;
import javax.validation.Valid;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;

@Path("/control-point")
@Consumes("application/json")
@Produces("application/json")
public class ControlPointResource {

    @Inject
    FileService fileService;

    @GET
    @Path("/trail/{trail-id}")
    @ExistingEntity
    public Response getAll(@PathParam("trail-id") Long trailId) {
        Trail trail = Trail.findById(trailId);

        return Response.ok(ControlPoint.getDtos(trail.controlPoints)).build();
    }

    @POST
    @Path("/trail/{trail-id}")
    @ExistingEntity
    @Transactional
    public Response create(@PathParam("trail-id") Long trailId, @Valid ControlPointDto controlPointDto) {
        Trail trail = Trail.findById(trailId);
        ControlPoint controlPoint = controlPointDto.map();
        controlPoint.trail = trail;
        controlPoint.persist();

        return Response.noContent().build();
    }

    @DELETE
    @Path("/{control-point-id}")
    @ExistingEntity
    public Response delete(@PathParam("control-point-id") Long controlPointId) {
        ControlPoint controlPoint = ControlPoint.findById(controlPointId);
        ControlPointDto controlPointDto = ControlPointDto.map(controlPoint);
        controlPoint.delete();

        return Response.ok(controlPointDto).build();
    }

    @PUT
    @Path("/{control-point-id}")
    @ExistingEntity
    @Transactional
    public Response update(@PathParam("control-point-id") Long controlPointId, @Valid ControlPointDto controlPointDto) {
        ControlPoint controlPoint = ControlPoint.findById(controlPointId);
        controlPoint.update(controlPointDto);

        return Response.noContent().build();
    }

    @POST
    @Path("{control-point-id}/image")
    @ExistingEntity
    @Consumes("multipart/form-data")
    @Transactional
    public Response uploadImage(@PathParam("control-point-id") Long controlPointId, @MultipartForm FileDto fileDto) {
        ControlPoint controlPoint = ControlPoint.findById(controlPointId);
        if (fileDto.getData() == null) {
            return Response.status(400).build();
        }

        this.fileService.uploadImage(fileDto, controlPoint, new User());

        return Response.noContent().build();
    }
}
