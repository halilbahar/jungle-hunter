package at.htl.junglehunter.resource;

import at.htl.junglehunter.dto.ControlPointDto;
import at.htl.junglehunter.dto.FileDto;
import at.htl.junglehunter.entity.ControlPoint;
import at.htl.junglehunter.entity.Trail;
import at.htl.junglehunter.entity.User;
import at.htl.junglehunter.model.FailedField;
import at.htl.junglehunter.service.FileService;
import at.htl.junglehunter.service.ValidationService;
import org.jboss.resteasy.annotations.providers.multipart.MultipartForm;

import javax.inject.Inject;
import javax.transaction.Transactional;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("/control-point")
@Consumes("application/json")
@Produces("application/json")
public class ControlPointResource {

    @Inject
    ValidationService validationService;

    @Inject
    FileService fileService;

    @GET
    @Path("/trail/{trail-id}")
    public Response getAll(@PathParam("trail-id") Long trailId) {
        Trail trail = Trail.findById(trailId);
        if (trail == null) {
            return Response.status(404).build();
        }

        return Response.ok(ControlPoint.getDtos(trail.controlPoints.stream())).build();
    }

    @POST
    @Path("/trail/{trail-id}")
    @Transactional
    public Response create(@PathParam("trail-id") Long trailId, ControlPointDto controlPointDto) {
        Trail trail = Trail.findById(trailId);
        if (trail == null) {
            return Response.status(404).build();
        }

        List<FailedField> failedFields = this.validationService.getFailedFields(controlPointDto);
        if (!failedFields.isEmpty()) {
            return Response.status(422).entity(failedFields).build();
        }

        ControlPoint controlPoint = controlPointDto.map();
        controlPoint.trail = trail;
        controlPoint.persist();

        return Response.noContent().build();
    }

    @DELETE
    @Path("/{control-point-id}")
    public Response delete(@PathParam("control-point-id") Long controlPointId) {
        ControlPoint controlPoint = ControlPoint.findById(controlPointId);
        if (controlPoint == null) {
            return Response.status(404).build();
        }

        ControlPointDto controlPointDto = ControlPointDto.map(controlPoint);
        controlPoint.delete();

        return Response.ok(controlPointDto).build();
    }

    @PUT
    @Path("/{control-point-id}")
    @Transactional
    public Response update(@PathParam("control-point-id") Long controlPointId, ControlPointDto controlPointDto) {
        ControlPoint controlPoint = ControlPoint.findById(controlPointId);
        if (controlPoint == null) {
            return Response.status(404).build();
        }

        List<FailedField> failedFields = this.validationService.getFailedFields(controlPointDto);
        if (!failedFields.isEmpty()) {
            return Response.status(422).entity(failedFields).build();
        }

        controlPoint.update(controlPointDto);

        return Response.noContent().build();
    }

    @POST
    @Path("{control-point-id}/image")
    @Consumes("multipart/form-data")
    @Transactional
    public Response uploadImage(@PathParam("control-point-id") Long controlPointId, @MultipartForm FileDto fileDto) {
        ControlPoint controlPoint = ControlPoint.findById(controlPointId);
        if (controlPoint == null) {
            return Response.status(404).build();
        }

        if (fileDto.getData() == null) {
            return Response.status(400).build();
        }

        this.fileService.uploadImage(fileDto, controlPoint, new User());

        return Response.noContent().build();
    }
}
