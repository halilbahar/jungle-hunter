package at.htl.junglehunter.validaton;

import io.quarkus.hibernate.orm.panache.runtime.JpaOperations;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class UniqueValidator implements ConstraintValidator<Unique, Object> {

    private Unique constraintAnnotation;

    @Override
    public void initialize(Unique constraintAnnotation) {
        this.constraintAnnotation = constraintAnnotation;
    }

    @Override
    public boolean isValid(Object value, ConstraintValidatorContext context) {
        if (value == null) {
            return true;
        }

        return JpaOperations.count(this.constraintAnnotation.entity(), this.constraintAnnotation.field(), value) == 0;
    }
}
