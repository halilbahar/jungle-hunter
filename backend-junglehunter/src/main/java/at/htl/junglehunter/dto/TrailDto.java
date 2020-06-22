package at.htl.junglehunter.dto;

import at.htl.junglehunter.entity.ControlPoint;
import at.htl.junglehunter.entity.Trail;
import at.htl.junglehunter.validaton.Checks;
import at.htl.junglehunter.validaton.Unique;
import org.hibernate.validator.constraints.Length;

import javax.validation.GroupSequence;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;
import java.util.List;

@GroupSequence({TrailDto.class, Checks.Unique.class})
public class TrailDto {

    private Long id;

    @NotBlank
    @Length(min = 1, max = 100)
    @Unique(entity = Trail.class, field = "name", groups = Checks.Unique.class)
    private String name;

    @NotNull
    @Positive
    private Double length;

    private List<ControlPointDto> controlPoints;

    public TrailDto(Long id, String name, Double length, List<ControlPointDto> controlPoints) {
        this.id = id;
        this.name = name;
        this.length = length;
        this.controlPoints = controlPoints;
    }

    public TrailDto() {
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name.trim();
    }

    public Double getLength() {
        return length;
    }

    public void setLength(Double length) {
        this.length = length;
    }

    public List<ControlPointDto> getControlPoints() {
        return controlPoints;
    }

    public Trail map() {
        return new Trail(this.name, this.length);
    }

    public static TrailDto map(Trail trail) {
        return new TrailDto(
                trail.id,
                trail.name,
                trail.length,
                ControlPoint.getDtos(trail.controlPoints)
        );
    }
}
