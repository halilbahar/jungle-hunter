package at.htl.junglehunter.validaton;

import io.quarkus.hibernate.orm.panache.PanacheEntity;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Target(FIELD)
@Constraint(validatedBy = UniqueValidator.class)
@Retention(RUNTIME)
public @interface Unique {

    String message() default "{at.htl.junglehunter.validator.Unique.message}";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    Class<? extends PanacheEntity> entity();

    String field();
}
