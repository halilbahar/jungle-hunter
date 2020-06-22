package at.htl.junglehunter.filter;

import at.htl.junglehunter.model.FailedField;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import javax.validation.ValidationException;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Provider
public class ValidationExceptionMapper implements ExceptionMapper<ValidationException> {

    @Override
    public Response toResponse(ValidationException exception) {
        ConstraintViolationException cve = (ConstraintViolationException) exception;
        Set<ConstraintViolation<?>> violations = cve.getConstraintViolations();

        List<FailedField> failedFields = violations.stream()
                .map(o -> new FailedField(
                        o.getPropertyPath().toString(),
                        o.getInvalidValue() != null ? o.getInvalidValue().toString() : "",
                        o.getMessage()
                )).collect(Collectors.toList());
        return Response.status(422).entity(failedFields).build();
    }
}
