package at.htl.junglehunter.entity;

import at.htl.junglehunter.dto.ControlPointDto;
import io.quarkus.hibernate.orm.panache.PanacheEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Entity
public class ControlPoint extends PanacheEntity {

    @Column(length = 50)
    public String name;

    public String comment;

    public String note;

    public double latitude;

    public double longitude;

    @ManyToOne
    public Trail trail;

    public ControlPoint(String name, String comment, String note, double latitude, double longitude) {
        this.name = name;
        this.comment = comment;
        this.note = note;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public ControlPoint() {
    }

    public void update(ControlPointDto controlPoint) {
        this.name = controlPoint.getName();
        this.comment = controlPoint.getComment();
        this.note = controlPoint.getNote();
        this.latitude = controlPoint.getLatitude();
        this.longitude = controlPoint.getLongitude();
    }

    public static List<ControlPointDto> getDtos(Stream<ControlPoint> entityStream) {
        return entityStream
                .map(ControlPointDto::map)
                .collect(Collectors.toList());
    }
}
