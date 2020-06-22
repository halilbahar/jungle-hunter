package at.htl.junglehunter.entity;

import at.htl.junglehunter.dto.TrailDto;
import io.quarkus.hibernate.orm.panache.PanacheEntity;

import javax.persistence.*;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Entity
public class Trail extends PanacheEntity {

    @Column(length = 100)
    public String name;

    public Double length;

    public Boolean hasGpx = false;

    @ManyToOne
    public Route route;

    @OneToMany(mappedBy = "trail", cascade = CascadeType.REMOVE)
    public List<ControlPoint> controlPoints;

    public Trail(String name, double length) {
        this.name = name;
        this.length = length;
    }

    public Trail() {
    }

    public void update(TrailDto trail) {
        this.name = trail.getName();
        this.length = trail.getLength();
    }

    public static List<TrailDto> getDtos(Stream<Trail> entityStream) {
        return entityStream
                .map(TrailDto::map)
                .collect(Collectors.toList());
    }
}
