package at.htl.junglehunter.service;

import at.htl.junglehunter.model.FailedField;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.validation.Validator;
import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class ValidationService {

    @Inject
    Validator validator;

    public List<FailedField> getFailedFields(Object object) {
        return this.validator
                .validate(object)
                .stream()
                .map(o -> new FailedField(
                        o.getPropertyPath().toString(),
                        o.getInvalidValue() != null ? o.getInvalidValue().toString() : "",
                        o.getMessage()
                )).collect(Collectors.toList());
    }
}
