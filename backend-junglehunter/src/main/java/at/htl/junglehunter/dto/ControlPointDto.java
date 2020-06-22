package at.htl.junglehunter.dto;

import at.htl.junglehunter.entity.ControlPoint;
import at.htl.junglehunter.validaton.Unique;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

public class ControlPointDto {

    private Long id;

    @NotBlank
    @Length(min = 1, max = 50)
    @Unique(entity = ControlPoint.class, field = "name")
    private String name;

    @NotBlank
    @Length(min = 1, max = 255)
    private String comment;

    @NotBlank
    @Length(min = 1, max = 255)
    private String note;

    @NotNull
    @Range(min = -90, max = 90)
    private Double latitude;

    @NotNull
    @Range(min = -180, max = 180)
    private Double longitude;

    public ControlPointDto(Long id, String name, String comment, String note, Double latitude, Double longitude) {
        this.id = id;
        this.name = name;
        this.comment = comment;
        this.note = note;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public ControlPointDto() {
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public ControlPoint map() {
        return new ControlPoint(
                this.name,
                this.comment,
                this.note,
                this.latitude,
                this.longitude
        );
    }

    public static ControlPointDto map(ControlPoint controlPoint) {
        return new ControlPointDto(
                controlPoint.id,
                controlPoint.name,
                controlPoint.comment,
                controlPoint.note,
                controlPoint.latitude,
                controlPoint.longitude
        );
    }
}
